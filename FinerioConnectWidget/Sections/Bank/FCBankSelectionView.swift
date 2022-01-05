//
//  BankSelectionView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 29/11/21.
//

import UIKit

protocol FCBankSelectionViewDelegate: AnyObject {
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect bank: Bank)
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, onFailure: ServiceStatus, message: String)
}

class FCBankSelectionView: FCBaseView {
    // Components
//    private lazy var mainStackView: UIStackView = setupMainStackView()
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var countriesSelectorView: CountriesSelectorView = setupCountriesSelectorView()
    private lazy var countryPickerDialog: BankCountryPickerDialog = setupCountryPickerDialog()
    private lazy var bankTypeSegment: UISegmentedControl = setupBankTypeSegment()
    private lazy var separatorView: UIView = setupSeparatorView()
    private lazy var tableView: UITableView = setupTableView()
    private lazy var loadingIndicator: FCLoaderAnimationView = setupLoaderAnimationView()
    
    // Vars
    private var bankViewModel: BankViewModel = BankViewModel()
    weak var delegate: FCBankSelectionViewDelegate?
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
        
        self.loadingView.backgroundColor = .white
        self.loadingView.start()
        
        observerServiceStatus()
        
        if Configuration.shared.showCountryOptions {
            bankViewModel.loadCountries()
        }
        bankViewModel.loadBanks()
        
        addComponents()
        //        setMainStackViewLayout()
        setLayoutLoadingIndicator()
    }
}

// MARK: - UI
extension FCBankSelectionView {
//    private func setupMainStackView() -> UIStackView {
//        let mainStackView = UIStackView()
//        mainStackView.axis = .vertical
//        mainStackView.alignment = .fill
//        mainStackView.distribution = .fillProportionally
//        mainStackView.spacing = CGFloat(20)
//
//        return mainStackView
//    }
    
    private func setupCountryPickerDialog() -> BankCountryPickerDialog {
        let pickerDialog = BankCountryPickerDialog()
        pickerDialog.countryDelegate = self
        
        superview?.addSubview(pickerDialog)
        let screenSize: CGRect = UIScreen.main.bounds
        pickerDialog.frame = screenSize
        return pickerDialog
    }
    
    private func setupCountriesSelectorView() -> CountriesSelectorView {
        let countriesSelectorView = CountriesSelectorView()
        countriesSelectorView.delegate = self
        countriesSelectorView.heightAnchor(equalTo: 70)
        return countriesSelectorView
    }
    
    private func setupHeaderSectionView() -> HeaderSectionView {
        let headerView = HeaderSectionView()
        headerView.titleLabel.text = Constants.Texts.BankSection.headerTitle
        headerView.descriptionLabel.text = Constants.Texts.BankSection.headerDescription
        headerView.setLockAvatarView()
        return headerView
    }
    
    private func setupBankTypeSegment() -> UISegmentedControl {
        let segmentControl = UISegmentedControl(items: [literal(.personalBankTitle)!,
                                                        literal(.businessBankTitle)!,
                                                        literal(.fiscalTitle)!])
        
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 10 : 12
        segmentControl.setTitleTextAttributes([.font: UIFont.fcMediumFont(ofSize: fontSize)], for: .normal)
        segmentControl.addTarget(self, action: #selector(typeBankSelected(_:)), for: .valueChanged)
        
        let bankTypeSelected = Configuration.shared.bankType
        let indexBankType = BankType.allCases.firstIndex(of: bankTypeSelected)
        
        let bankSegmentedHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
        segmentControl.heightAnchor(equalTo: bankSegmentedHeight)
        
        segmentControl.selectedSegmentIndex = indexBankType ?? 0
        segmentControl.backgroundColor = UIColor(hex: Constants.Color.segmentColor)
        return segmentControl
    }
    
    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = Configuration.shared.palette.bankCellSeparatorColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(BankTableViewCell.self,
                           forCellReuseIdentifier: BankTableViewCell.cellIdentifier)
        return tableView
    }
    
    private func setupSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.heightAnchor(equalTo: 1)
        let color = Configuration.shared.palette.bankCellSeparatorColor
        separatorView.backgroundColor = color
        return separatorView
    }
    
    private func setupLoaderAnimationView() -> FCLoaderAnimationView {
        let loaderView = FCLoaderAnimationView()
        loaderView.animationSize = 100
        loaderView.backgroundColor = .clear
        return loaderView
    }
    
    func addComponents() {
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
        
        ///------
//        mainStackView.addArrangedSubview(headerSectionView)
//
//        // Show or hide components
//        if Configuration.shared.showCountryOptions {
//            mainStackView.addArrangedSubview(countriesSelectorView)
//        }
//        if Configuration.shared.showBankTypeOptions {
//            mainStackView.addArrangedSubview(bankTypeSegment)
//        }
//
//        let tableAndSeparatorViews = [separatorView, tableView]
//        let tableStackView = UIStackView(arrangedSubviews: tableAndSeparatorViews)
//        tableStackView.axis = .vertical
//
//        mainStackView.addArrangedSubview(tableStackView)
//
//        addSubview(mainStackView)
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
//    private func setMainStackViewLayout() {
//        let margin: CGFloat = 20
//        mainStackView.topAnchor(equalTo: safeTopAnchor, constant: margin)
//        mainStackView.leadingAnchor(equalTo: leadingAnchor, constant: margin)
//        mainStackView.trailingAnchor(equalTo: trailingAnchor, constant: -margin)
//        mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeBottomAnchor, constant: -margin).isActive = true
////        mainStackView.bottomAnchor(equalTo: safeBottomAnchor)
//    }
    
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
            switch status {
            case .active, .interactive, .error, .updated: break
                
            case .success:
                self.loadingView.stop()
                DispatchQueue.main.async { [weak self] in
                    self?.loadingIndicator.stop()
                    self?.tableView.reloadData()
                    self?.calculateTableHeight()
                }
                
            case .loaded:
                //Set countries
                self.countryPickerDialog.countries = self.bankViewModel.countries
                self.countryPickerDialog.setCountry()
                
                // Set currentCountry
                if let currentCountry = self.bankViewModel.getCurrentCountry() {
                    self.countriesSelectorView.countryImage.setImage(with: URL(string: currentCountry.imageUrl))
                    self.countriesSelectorView.countryNameLabel.text = currentCountry.name
                }
                
            case .failure:
                self.loadingView.stop()
                
                self.delegate?.bankSelectionView(self,
                                                 onFailure: .failure,
                                                 message: self.bankViewModel.errorMessage)
            }
        }
    }
}

// MARK: - CountriesPickerView Delegate
extension FCBankSelectionView: CountriesSelectorViewDelegate {
    func countriesPickerView(_: CountriesSelectorView, didTapSelector: UILabel) {
        countryPickerDialog.show()
    }
}

// MARK: - TableView Datasource
extension FCBankSelectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bankViewModel.banks.count == 0 {
            tableView.setEmptyMessage(Constants.Texts.BankSection.labelEmpty)
        } else {
            tableView.restore()
        }
        return bankViewModel.banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = bankViewModel.banks[indexPath.row]
        delegate?.bankSelectionView(self, didSelect: bank)
    }
}

// MARK: - BankPickerDialog Delegate
extension FCBankSelectionView: BankPickerDialogDelegate {
    func didSelectCountry(country: Country) {
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
    }
}
