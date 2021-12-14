//
//  BankViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class BankViewController: BaseViewController {
    // Components
//    private lazy var countriesLabel: UILabel = setupTitleLabel()
//    private lazy var selectCountriesContainerView: UIView = setupSelectCountriesContainer()
//    private lazy var countryImage: UIImageView = setupCountryImage()
//    private lazy var countryLabel: UILabel = setupCountryLabel()
//    private lazy var bankTypeSegment: UISegmentedControl = setupBankTypeSegment()
//    private lazy var tableView: UITableView = setupTableView()
//    private lazy var mainStackView: UIStackView = setupMainStackView()
    
    private lazy var bankSelectionView = FCBankSelectionView()
//    private lazy var countryPickerDialog = BankCountryPickerDialog()
//    private let loadingIndicator = ActivityIndicatorView()
    
    // Vars
//    private var bankViewModel: BankViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .white
        
//        view.backgroundColor = .white
        view.addSubview(bankSelectionView)
        bankSelectionView.delegate = self
        bankSelectionView.topAnchor(equalTo: view.safeTopAnchor)
        bankSelectionView.leadingAnchor(equalTo: view.leadingAnchor)
        bankSelectionView.trailingAnchor(equalTo: view.trailingAnchor)
        bankSelectionView.bottomAnchor(equalTo: view.safeBottomAnchor)
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        trackEvent(eventName: Constants.Events.banks)
//
//        startLoader()
//        bankViewModel = viewModel as? BankViewModel
//        configureView()
//        observerServiceStatus()
//        if Configuration.shared.showCountryOptions {
//            bankViewModel.loadCountries()
//        }
//        bankViewModel.loadBanks()
//    }
}

// MARK: - Private methods

//extension BankViewController {
//    @objc private func didTapCountrySelector() {
//        countryPickerDialog.show()
//    }

//    private func setupCountry() {
//        countryPickerDialog.countries = bankViewModel.countries
//        countryPickerDialog.setCountry()

//        let country = bankViewModel.getCurrentCountry()
//        countryImage.setImage(with: URL(string: country!.imageUrl))
//        countryLabel.text = country?.name
//    }
    
//    @objc private func typeBankSelected(_ segmentedControl: UISegmentedControl) {
//        let bankTypeSelected = BankType.allCases[segmentedControl.selectedSegmentIndex]
//        Configuration.shared.bankType = bankTypeSelected
//
//        loadingIndicator.startAnimating()
//        bankViewModel.loadBanks()
//    }
//}

// MARK: - Dialog Country Delegate

//extension BankViewController: BankPickerDialogDelegate {
//    func didSelectCountry(country: Country) {
//        Configuration.shared.countryCode = country.code
//
//        // If the bankTypeOptions is visible will reset to 'personal' bankType
//        // Otherwise, will use the configured bankType.
//        var bankType: BankType = .personal
//        if !Configuration.shared.showBankTypeOptions {
//            bankType = Configuration.shared.bankType
//        }
//
//        // Updates the banktype
//        Configuration.shared.bankType = bankType
////
////        countryImage.setImage(with: URL(string: country.imageUrl))
////        countryLabel.text = country.name
//        startLoader()
//        bankViewModel.loadBanks()
//
//        let selectedBankType = BankType.allCases.firstIndex(of: bankType)
//        bankTypeSegment.selectedSegmentIndex = selectedBankType!
//    }
//}

// MARK: - Data
//extension BankViewController {
//    private func configureData() {
//        DispatchQueue.main.async { [weak self] in
//            self?.loadingIndicator.stopAnimating()
////            self?.tableView.reloadData()
//        }
//    }
//}

// MARK: - UI
extension BankViewController {
//    private func configureView() -> Void {
//        title = bankViewModel.getTitle()
//        countryPickerDialog.countryDelegate = self
        
        // Header section
//        let headerView = HeaderSectionView()
//        headerView.titleLabel.text = Constants.Texts.BankSection.headerTitle
//        headerView.descriptionLabel.text = Constants.Texts.BankSection.headerDescription
//        headerView.setLockAvatarView()
//        mainStackView.addArrangedSubview(headerView)
        
        // Add main stack
//        setLayoutMainStackView()

        // Show or hide components
//        if Configuration.shared.showCountryOptions {
//            let countryStackView = setupCountriesSelectorView()
//            mainStackView.addArrangedSubview(countryStackView)
//        }
//        if Configuration.shared.showBankTypeOptions {
//            let bankSegmentedHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
//            bankTypeSegment.heightAnchor(equalTo: bankSegmentedHeight)
//            mainStackView.addArrangedSubview(bankTypeSegment)
//        }
        
//        let separatorView = setupSeparatorView()
//        let tableAndSeparatorViews = [separatorView, tableView]
//        let tableStackView = UIStackView(arrangedSubviews: tableAndSeparatorViews)
//        tableStackView.axis = .vertical
//        mainStackView.addArrangedSubview(tableStackView)
        
        // Dialog components
//        setLayoutLoadingIndicator()
//        setLayoutCountryPickerDialog()
//    }
    
//    private func setupSeparatorView() -> UIView {
//        let separatorView = UIView()
//        separatorView.heightAnchor(equalTo: 1)
//        separatorView.backgroundColor = Configuration.shared.palette.bankCellSeparatorColor
//        return separatorView
//    }
    
//    private func setupHeaderSection() -> Void {
//        let headerMainStack = UIStackView()
//        headerMainStack.axis = .vertical
//        headerMainStack.spacing = 12
////        headerMainStack.layer.borderWidth = 1
////        headerMainStack.layer.borderColor = UIColor.blue.cgColor
//
//        let avatarStack = UIStackView()
//        avatarStack.addArrangedSubview(headerAvatarView)
//        avatarStack.axis = .vertical
//        avatarStack.alignment = .center
//        headerMainStack.addArrangedSubview(avatarStack)
//
//        let descriptionViews = [headerTitleLabel, headerDescriptionLabel]
//        let descriptionsStack = UIStackView(arrangedSubviews: descriptionViews)
//        descriptionsStack.axis = .vertical
//        descriptionsStack.alignment = .center
//        descriptionsStack.spacing = 4
////        descriptionsStack.backgroundColor = .systemPink
//        headerMainStack.addArrangedSubview(descriptionsStack)
//
//        mainStackView.addArrangedSubview(headerMainStack)
//    }
    
//    private func setupCountriesSelectorView() -> UIView {
//        // Countries Container Selector
//        let containerHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
//        selectCountriesContainerView.heightAnchor(equalTo: containerHeight)
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer()
//        tap.addTarget(self, action: #selector(didTapCountrySelector))
//        selectCountriesContainerView.addGestureRecognizer(tap)
//
//        // Flag and country name stack
//        let flagBorderSpacing: CGFloat = 12
//        let flagSize: CGFloat = 25
//
//        let flagNameStack = UIStackView(arrangedSubviews: [countryImage, countryLabel])
//        flagNameStack.axis = .horizontal
//        flagNameStack.spacing = flagBorderSpacing
//
//        countryImage.heightAnchor(equalTo: flagSize)
//        countryImage.widthAnchor(equalTo: flagSize)
//
//        selectCountriesContainerView.addSubview(flagNameStack)
//        flagNameStack.centerYAnchor(equalTo: selectCountriesContainerView.centerYAnchor)
//        flagNameStack.leadingAnchor(equalTo: selectCountriesContainerView.leadingAnchor,
//                                    constant: flagBorderSpacing)
//        flagNameStack.trailingAnchor(equalTo: selectCountriesContainerView.trailingAnchor,
//                                     constant: -flagBorderSpacing)
//
//
//        // Countries Selector and Description label
//        let views = [countriesLabel, selectCountriesContainerView]
//        let countryStackView = UIStackView(arrangedSubviews: views)
//        countryStackView.axis = .vertical
//        countryStackView.spacing = 8
//
//        return countryStackView
//    }
    
//    private func setupMainStackView() -> UIStackView {
//        let mainStackView = UIStackView()
//        mainStackView.axis = .vertical
//        mainStackView.spacing = CGFloat(20)
//        return mainStackView
//    }
    
//    private func setupTitleLabel() -> UILabel {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.text = literal(.countriesTitle)
//        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16)
//        label.textColor = Configuration.shared.palette.mainTextColor
//        return label
//    }

//    private func setupSelectCountriesContainer() -> UIView {
//        let view = UIView()
//        view.layer.borderColor = UIColor(hex: Constants.Color.grayColor)?.cgColor
//        view.layer.borderWidth = CGFloat(1.0)
//        view.layer.cornerRadius = CGFloat(10.0)
//
//        let arrowImageView = UIImageView(image: Images.downArrow.image())
//        arrowImageView.contentMode = .center
//        view.addSubview(arrowImageView)
//        arrowImageView.widthAnchor(equalTo: 20)
//        arrowImageView.heightAnchor(equalTo: 20)
//        arrowImageView.centerYAnchor(equalTo: view.centerYAnchor)
//        arrowImageView.trailingAnchor(equalTo: view.trailingAnchor, constant: -12)
//        return view
//    }

//    private func setupCountryImage() -> UIImageView {
//        let countryImageView = UIImageView()
//        countryImageView.translatesAutoresizingMaskIntoConstraints = false
//        countryImageView.setImage(with: URL(string: Constants.Country.imageUrl))
//        countryImageView.contentMode = .scaleAspectFit
//        selectCountriesContainerView.addSubview(countryImageView)
//        return countryImageView
//    }

//    private func setupCountryLabel() -> UILabel {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16)
//        label.textColor = UIColor(hex: Constants.Color.grayColor)
//        label.frame.size = label.intrinsicContentSize
//        selectCountriesContainerView.addSubview(label)
//        return label
//    }

//    private func setupBankTypeSegment() -> UISegmentedControl {
//        let segmentControl = UISegmentedControl(items: [literal(.personalBankTitle)!, literal(.businessBankTitle)!, literal(.fiscalTitle)!])
//        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14)], for: .normal)
////        segmentControl.addTarget(self, action: #selector(typeBankSelected(_:)), for: .valueChanged)
//
//        let bankTypeSelected = Configuration.shared.bankType
//        let indexBankType = BankType.allCases.firstIndex(of: bankTypeSelected)
//
//        segmentControl.selectedSegmentIndex = indexBankType ?? 0
//        segmentControl.backgroundColor = UIColor(hex: Constants.Color.segmentColor)
//        return segmentControl
//    }
    
//    private func setupTableView() -> UITableView {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .singleLine
//        tableView.separatorColor = Configuration.shared.palette.bankCellSeparatorColor
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        tableView.separatorInsetReference = .fromCellEdges
//        tableView.register(BankTableViewCell.self,
//                           forCellReuseIdentifier: BankTableViewCell.cellIdentifier)
//        return tableView
//    }
}

// MARK: - Layouts
extension BankViewController {
//    private func setLayoutMainStackView() -> Void {
//        let mainBorderSpacing:CGFloat = 20
//        let mainTopSpacing: CGFloat = 20
//
//        view.addSubview(mainStackView)
//        mainStackView.topAnchor(equalTo: view.safeTopAnchor, constant: mainTopSpacing)
//        mainStackView.leadingAnchor(equalTo: view.leadingAnchor, constant: mainBorderSpacing)
//        mainStackView.trailingAnchor(equalTo: view.trailingAnchor, constant: -mainBorderSpacing)
//        mainStackView.bottomAnchor(equalTo: view.safeBottomAnchor)
//    }
    
//    private func setLayoutLoadingIndicator() -> Void {
//        let loadingViewSize: CGFloat = 60
//
//        view.addSubview(loadingIndicator)
//        loadingIndicator.widthAnchor(equalTo: loadingViewSize)
//        loadingIndicator.heightAnchor(equalTo: loadingViewSize)
//        loadingIndicator.centerYAnchor(equalTo: view.centerYAnchor)
//        loadingIndicator.centerXAnchor(equalTo: view.centerXAnchor)
//    }
    
//    private func setLayoutCountryPickerDialog() -> Void {
//        view.addSubview(countryPickerDialog)
//        countryPickerDialog.heightAnchor(equalTo: view.bounds.height)
//        countryPickerDialog.widthAnchor(equalTo: view.bounds.width)
//        countryPickerDialog.centerXAnchor(equalTo: view.centerXAnchor)
//        countryPickerDialog.centerYAnchor(equalTo: view.centerYAnchor)
//    }
}

// MARK: - TableView Datasource
//extension BankViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if bankViewModel.banks?.count == 0 {
//            tableView.setEmptyMessage(Constants.Texts.BankSection.labelEmpty)
//        } else {
//            tableView.restore()
//        }
//        return bankViewModel.banks?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//        if let aCell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.cellIdentifier,
//                                                     for: indexPath) as? BankTableViewCell {
//
//            aCell.setup(with: bankViewModel.banks[indexPath.row])
//            cell = aCell
//        }
//        return cell
//    }
//}

// MARK: - UITableViewDelegate
//extension BankViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let coordinator = CredentialCoordinator(context: context!,
//                                                bank: bankViewModel.banks[indexPath.row])
//        context?.initialize(coordinator: coordinator)
//    }
//}

// MARK: - Observers View Model
//extension BankViewController {
//    private func observerServiceStatus() {
//        bankViewModel?.serviceStatusHandler = { [weak self] status in
//            guard let `self` = self else { return }
//            switch status {
//            case .active, .interactive, .error, .updated: break
//            case .success:
//                self.stopLoader()
////                self.configureData()
//                if let banks = self.bankViewModel.banks {
//                    self.bankSelectionView.setBanks(banks)
//                }
//            case .loaded:
//                if let countries = self.bankViewModel.countries,
//                   let currentCountry = self.bankViewModel.getCurrentCountry() {
//                    self.bankSelectionView.setCountries(countries)
//                    self.bankSelectionView.setCurrentCountry(currentCountry)
//                }
//            case .failure:
//                self.stopLoader()
//                self.app.showAlert(self.bankViewModel.errorMessage, viewController: self)
//            }
//        }
//    }
//}

//MARK: - NEW FCBankSelectionView Delegate
extension BankViewController: FCBankSelectionViewDelegate {
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, onFailure: ServiceStatus, message: String) {
        self.showAlert(message, viewController: self)
    }
    
    func bankSelectionView(_ bankSelectionView: FCBankSelectionView, didSelect bank: Bank) {
        let coordinator = CredentialCoordinator(context: context!, bank: bank)
        context?.initialize(coordinator: coordinator)
    }
}
