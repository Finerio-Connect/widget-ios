//
//  BankSelectionView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 29/11/21.
//

import UIKit

public protocol FCBankSelectionViewDelegate: AnyObject {
    func bankSelectionView(didSelect bank: Bank, nextFlowView: FCCredentialsFormView)
    func bankSelectionView(onFailure: ServiceStatus, message: String)
}

public final class FCBankSelectionView: FCBaseView {
    // Components
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var countriesSelectorView: CountriesSelectorView = setupCountriesSelectorView()
    private lazy var dropDownListView: FCDropDownListView = setupDropDownListView()
    private lazy var bankTypeSegment: UISegmentedControl = setupBankTypeSegment()
    private lazy var separatorView: UIView = setupSeparatorView()
    private lazy var tableView: UITableView = setupTableView()
    private lazy var loadingIndicator: FCLoaderAnimationView = setupLoaderAnimationView()
    
    // Vars
    public weak var delegate: FCBankSelectionViewDelegate?
    private var bankViewModel: BankViewModel = BankViewModel()
    private var tableHeight: CGFloat = 0 {
        didSet {
            // Remove old constraints
            tableView.removeConstraints(tableView.constraints)
            tableView.heightAnchor(equalTo: tableHeight)
        }
    }
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func configureView() {
        super.configureView()
        
        trackEvent(eventName: Constants.Events.banks)
        
        self.loadingView.backgroundColor = FCComponentsStyle.fullLoaderViewBackground.dynamicColor
        self.loadingView.start()
        
        observerServiceStatus()
        
        if Configuration.shared.showCountryOptions {
            bankViewModel.loadCountries()
        }
        bankViewModel.loadBanks()
        
        addComponents()
        changeStyle()
        setLayoutLoadingIndicator()
    }
}

// MARK: - UI
extension FCBankSelectionView {
    private func setupDropDownListView() -> FCDropDownListView {
        let dropDownListView = FCDropDownListView()
        
        superview?.addSubview(dropDownListView)
        let screenSize: CGRect = UIScreen.main.bounds
        dropDownListView.frame = screenSize
        
        dropDownListView.registerCell(CountryTableViewCell.self,
                                      forCellReuseIdentifier: CountryTableViewCell.cellIdentifier)
        dropDownListView.dataSource = self
        dropDownListView.delegate = self
        return dropDownListView
    }
    
    private func setupCountriesSelectorView() -> CountriesSelectorView {
        let countriesSelectorView = CountriesSelectorView()
        countriesSelectorView.delegate = self
        countriesSelectorView.heightAnchor(equalTo: 70)
        return countriesSelectorView
    }
    
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.titleLabel.text = literal(.banksHeaderTitle)
        headerView.descriptionLabel.text = literal(.banksHeaderSubtitle)
        headerView.setLockAvatarView()
        return headerView
    }
    
    private func setupBankTypeSegment() -> UISegmentedControl {
        var segmentControl = UISegmentedControl(items: [literal(.personalBankType)!,
                                                        literal(.businessBankType)!,
                                                        literal(.fiscalBankType)!])
        
        segmentControl = setupTextAttributesForSegmentControl(segmentControl)
        
        segmentControl.addTarget(self, action: #selector(typeBankSelected(_:)), for: .valueChanged)
        
        let bankTypeSelected = Configuration.shared.bankType
        let indexBankType = BankType.allCases.firstIndex(of: bankTypeSelected)
        
        let bankSegmentedHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
        segmentControl.heightAnchor(equalTo: bankSegmentedHeight)
        
        segmentControl.selectedSegmentIndex = indexBankType ?? 0
        segmentControl.removeBackgroundShadow()
        
        return segmentControl
    }
    
    private func setupTextAttributesForSegmentControl(_ segmentControl: UISegmentedControl) -> UISegmentedControl {
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 10 : 12
        
        let palette = Configuration.shared.palette
        let attributesNormal: [NSAttributedString.Key: Any] = [
            .font: UIFont.fcMediumFont(ofSize: fontSize),
            .foregroundColor: palette.banksSegmentedControlText.dynamicColor
        ]
        
        let attributesActive: [NSAttributedString.Key: Any] = [
            .font: UIFont.fcMediumFont(ofSize: fontSize),
            .foregroundColor: palette.banksSegmentedControlActiveText.dynamicColor
        ]
        
        segmentControl.setTitleTextAttributes(attributesNormal, for: .normal)
        segmentControl.setTitleTextAttributes(attributesActive, for: .selected)
        
        return segmentControl
    }
    
    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(BankTableViewCell.self,
                           forCellReuseIdentifier: BankTableViewCell.cellIdentifier)
        return tableView
    }
    
    private func setupSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.heightAnchor(equalTo: 0.25)
        return separatorView
    }
    
    private func setupLoaderAnimationView() -> FCLoaderAnimationView {
        let loaderView = FCLoaderAnimationView()
        loaderView.animationSize = 100
        loaderView.backgroundColor = .clear
        return loaderView
    }
    
    private func addComponents() {
        let margin: CGFloat = 20
        addSubview(headerSectionView)
        headerSectionView.heightAnchor(equalTo: 95)
        headerSectionView.topAnchor(equalTo: topAnchor, constant: margin)
        headerSectionView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        headerSectionView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        
        // Show or hide components
        let isShowingCountry = Configuration.shared.showCountryOptions
        let isShowingBankTypes = Configuration.shared.showBankTypeOptions
        
        if isShowingCountry && isShowingBankTypes {
            addSubview(countriesSelectorView)
            countriesSelectorView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: margin)
            countriesSelectorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            countriesSelectorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            
            addSubview(bankTypeSegment)
            bankTypeSegment.topAnchor(equalTo: countriesSelectorView.bottomAnchor, constant: margin)
            bankTypeSegment.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            bankTypeSegment.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            
            addSubview(separatorView)
            separatorView.topAnchor(equalTo: bankTypeSegment.bottomAnchor, constant: margin)
            separatorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            separatorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        } else if isShowingCountry {
            addSubview(countriesSelectorView)
            countriesSelectorView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: margin)
            countriesSelectorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            countriesSelectorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            
            addSubview(separatorView)
            separatorView.topAnchor(equalTo: countriesSelectorView.bottomAnchor, constant: margin)
            separatorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            separatorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        } else if isShowingBankTypes {
            addSubview(bankTypeSegment)
            bankTypeSegment.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: margin)
            bankTypeSegment.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            bankTypeSegment.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
            addSubview(separatorView)
            separatorView.topAnchor(equalTo: bankTypeSegment.bottomAnchor, constant: margin)
            separatorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            separatorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        } else {
            addSubview(separatorView)
            separatorView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: margin)
            separatorView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
            separatorView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        }
        
        addSubview(tableView)
        tableView.topAnchor(equalTo: separatorView.bottomAnchor)
        tableView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
        tableView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
        tableView.bottomAnchor.constraint(lessThanOrEqualTo: safeBottomAnchor).isActive = true
        
        addSubview(loadingIndicator)
    }
    
    private func calculateTableHeight() {
        let numberOfRows = self.tableView.numberOfRows(inSection: 0)
        if let rowHeight = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame.height {
            let height = CGFloat(numberOfRows) * rowHeight
            self.tableHeight = height
        }
    }
}

// MARK: - Layouts
extension FCBankSelectionView {
    private func setLayoutLoadingIndicator() -> Void {
        let loadingViewSize: CGFloat = 60
        loadingIndicator.widthAnchor(equalTo: loadingViewSize)
        loadingIndicator.heightAnchor(equalTo: loadingViewSize)
        loadingIndicator.centerYAnchor(equalTo: centerYAnchor)
        loadingIndicator.centerXAnchor(equalTo: centerXAnchor)
    }
}

// MARK: - Actions
extension FCBankSelectionView {
    @objc private func typeBankSelected(_ segmentedControl: UISegmentedControl) {
        let bankTypeSelected = BankType.allCases[segmentedControl.selectedSegmentIndex]
        Configuration.shared.bankType = bankTypeSelected
        
        loadingIndicator.start()
        bankViewModel.loadBanks()
    }
}

// MARK: - Observers View Model
extension FCBankSelectionView {
    private func observerServiceStatus() {
        bankViewModel.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            
            self.loadingView.stop()
            
            switch status {
            case .active, .interactive, .error, .updated: break
                
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.loadingIndicator.stop()
                    self?.tableView.reloadData()
                    self?.calculateTableHeight()
                }
                
            case .loaded:
                // Set currentCountry
                if let currentCountry = self.bankViewModel.getCurrentCountry() {
                    self.countriesSelectorView.countryImage.setImage(with: URL(string: currentCountry.imageUrl))
                    self.countriesSelectorView.countryNameLabel.text = currentCountry.name
                }
                
            case .failure:
                self.delegate?.bankSelectionView(onFailure: .failure, message: self.bankViewModel.errorMessage)
            }
        }
    }
}

// MARK: - CountriesPickerView Delegate
extension FCBankSelectionView: CountriesSelectorViewDelegate {
    internal func countriesPickerView(countriesSelectorView: CountriesSelectorView, didTapSelector: UILabel) {
        dropDownListView.showBelowOfComponent(countriesSelectorView)
    }
}

// MARK: - TableView Datasource
extension FCBankSelectionView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bankViewModel.banks.count == 0 {
            tableView.setEmptyMessage(literal(.titleWithoutBanks)!)
        } else {
            tableView.restore()
        }
        return bankViewModel.banks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let aCell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.cellIdentifier,
                                                     for: indexPath) as? BankTableViewCell {
            aCell.setup(with: bankViewModel.banks[indexPath.row])
            cell = aCell
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FCBankSelectionView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = bankViewModel.banks[indexPath.row]
        
        let nextView = FCCredentialsFormView()
        nextView.setBank(bank)
        
        delegate?.bankSelectionView(didSelect: bank, nextFlowView: nextView)
    }
}

// MARK: - DropDownList DataSource
extension FCBankSelectionView: FCDropDownListViewDataSource {
    internal func dropDownListView(_ dropDownListView: FCDropDownListView, numberOfRowsInSection section: Int) -> Int {
        return bankViewModel.countries.count
    }
    
    internal func dropDownListView(_ dropDownListView: FCDropDownListView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let countryCell = dropDownListView.dequeueReusableCell(withIdentifier: CountryTableViewCell.cellIdentifier,
                                                                  for: indexPath) as? CountryTableViewCell {
            let country = bankViewModel.countries[indexPath.row]
            countryCell.setCountry(country)
            cell = countryCell
        }
        return cell
    }
}

// MARK: - DropDownList Delegate
extension FCBankSelectionView: FCDropDownListViewDelegate {
    internal func dropDownListView(_ dropDownListView: FCDropDownListView, didSelectRowAt indexPath: IndexPath) {
        let country = bankViewModel.countries[indexPath.row]
        Configuration.shared.countryCode = country.code
        
        // If the bankTypeOptions is visible will reset to 'personal' bankType
        // Otherwise, will use the configured bankType.
        var bankType: BankType = .personal
        if !Configuration.shared.showBankTypeOptions {
            bankType = Configuration.shared.bankType
        }
        
        // Updates the banktype
        Configuration.shared.bankType = bankType
        
        // Updates the Current Country
        countriesSelectorView.countryImage.setImage(with: URL(string: country.imageUrl))
        countriesSelectorView.countryNameLabel.text = country.name
        
        // Updates the Segmented Control
        let selectedBankType = BankType.allCases.firstIndex(of: bankType)
        bankTypeSegment.selectedSegmentIndex = selectedBankType!
        
        self.loadingView.start()
        bankViewModel.loadBanks()
        
        dropDownListView.hide()
    }
    
    internal func dropDownListViewDidDismiss(_ dropDownListView: FCDropDownListView) {
        self.countriesSelectorView.rotateArrow(.up)
    }
}

// MARK: - Style
extension FCBankSelectionView {
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        
        loadingView.backgroundColor = FCComponentsStyle.fullLoaderViewBackground.dynamicColor
        
        backgroundColor = palette.banksBackground.dynamicColor
        headerSectionView.titleLabel.textColor = palette.banksHeaderTitle.dynamicColor
        headerSectionView.descriptionLabel.textColor = palette.banksHeaderSubtitle.dynamicColor
        headerSectionView.avatarView.tintColor = palette.banksHeaderIcon.dynamicColor
        headerSectionView.avatarView.backgroundColor = palette.banksHeaderIconBackground.dynamicColor
        
        countriesSelectorView.selectorTitleLabel.textColor = palette.banksSelectCountryLabel.dynamicColor
        countriesSelectorView.countryNameLabel.textColor = palette.banksSelectedCountryName.dynamicColor
        
        bankTypeSegment.backgroundColor = palette.banksSegmentedControlBackground.dynamicColor
        
        if #available(iOS 13.0, *) {
            bankTypeSegment.selectedSegmentTintColor = palette.banksSegmentedControlActiveItem.dynamicColor
        } else {
            bankTypeSegment.tintColor = palette.banksSegmentedControlActiveItem.dynamicColor
        }

        bankTypeSegment = setupTextAttributesForSegmentControl(bankTypeSegment)
        
        tableView.separatorColor = palette.banksListCellSeparator.dynamicColor
        separatorView.backgroundColor = palette.banksListCellSeparator.dynamicColor
    }
}
