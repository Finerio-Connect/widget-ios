//
//  AccountViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit
import nanopb

internal class AccountViewController: BaseViewController {
    // Components
    private lazy var accountsTableView: UITableView = setupAccountsTableView()
    private lazy var animationAccountLoadingView: AnimationView = setupAnimationAccountLoadingView()
    private lazy var statusDescriptionLabel: UILabel = setupStatusDescriptionLabel()
    // Vars
    private var accountViewModel: AccountViewModel!
    var credentialToken = CredentialToken(widgetId: Configuration.shared.widgetId)

    override func viewDidLoad() {
        super.viewDidLoad()
                
        trackEvent(eventName: Constants.Events.createCredential)

        accountViewModel = viewModel as? AccountViewModel
        configureView()
        observerServiceStatus()
        accountViewModel.firebaseObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        accountViewModel.databaseReference.removeAllObservers()
    }
    
    private func configureView() {
        navigationController?.navigationBar.isHidden = true
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.alignment = .center
        mainStack.spacing = 45
        
        let headerSectionView = HeaderSectionView()
        headerSectionView.avatarView.setImage(with: URL(string: Constants.URLS.bankImageShield.replacingOccurrences(of: Constants.Placeholders.bankCode, with: accountViewModel.bank.code)), defaultImage: Images.otherBanksOff.image())

        headerSectionView.titleLabel.text = Constants.Texts.AccountSection.headerTitle
        headerSectionView.descriptionLabel.text = Constants.Texts.AccountSection.headerDescription
        mainStack.addArrangedSubview(headerSectionView)
        
        let animationSize = CGFloat(99)
        animationAccountLoadingView.heightAnchor(equalTo: animationSize)
        animationAccountLoadingView.widthAnchor(equalTo: animationSize)
        mainStack.addArrangedSubview(animationAccountLoadingView)
        
        mainStack.addArrangedSubview(statusDescriptionLabel)
        mainStack.addArrangedSubview(accountsTableView)
        
        view.addSubview(mainStack)
        mainStack.topAnchor(equalTo: view.safeTopAnchor, constant: 20)
        mainStack.leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
        mainStack.trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
        mainStack.bottomAnchor(equalTo: view.safeBottomAnchor)
        
//        view.addSubview(headerSectionView)
//        headerSectionView.topAnchor(equalTo: view.safeTopAnchor)
//        headerSectionView.leadingAnchor(equalTo: view.leadingAnchor)
//        headerSectionView.trailingAnchor(equalTo: view.trailingAnchor)
//
//        view.addSubview(animationAccountLoadingView)
//        animationAccountLoadingView.topAnchor(equalTo: headerSectionView.bottomAnchor, constant: 70)
//        animationAccountLoadingView.heightAnchor(equalTo: 99)
//        animationAccountLoadingView.widthAnchor(equalTo: 99)
//        animationAccountLoadingView.centerXAnchor(equalTo: headerSectionView.centerXAnchor)
//
//        view.addSubview(statusDescriptionLabel)
//        statusDescriptionLabel.topAnchor(equalTo: animationAccountLoadingView.bottomAnchor)
//        statusDescriptionLabel.centerXAnchor(equalTo: view.centerXAnchor)
//
//        view.addSubview(accountsTableView)
//        accountsTableView.topAnchor(equalTo: statusDescriptionLabel.bottomAnchor)
//        accountsTableView.bottomAnchor(equalTo: view.bottomAnchor)
//        accountsTableView.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
//        accountsTableView.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)
    }
}

// MARK: - UI

extension AccountViewController {
    private func setupAccountsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.id)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? true : false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = view.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func setupAnimationAccountLoadingView() -> AnimationView {
        var animationView = AnimationView()
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        
        if Configuration.shared.animations.loadingAccountAnimation.isURL {
            if let animationFile = URL(string: Configuration.shared.animations.loadingAccountAnimation) {
                animationView = AnimationView(url: animationFile, closure: { _ in
                    DispatchQueue.main.async {
                        animationView.play()
                        animationView.loopMode = .loop
                    }
                })
            }
        } else {
            if let animation = Bundle.main.path(forResource: Configuration.shared.animations.loadingAccountAnimation, ofType: "json") {
                animationView.animation = Animation.filepath(animation)
                animationView.play()
                animationView.loopMode = .loop
            }
        }
        return animationView
    }
    
    private func setupStatusDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Configuration.shared.palette.mainTextColor
        label.font = .fcBoldFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14.0 : 16.0)
        label.text = "Encriptando tus datos..."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
}

// MARK: - Actions

extension AccountViewController {
    private func showAlertToken() {
        let alert = UIAlertController(title: Constants.Texts.AccountSection.titleAlertToken, message: Constants.Texts.AccountSection.labelAlertToken, preferredStyle: .alert)

        alert.addTextField { textfield in
            textfield.keyboardType = .numberPad
        }

        let action = UIAlertAction(title: Constants.Texts.AccountSection.titleButton, style: .default, handler: { (_: UIAlertAction) in
            if let textFields = alert.textFields {
                let textFieldToken = (textFields as [UITextField]).first
                let token = textFieldToken?.text
                self.credentialToken.token = token ?? ""
                self.credentialToken.id = self.accountViewModel.credentialId

                self.accountViewModel.updateCredentialToken(credentialToken: self.credentialToken)
            }
        })
        alert.addAction(action)

        if let token = accountViewModel.token {
            alert.message = Constants.Texts.AccountSection.firstLabelAlertToken

            present(alert, animated: true, completion: {
                let margin: CGFloat = 5.0

                let labelToken = UILabel(frame: CGRect(x: margin, y: 72.0, width: alert.view.frame.width - margin * 2.0, height: 20))
                labelToken.text = token
                labelToken.textAlignment = .center
                labelToken.adjustsFontSizeToFitWidth = true
                labelToken.minimumScaleFactor = 0.5
                alert.view.addSubview(labelToken)
            })

            return
        }

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Observers View Model

extension AccountViewController {
    private func observerServiceStatus() {
        accountViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.stopLoader()
            switch status {
            case .active, .loaded, .error: break
            case .success:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .success, bank: self.accountViewModel.bank))
                self.trackEvent(eventName: Constants.Events.credentialCreated)
            case .failure:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .failure, errorMessage: self.accountViewModel.errorMessage, bank: self.accountViewModel.bank))
            case .updated:
                print("UPDATED: \(self.accountViewModel.accounts.map({$0.name}))")
                self.accountsTableView.reloadData()
            case .interactive:
                self.showAlertToken()
            }
        }
    }
}

// MARK: UITableViewDataSource

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.id, for: indexPath) as? AccountTableViewCell else {
            fatalError("Could not cast AccountTableViewCell")
        }

        cell.setup(with: accountViewModel.accounts[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25.0
    }
}
