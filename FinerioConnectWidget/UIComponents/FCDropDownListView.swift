//
//  FCDropDownListView.swift
//  StoryboardTests
//
//  Created by Jesus G on 18/01/22.
//

import UIKit

protocol FCDropDownListViewDataSource {
    func dropDownListView(_ dropDownListView: FCDropDownListView, numberOfRowsInSection section: Int) -> Int
    func dropDownListView(_ dropDownListView: FCDropDownListView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol FCDropDownListViewDelegate {
    func dropDownListView(_ dropDownListView: FCDropDownListView, didSelectRowAt indexPath: IndexPath)
    func dropDownListViewDidDismiss(_ dropDownListView: FCDropDownListView)
}

extension FCDropDownListViewDelegate {
    ///To be optional
    func dropDownListView(_ dropDownListView: FCDropDownListView, didSelectRowAt indexPath: IndexPath) {}
    func dropDownListViewDidDismiss(_ dropDownListView: FCDropDownListView) {}
}

class FCDropDownListView: UIView {
    /// Components
    private lazy var tableView: UITableView = setupTableView()
    /// Vars
    private var componentFrame =  CGRect()
    var dataSource: FCDropDownListViewDataSource?
    var delegate: FCDropDownListViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setViewFrame()
        addComponents()
        setDefaults()
        changeStyle()
    }
}

// MARK: - UI
extension FCDropDownListView {
    private func setViewFrame() {
        let mainBounds = UIScreen.main.bounds
        self.frame = CGRect(x: 0,
                            y: 0,
                            width: mainBounds.width,
                            height: mainBounds.height)
    }
    
    private func addComponents() {
        addSubview(tableView)
    }
    
    private func setDefaults() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hide))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
        self.superview?.bringSubviewToFront(self)
    }
    
    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 5
        /// Setings of table shadow
        tableView.layer.shadowColor = UIColor.darkGray.cgColor
        tableView.layer.shadowOffset = CGSize(width: 1, height: 1)
        tableView.layer.shadowOpacity = 0.4
        tableView.layer.shadowRadius = 5.0
        tableView.clipsToBounds = false
        tableView.layer.masksToBounds = false
        return tableView
    }
    
    private func calculateTableHeight() -> CGFloat {
        let numberOfCells = self.tableView.numberOfRows(inSection: 0)
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        let cellHeight = cell?.frame.height ?? 0.0
        let tableHeight = cellHeight * CGFloat(numberOfCells)
        return tableHeight
    }
}

// MARK: - Events
extension FCDropDownListView {
    func registerCell(_ cellClass: AnyClass, forCellReuseIdentifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func dequeueReusableCell(withIdentifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: withIdentifier, for: indexPath)
    }
    
    func showBelowOfComponent(_ component: UIView) {
        let componentFrame = component.frame
        var internalFrame: CGRect
        if let superview = self.superview {
            /// Working
            let viewReference = component.superview
            internalFrame = viewReference?.convert(componentFrame, to: superview) ?? CGRect()
        } else {
            /// Needs to be validated
            internalFrame = componentFrame
        }
        
        self.componentFrame = internalFrame
        /// Sets the initial position of the table
        tableView.frame = CGRect(x: internalFrame.origin.x,
                                 y: internalFrame.origin.y + internalFrame.height,
                                 width: internalFrame.width,
                                 height: 0)
        
        self.tableView.reloadData()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut) { [weak self] in
            self?.isHidden = false
            let tableHeight = self?.calculateTableHeight()
            /// Animates the table to the final position-height
            self?.tableView.frame = CGRect(x: internalFrame.origin.x,
                                           y: internalFrame.origin.y + internalFrame.height,
                                           width: internalFrame.width,
                                           height: tableHeight ?? CGFloat(0))
        }
    }
    
    @objc func hide() {
        let frame = self.componentFrame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut) { [unowned self] in
            self.tableView.frame = CGRect(x: frame.origin.x,
                                          y: frame.origin.y + frame.height,
                                          width: frame.width,
                                          height: 0)
            self.isHidden = true
            self.delegate?.dropDownListViewDidDismiss(self)
        }
    }
}

//MARK: - Gesture Recognizer Delegate
extension FCDropDownListView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        /// To prevent conflicts with the cell selection and the TapGesture to dismiss.
        if touch.view != nil && touch.view!.isDescendant(of: self.tableView) {
            return false
        }
        return true
    }
}

// MARK: - TableView DataSource
extension FCDropDownListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.dropDownListView(self, numberOfRowsInSection: section) ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.dropDownListView(self, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate
extension FCDropDownListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.dropDownListView(self, didSelectRowAt: indexPath)
    }
}

// MARK: - Style
extension FCDropDownListView {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        tableView.backgroundColor = palette.fieldsBackground.dynamicColor
    }
}
