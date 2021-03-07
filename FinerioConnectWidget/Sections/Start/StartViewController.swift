//
//  StartViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 19/11/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import FirebaseDatabase
import UIKit

internal class StartViewController: BaseViewController {
    internal var startViewModel: StartViewModel!

    fileprivate lazy var titleLabel: UILabel = setupTitleLabel()
    fileprivate lazy var subtitleLabel: UILabel = setupSubtitleLabel()
    fileprivate lazy var bodyLabel: UILabel = setupBodyLabel()
    fileprivate lazy var continueButton: UIButton = setupContinueButton()

    private let indicator = ActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        startLoader()
        startViewModel = viewModel as? StartViewModel
        configureView()

        observerServiceStatus()
        startViewModel.loadBanks()
    }

    private func configureView() {
        title = startViewModel.getTitle()

        [titleLabel, subtitleLabel, bodyLabel, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        titleLabel.widthAnchor(equalTo: view.layer.frame.width - 100)
        titleLabel.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 30.0, secondValue: 50.0))
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        subtitleLabel.widthAnchor(equalTo: view.layer.frame.width - 100)
        subtitleLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: getConstraintConstant(firstValue: 25.0, secondValue: 50.0))
        subtitleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        bodyLabel.widthAnchor(equalTo: view.layer.frame.width - 100)
        bodyLabel.topAnchor(equalTo: subtitleLabel.bottomAnchor, constant: getConstraintConstant(firstValue: 25.0, secondValue: 50.0))
        bodyLabel.centerXAnchor(equalTo: view.centerXAnchor)

        continueButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        continueButton.widthAnchor(equalTo: view.frame.width - 100)
        continueButton.bottomAnchor(equalTo: view.safeBottomAnchor, constant: getConstraintConstant(firstValue: -30.0, secondValue: -50.0))
        continueButton.centerXAnchor(equalTo: view.centerXAnchor)
    }
}

// MARK: - UI

extension StartViewController {
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "¡Hola \(Configuration.shared.customerName)!"
        label.font = UIFont(name: Configuration.shared.texts.mainFont, size: 17.0)
        label.textColor = Configuration.shared.palette.mainColor
        return label
    }

    private func setupSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = fLocaleInitSubtitle.replacingOccurrences(of: Constants.Placeholders.bankName, with: Configuration.shared.texts.companyName)
        label.font = UIFont(name: Configuration.shared.texts.mainFont, size: 20.0)?.bold()
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupBodyLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Constants.Texts.InitSection.bodyLabel
        label.font = UIFont(name: Configuration.shared.texts.mainFont, size: 15.0)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupContinueButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.InitSection.titleButton, for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Configuration.shared.texts.mainFont, size: 18.0)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }
}

// MARK: - Actions

extension StartViewController {
    @objc private func goNext() {
        context?.initialize(coordinator: BankCoordinator(context: context!))
    }
}

// MARK: - Observers View Model

extension StartViewController {
    private func observerServiceStatus() {
        startViewModel?.serviceStatusHandler = { [weak self] status in
            guard let `self` = self else { return }
            self.stopLoader()
            switch status {
            case .active: break
            case .success: break
            case .loaded:
                self.continueButton.addTarget(self, action: #selector(self.goNext), for: .touchUpInside)
            case .failure:
                self.app.showAlert(self.startViewModel.errorMessage, viewController: self)
            case .updated: break
            case .interactive: break
            }
        }
    }
}
