//
//  BankSelectionView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 29/11/21.
//

import UIKit

protocol FCBankSelectionViewDelegate: AnyObject {
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didChange bankType: BankType) // Optional
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect country: Country) // Optional
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect bank: Bank)
}

extension FCBankSelectionViewDelegate {
    // To avoid the implementation of this methods in case they're not used
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didChange bankType: BankType) {
#warning("Default implementation")
    }
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect country: Country) {
#warning("Default implementation")
    }
}

class FCBankSelectionView: UIView {
    // Components
    private lazy var mainStackView: UIStackView = setupMainStackView()
    private lazy var headerSectionView: HeaderSectionView = setupHeaderSectionView()
    private lazy var countriesSelectorView: CountriesSelectorView = setupCountriesSelectorView()
    private lazy var countryPickerDialog: BankCountryPickerDialog = setupCountryPickerDialog()
    private lazy var bankTypeSegment: UISegmentedControl = setupBankTypeSegment()
    private lazy var separatorView: UIView = setupSeparatorView()
    private lazy var tableView: UITableView = setupTableView()
    
    // Vars
    private var banks: [Bank] = [Bank]()
    private var countries: [Country] = [Country]()
    weak var delegate: FCBankSelectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {
        addComponents()
        setMainStackViewLayout()
    }
    
    //    func configureView() {
    //        title = bankViewModel.getTitle()
    //        countryPickerDialog.countryDelegate = self
    //
    //        // Add main stack
    //        setLayoutMainStackView()
    //
    //        // Show or hide components
    //        if Configuration.shared.showCountryOptions {
    //            let countryStackView = setupCountriesSelectorView()
    //            mainStackView.addArrangedSubview(countryStackView)
    //        }
    //        if Configuration.shared.showBankTypeOptions {
    //            let bankSegmentedHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
    //            bankTypeSegment.heightAnchor(equalTo: bankSegmentedHeight)
    //            mainStackView.addArrangedSubview(bankTypeSegment)
    //        }
    //
    //        let separatorView = setupSeparatorView()
    //        let tableAndSeparatorViews = [separatorView, tableView]
    //        let tableStackView = UIStackView(arrangedSubviews: tableAndSeparatorViews)
    //        tableStackView.axis = .vertical
    //
    //        mainStackView.addArrangedSubview(tableStackView)
    //
    //        // Dialog components
    //        setLayoutLoadingIndicator()
    //        setLayoutCountryPickerDialog()
    //    }
}

// MARK: - Data
extension FCBankSelectionView {
    func setCountries(_ countries: [Country]) {
        countryPickerDialog.countries = countries
        countryPickerDialog.setCountry()
    }
    
    func setBanks(_ banks: [Bank]) {
        self.banks = banks
        DispatchQueue.main.async { [weak self] in
            //            self?.loadingIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    //    func setupCountry() {
    //        // Fill country picker with data
    //        if let countries = bankViewModel?.countries {
    //            countryPickerDialog.countries = countries
    //            countryPickerDialog.setCountry()
    //        }
    //
    //        // Set initial values
    //        if let country = bankViewModel?.getCurrentCountry() {
    //            countriesSelectorView.setCountry(country)
    //        }
    //    }
    
    func configureData() {
        DispatchQueue.main.async { [weak self] in
            //            self?.loadingIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UI
extension FCBankSelectionView {
    private func setupMainStackView() -> UIStackView {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = CGFloat(20)
        
        mainStackView.layer.borderWidth = 1
        mainStackView.layer.borderColor = UIColor.lightGray.cgColor
        return mainStackView
    }
    
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
        countriesSelectorView.countryNameLabel.text = "Country name"
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
        
        let fontSize: CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        segmentControl.setTitleTextAttributes([.font: UIFont.fcRegularFont(ofSize: fontSize)], for: .normal)
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
    
    private func addComponents() {
        mainStackView.addArrangedSubview(headerSectionView)
        
        // Show or hide components
        if Configuration.shared.showCountryOptions {
            mainStackView.addArrangedSubview(countriesSelectorView)
        }
        if Configuration.shared.showBankTypeOptions {
            mainStackView.addArrangedSubview(bankTypeSegment)
        }
        
        let tableAndSeparatorViews = [separatorView, tableView]
        let tableStackView = UIStackView(arrangedSubviews: tableAndSeparatorViews)
        tableStackView.axis = .vertical
        
        mainStackView.addArrangedSubview(tableStackView)
        addSubview(mainStackView)
    }
}

// MARK: - Layouts
extension FCBankSelectionView {
    private func setMainStackViewLayout() {
        let mainBorderSpacing:CGFloat = 20
        let mainTopSpacing: CGFloat = 20
        mainStackView.topAnchor(equalTo: safeTopAnchor, constant: mainTopSpacing)
        mainStackView.leadingAnchor(equalTo: leadingAnchor, constant: mainBorderSpacing)
        mainStackView.trailingAnchor(equalTo: trailingAnchor, constant: -mainBorderSpacing)
        mainStackView.bottomAnchor(equalTo: safeBottomAnchor)
    }
}

// MARK: - Actions
extension FCBankSelectionView {
    @objc private func typeBankSelected(_ segmentedControl: UISegmentedControl) {
        let bankTypeSelected = BankType.allCases[segmentedControl.selectedSegmentIndex]
        Configuration.shared.bankType = bankTypeSelected

        delegate?.bankSelectionView(self, didChange: bankTypeSelected)
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
        if banks.count == 0 {
            tableView.setEmptyMessage(Constants.Texts.BankSection.labelEmpty)
        } else {
            tableView.restore()
        }
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let aCell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.cellIdentifier,
                                                     for: indexPath) as? BankTableViewCell {
            aCell.setup(with: banks[indexPath.row])
            cell = aCell
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FCBankSelectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell selected")
        let bank = banks[indexPath.row]
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
//
//        countryImage.setImage(with: URL(string: country.imageUrl))
//        countryLabel.text = country.name
//        startLoader()
//        bankViewModel.loadBanks()
        
        let selectedBankType = BankType.allCases.firstIndex(of: bankType)
        bankTypeSegment.selectedSegmentIndex = selectedBankType!
    }
}
