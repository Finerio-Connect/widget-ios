//
//  AccountStatusViewController.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit

internal class AccountStatusViewController: BaseViewController {
    internal var accountStatusViewModel: AccountStatusViewModel!

    fileprivate lazy var animationView: AnimationView = setupAnimationView()
    fileprivate lazy var titleLabel: UILabel = setupTitleLabel()
    fileprivate lazy var subtitleLabel: UILabel = setupSubtitleLabel()
    fileprivate lazy var continueButton: UIButton = setupButton()
    fileprivate lazy var exitButton: UIButton = setupButton(color: Configuration.shared.palette.mainTextColor)

    override func viewDidLoad() {
        super.viewDidLoad()
        accountStatusViewModel = viewModel as? AccountStatusViewModel
        configureView()
    }

    private func configureView() {
        title = accountStatusViewModel.getTitle()

        [animationView, titleLabel, subtitleLabel, continueButton, exitButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        let generalWidth = view.layer.frame.width - 100

        animationView.widthAnchor(equalTo: generalWidth)
        animationView.heightAnchor(equalTo: 150)
        animationView.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 20.0, secondValue: 50.0))
        animationView.centerXAnchor(equalTo: view.centerXAnchor)

        titleLabel.widthAnchor(equalTo: generalWidth)
        titleLabel.topAnchor(equalTo: animationView.bottomAnchor)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        subtitleLabel.widthAnchor(equalTo: generalWidth)
        subtitleLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20.0)
        subtitleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        continueButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        continueButton.widthAnchor(equalTo: generalWidth)
        continueButton.centerXAnchor(equalTo: view.centerXAnchor)
        continueButton.bottomAnchor(equalTo: exitButton.topAnchor, constant: -20)

        exitButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        exitButton.widthAnchor(equalTo: generalWidth)
        exitButton.bottomAnchor(equalTo: view.safeBottomAnchor, constant: getConstraintConstant(firstValue: -20.0, secondValue: -30.0))
        exitButton.centerXAnchor(equalTo: view.centerXAnchor)
    }

    private func configureViewFailure() {
        [animationView, titleLabel, subtitleLabel, continueButton, exitButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        let generalWidth = view.layer.frame.width - 100

        animationView.widthAnchor(equalTo: generalWidth)
        animationView.topAnchor(equalTo: view.safeTopAnchor, constant: getConstraintConstant(firstValue: 20.0, secondValue: 40.0))
        animationView.centerXAnchor(equalTo: view.centerXAnchor)

        titleLabel.widthAnchor(equalTo: generalWidth)
        titleLabel.topAnchor(equalTo: animationView.bottomAnchor)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        subtitleLabel.widthAnchor(equalTo: generalWidth)
        subtitleLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 20.0)
        subtitleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        continueButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        continueButton.widthAnchor(equalTo: generalWidth)
        continueButton.centerXAnchor(equalTo: view.centerXAnchor)
        continueButton.bottomAnchor(equalTo: exitButton.topAnchor, constant: -20)

        exitButton.heightAnchor(equalTo: getConstraintConstant(firstValue: 40.0, secondValue: 50.0))
        exitButton.widthAnchor(equalTo: generalWidth)
        exitButton.bottomAnchor(equalTo: view.safeBottomAnchor, constant: getConstraintConstant(firstValue: -20.0, secondValue: -30.0))
        exitButton.centerXAnchor(equalTo: view.centerXAnchor)
    }
}

// MARK: - UI

extension AccountStatusViewController {
    private func setupAnimationView() -> AnimationView {
        var animationView = AnimationView()
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit

        if accountStatusViewModel.serviceStatus == ServiceStatus.success {
            if Configuration.shared.animations.successAnimation.isURL {
                if let animationFile = URL(string: Configuration.shared.animations.successAnimation) {
                    animationView = AnimationView(url: animationFile, closure: { _ in
                        DispatchQueue.main.async {
                            animationView.play()
                        }
                    })
                }
            } else {
                if let animation = Bundle.main.path(forResource: Configuration.shared.animations.successAnimation, ofType: "json") {
                    animationView.animation = Animation.filepath(animation)
                    animationView.play()
                }
            }
        } else {
            if Configuration.shared.animations.failureAnimation.isURL {
                if let animationFile = URL(string: Configuration.shared.animations.failureAnimation) {
                    animationView = AnimationView(url: animationFile, closure: { _ in
                        DispatchQueue.main.async {
                            animationView.play()
                        }
                    })
                }
            } else {
                if let animation = Bundle.main.path(forResource: Configuration.shared.animations.failureAnimation, ofType: "json") {
                    animationView.animation = Animation.filepath(animation)
                    animationView.play()
                }
            }
        }

        return animationView
    }

    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = accountStatusViewModel.serviceStatus == ServiceStatus.success ? Constants.Texts.StatusSection.successTitleLabel : Constants.Texts.StatusSection.failureTitleLabel
        label.textAlignment = .center
        label.font = .fcBoldFont(ofSize: 30.0)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }

    private func setupSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = accountStatusViewModel.serviceStatus == ServiceStatus.success ? Constants.Texts.StatusSection.successSubtitleLabel : "\(Constants.Texts.StatusSection.failureSubtitleLabel) \(accountStatusViewModel.errorMessage ?? "")"
        label.textAlignment = .center
        label.font = .fcRegularFont(ofSize: 16)
        label.textColor = accountStatusViewModel.serviceStatus == ServiceStatus.success ? Configuration.shared.palette.mainColor : .red
        return label
    }

    private func setupButton(color: UIColor = Configuration.shared.palette.mainColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(color == Configuration.shared.palette.mainColor ? Constants.Texts.StatusSection.successTitleButton : Constants.Texts.StatusSection.exitTitleButton, for: .normal)
        button.backgroundColor = color == Configuration.shared.palette.mainColor ? Configuration.shared.palette.mainColor : .clear
        if color == Configuration.shared.palette.mainColor {
            button.addTarget(self, action: #selector(backToBanks), for: .touchUpInside)
        }
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        button.setTitleColor(color == Configuration.shared.palette.mainColor ? .white : Configuration.shared.palette.mainColor, for: .normal)
        button.titleLabel?.font = .fcRegularFont(ofSize: 18)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = Configuration.shared.palette.mainColor.cgColor
        return button
    }
}

// MARK: - Actions

extension AccountStatusViewController {
    @objc private func backToBanks() {
        navigationController?.backToViewController(BankViewController.self)
    }

    @objc private func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}
