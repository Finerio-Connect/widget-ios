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
    private var startViewModel: StartViewModel = StartViewModel()

    private lazy var countriesLabel: UILabel = setupTitleLabel()
    private lazy var subtitleLabel: UILabel = setupSubtitleLabel()
    private lazy var bodyLabel: UILabel = setupBodyLabel()
    private lazy var continueButton: UIButton = setupContinueButton()

//    private let indicator = ActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        startViewModel = viewModel as? StartViewModel
        configureView()
    }

    private func configureView() {
//        title = startViewModel.getTitle()

        [countriesLabel, subtitleLabel, bodyLabel, continueButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        countriesLabel.widthAnchor(equalTo: view.layer.frame.width - 100)
        countriesLabel.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 30.0, secondValue: 50.0))
        countriesLabel.centerXAnchor(equalTo: view.centerXAnchor)

        subtitleLabel.widthAnchor(equalTo: view.layer.frame.width - 100)
        subtitleLabel.topAnchor(equalTo: countriesLabel.bottomAnchor, constant: getConstraintConstant(firstValue: 25.0, secondValue: 50.0))
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
        label.font = .fcRegularFont(ofSize: 17)
        label.textColor = Configuration.shared.palette.mainColor
        return label
    }

    private func setupSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = fLocaleInitSubtitle.replacingOccurrences(of: Constants.Placeholders.bankName, with: literal(.companyName) ?? "")
        label.font = .fcBoldFont(ofSize: 20)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupBodyLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Constants.Texts.InitSection.bodyLabel
        label.font = .fcRegularFont(ofSize: 15)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupContinueButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Texts.InitSection.titleButton, for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        button.titleLabel?.font = .fcRegularFont(ofSize: 18.0)
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
