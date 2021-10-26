//
//  BankViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import UIKit

internal class BankViewController: BaseViewController {
    private var bankViewModel: BankViewModel!

    private lazy var countriesLabel: UILabel = setupTitleLabel()
    private lazy var selectCountriesContainerView: UIView = setupSelectCountriesContainer()
    private lazy var countryImage: UIImageView = setupCountryImage()
    private lazy var countryLabel: UILabel = setupCountryLabel()
    private lazy var bankTypeSegment: UISegmentedControl = setupBankTypeSegment()
    private lazy var collectionViewBanks: UICollectionView = setupCollectionViewBanks()

    private lazy var countryPickerDialog = BankCountryPickerDialog()
    private let loadingIndicator = ActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        trackEvent(eventName: Constants.Events.banks)
        
        startLoader()
        bankViewModel = viewModel as? BankViewModel
        configureView()
        observerServiceStatus()
        if Configuration.shared.showCountryOptions {
            bankViewModel.loadCountries()
        }
        bankViewModel.loadBanks()
    }
    
    private func configureView() {
        title = bankViewModel.getTitle()
        countryPickerDialog.countryDelegate = self
        
        // Main Stack
        let mainBorderSpacing:CGFloat = 30
        let mainTopSpacing: CGFloat = 20
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = mainTopSpacing
        
        view.addSubview(mainStackView)
        mainStackView.topAnchor(equalTo: view.safeTopAnchor, constant: mainTopSpacing)
        mainStackView.leadingAnchor(equalTo: view.leadingAnchor, constant: mainBorderSpacing)
        mainStackView.trailingAnchor(equalTo: view.trailingAnchor, constant: -mainBorderSpacing)
        mainStackView.bottomAnchor(equalTo: view.safeBottomAnchor)
        
        let countryStackView = setupCountriesSelectorView()
        
//        // Countries Container Selector
//        let containerHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
//        selectCountriesContainerView.heightAnchor(equalTo: containerHeight)
//
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCountrySelector))
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
//        // Countries Selector and Label
//        let views = [countriesLabel, selectCountriesContainerView]
//        let countryStackView = UIStackView(arrangedSubviews: views)
//        countryStackView.axis = .vertical
//        countryStackView.spacing = 8
        
        // Bank type segment
        let containerHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
        bankTypeSegment.heightAnchor(equalTo: containerHeight)
        
        if Configuration.shared.showCountryOptions {
            mainStackView.addArrangedSubview(countryStackView)
        }
        if Configuration.shared.showBankTypeOptions {
            mainStackView.addArrangedSubview(bankTypeSegment)
        }
        mainStackView.addArrangedSubview(collectionViewBanks)
        
        // Dialog components
        let loadingViewSize: CGFloat = 60
        view.addSubview(loadingIndicator)
        loadingIndicator.widthAnchor(equalTo: loadingViewSize)
        loadingIndicator.heightAnchor(equalTo: loadingViewSize)
        loadingIndicator.centerYAnchor(equalTo: view.centerYAnchor)
        loadingIndicator.centerXAnchor(equalTo: view.centerXAnchor)

        view.addSubview(countryPickerDialog)
        countryPickerDialog.heightAnchor(equalTo: view.bounds.height)
        countryPickerDialog.widthAnchor(equalTo: view.bounds.width)
        countryPickerDialog.centerXAnchor(equalTo: view.centerXAnchor)
        countryPickerDialog.centerYAnchor(equalTo: view.centerYAnchor)
    }
    
    private func setupCountriesSelectorView() -> UIView {
        // Countries Container Selector
        let containerHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
        selectCountriesContainerView.heightAnchor(equalTo: containerHeight)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCountrySelector))
        selectCountriesContainerView.addGestureRecognizer(tap)
        
        // Flag and country name stack
        let flagBorderSpacing: CGFloat = 12
        let flagSize: CGFloat = 25
        
        let flagNameStack = UIStackView(arrangedSubviews: [countryImage, countryLabel])
        flagNameStack.axis = .horizontal
        flagNameStack.spacing = flagBorderSpacing
        
        countryImage.heightAnchor(equalTo: flagSize)
        countryImage.widthAnchor(equalTo: flagSize)
        
        selectCountriesContainerView.addSubview(flagNameStack)
        flagNameStack.centerYAnchor(equalTo: selectCountriesContainerView.centerYAnchor)
        flagNameStack.leadingAnchor(equalTo: selectCountriesContainerView.leadingAnchor,
                                    constant: flagBorderSpacing)
        flagNameStack.trailingAnchor(equalTo: selectCountriesContainerView.trailingAnchor,
                                     constant: -flagBorderSpacing)
        
        
        // Countries Selector and Label
        let views = [countriesLabel, selectCountriesContainerView]
        let countryStackView = UIStackView(arrangedSubviews: views)
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        
        return countryStackView
    }

    private func OLDconfigureView() {
        title = bankViewModel.getTitle()

        countryPickerDialog.countryDelegate = self

        [bankTypeSegment, collectionViewBanks, countryPickerDialog, loadingIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        if Configuration.shared.showCountryOptions {
            [countriesLabel, selectCountriesContainerView].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview($0)
            }

            countriesLabel.topAnchor(equalTo: view.safeTopAnchor, constant: 20)
            countriesLabel.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
            countriesLabel.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)

            selectCountriesContainerView.topAnchor(equalTo: countriesLabel.bottomAnchor, constant: 8)
            selectCountriesContainerView.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0)
            selectCountriesContainerView.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
            selectCountriesContainerView.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)

            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCountrySelector))
            selectCountriesContainerView.addGestureRecognizer(tap)

            countryImage.widthAnchor(equalTo: 25)
            countryImage.heightAnchor(equalTo: 25)
            countryImage.centerYAnchor(equalTo: selectCountriesContainerView.centerYAnchor)
            countryImage.leadingAnchor(equalTo: selectCountriesContainerView.leadingAnchor, constant: 12)

            countryLabel.centerYAnchor(equalTo: selectCountriesContainerView.centerYAnchor)
            countryLabel.leadingAnchor(equalTo: countryImage.trailingAnchor, constant: 12)
        }

        bankTypeSegment.topAnchor(equalTo: Configuration.shared.showCountryOptions ? selectCountriesContainerView.bottomAnchor : view.safeTopAnchor, constant: 20)
        bankTypeSegment.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0)
        bankTypeSegment.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
        bankTypeSegment.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)

        collectionViewBanks.topAnchor(equalTo: bankTypeSegment.bottomAnchor, constant: 20)
        collectionViewBanks.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
        collectionViewBanks.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)
        collectionViewBanks.bottomAnchor(equalTo: view.safeBottomAnchor, constant: -30)

        loadingIndicator.widthAnchor(equalTo: 60)
        loadingIndicator.heightAnchor(equalTo: 60)
        loadingIndicator.topAnchor(equalTo: bankTypeSegment.bottomAnchor, constant: 25)
        loadingIndicator.centerXAnchor(equalTo: view.centerXAnchor)

        countryPickerDialog.centerXAnchor(equalTo: view.centerXAnchor)
        countryPickerDialog.centerYAnchor(equalTo: view.centerYAnchor)
        countryPickerDialog.heightAnchor(equalTo: view.bounds.height)
        countryPickerDialog.widthAnchor(equalTo: view.bounds.width)
    }

    private func configureData() {
        loadingIndicator.stopAnimating()
        collectionViewBanks.reloadData()
    }
}

// MARK: - Private methods

extension BankViewController {
    @objc private func didTapCountrySelector() {
        print("DID TAP COUNTRY SELECTOR")
        countryPickerDialog.show()
    }

    private func setupCountry() {
        countryPickerDialog.countries = bankViewModel.countries
        countryPickerDialog.setCountry()

        let country = bankViewModel.getCurrentCountry()
        countryImage.setImage(with: URL(string: country!.imageUrl))
        countryLabel.text = country?.name
    }

    @objc private func typeBankSelected(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            Configuration.shared.bankType = Constants.Country.bankType.personal
        case 1:
            Configuration.shared.bankType = Constants.Country.bankType.business
        default:
            Configuration.shared.bankType = Constants.Country.bankType.fiscal
        }

        loadingIndicator.startAnimating()
        bankViewModel.loadBanks()
    }
}

// MARK: Dialog Country Delegate

extension BankViewController: BankPickerDialogDelegate {
    func didSelectCountry(country: Country) {
        Configuration.shared.countryCode = country.code
        Configuration.shared.bankType = Constants.Country.bankType.personal
        countryImage.setImage(with: URL(string: country.imageUrl))
        countryLabel.text = country.name
        startLoader()
        bankViewModel.loadBanks()
        bankTypeSegment.selectedSegmentIndex = 0
    }
}

// MARK: - UI

extension BankViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = literal(.countriesTitle)
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupSelectCountriesContainer() -> UIView {
        let view = UIView()
        view.layer.borderColor = UIColor(hex: Constants.Color.grayColor)?.cgColor
        view.layer.borderWidth = CGFloat(1.0)
        view.layer.cornerRadius = CGFloat(10.0)

        let arrowImageView = UIImageView(image: Images.downArrow.image())
        arrowImageView.contentMode = .center
        view.addSubview(arrowImageView)
        arrowImageView.widthAnchor(equalTo: 20)
        arrowImageView.heightAnchor(equalTo: 20)
        arrowImageView.centerYAnchor(equalTo: view.centerYAnchor)
        arrowImageView.trailingAnchor(equalTo: view.trailingAnchor, constant: -12)
        return view
    }

    private func setupCountryImage() -> UIImageView {
        let countryImageView = UIImageView()
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        countryImageView.setImage(with: URL(string: Constants.Country.imageUrl))
        countryImageView.contentMode = .scaleAspectFit
        selectCountriesContainerView.addSubview(countryImageView)
        return countryImageView
    }

    private func setupCountryLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16)
        label.textColor = UIColor(hex: Constants.Color.grayColor)
        label.frame.size = label.intrinsicContentSize
        selectCountriesContainerView.addSubview(label)
        return label
    }

    private func setupBankTypeSegment() -> UISegmentedControl {
        let segmentControl = UISegmentedControl(items: [literal(.personalBankTitle)!, literal(.businessBankTitle)!, literal(.fiscalTitle)!])
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.fcRegularFont(ofSize: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14)], for: .normal)
        segmentControl.addTarget(self, action: #selector(typeBankSelected(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor(hex: Constants.Color.segmentColor)
        return segmentControl
    }

    private func setupCollectionViewBanks() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(BankCollectionViewCell.self, forCellWithReuseIdentifier: BankCollectionViewCell.id)
        return collectionView
    }
}

// MARK: - Observers View Model

extension BankViewController {
    private func observerServiceStatus() {
        bankViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            switch status {
            case .active, .interactive, .error, .updated: break
            case .success:
                self.stopLoader()
                self.configureData()
            case .loaded:
                self.setupCountry()
            case .failure:
                self.stopLoader()
                self.app.showAlert(self.bankViewModel.errorMessage, viewController: self)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BankViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if bankViewModel.banks?.count == 0 {
            collectionViewBanks.setEmptyMessage(Constants.Texts.BankSection.labelEmpty)
        } else {
            collectionViewBanks.restore()
        }

        return bankViewModel.banks?.count ?? 0
    }
}

extension BankViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankCollectionViewCell.id, for: indexPath as IndexPath) as! BankCollectionViewCell
        cell.setup(with: bankViewModel.banks[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        context?.initialize(coordinator: CredentialCoordinator(context: context!, bank: bankViewModel.banks[indexPath.row]))
    }
}

extension BankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.size.width - 25

        return CGSize(width: collectionWidth / 2, height: 100)
    }
}
