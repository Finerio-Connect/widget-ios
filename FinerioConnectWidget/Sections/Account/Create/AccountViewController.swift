//
//  AccountViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 08/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit

internal class AccountViewController: BaseViewController {
    internal var accountViewModel: AccountViewModel!

    fileprivate lazy var titleLabel: UILabel = setupTitleLabel()
    fileprivate lazy var animationView: AnimationView = setupAnimationView()
    fileprivate lazy var accountsTableView: UITableView = setupAccountsTableView()

    var credentialToken = CredentialToken(widgetId: Configuration.shared.widgetId)

    override func viewDidLoad() {
        super.viewDidLoad()
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
        title = accountViewModel.getTitle()

        [titleLabel, animationView, accountsTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        let generalWidth = view.layer.frame.width - 100

        titleLabel.widthAnchor(equalTo: generalWidth)
        titleLabel.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 20.0, secondValue: 50.0))
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        animationView.widthAnchor(equalTo: generalWidth)
        animationView.heightAnchor(equalTo: 150)
        animationView.topAnchor(equalTo: titleLabel.bottomAnchor)
        animationView.centerXAnchor(equalTo: view.centerXAnchor)

        accountsTableView.topAnchor(equalTo: animationView.bottomAnchor)
        accountsTableView.bottomAnchor(equalTo: view.bottomAnchor)
        accountsTableView.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
        accountsTableView.trailingAnchor(equalTo: view.trailingAnchor, constant: -30)
    }
}

// MARK: - UI

extension AccountViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Configuration.shared.texts.synchronizationTitle
        label.font = .fcBoldFont(ofSize: getConstraintConstant(firstValue: 16.0, secondValue: 20.0))
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupAnimationView() -> AnimationView {
        var animationView = AnimationView()
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit

        if Configuration.shared.animations.syncingAnimation.isURL {
            if let animationFile = URL(string: Configuration.shared.animations.syncingAnimation) {
                animationView = AnimationView(url: animationFile, closure: { _ in
                    DispatchQueue.main.async {
                        animationView.play()
                        animationView.loopMode = .loop
                    }
                })
            }
        } else {
            if let animation = Bundle.main.path(forResource: Configuration.shared.animations.syncingAnimation, ofType: "json") {
                animationView.animation = Animation.filepath(animation)
                animationView.play()
                animationView.loopMode = .loop
            }
        }

        return animationView
    }

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
            case .active: break
            case .success:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .success))
            case .loaded: break
            case .failure:
                self.context?.initialize(coordinator: AccountStatusCoordinator(context: self.context!, serviceStatus: .failure, errorMessage: self.accountViewModel.errorMessage))
            case .updated:
                self.accountsTableView.reloadData()
            case .interactive:
                self.showAlertToken()
            case .error: break
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
