//
//  AccountTableViewCell.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import Lottie
import UIKit

internal class AccountTableViewCell: UITableViewCell {
    static let id = "AccountsTableViewCell"

    var accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = .fcBoldFont(ofSize: UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 14.0 : 16.0)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }()

    var animationAccountLoadingView: AnimationView = {
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
    }()

    var animationAccountReadyView: AnimationView = {
        var animationView = AnimationView()
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit

        if Configuration.shared.animations.accountReadyAnimation.isURL {
            if let animationFile = URL(string: Configuration.shared.animations.accountReadyAnimation) {
                animationView = AnimationView(url: animationFile, closure: { _ in
                    DispatchQueue.main.async {
                        animationView.play()
                    }
                })
            }
        } else {
            if let animation = Bundle.main.path(forResource: Configuration.shared.animations.accountReadyAnimation, ofType: "json") {
                animationView.animation = Animation.filepath(animation)
                animationView.play()
            }
        }

        return animationView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        selectionStyle = .none
        contentView.backgroundColor = Configuration.shared.palette.backgroundColor
        contentView.addSubview(accountLabel)
        contentView.addSubview(animationAccountLoadingView)
        contentView.addSubview(animationAccountReadyView)

        accountLabel.widthAnchor(equalTo: contentView.layer.frame.width)
        accountLabel.heightAnchor(equalTo: 25)
        accountLabel.leadingAnchor(equalTo: contentView.leadingAnchor)
        accountLabel.centerXAnchor(equalTo: contentView.centerXAnchor)

        animationAccountLoadingView.widthAnchor(equalTo: 25)
        animationAccountLoadingView.heightAnchor(equalTo: 25)
        animationAccountLoadingView.trailingAnchor(equalTo: contentView.trailingAnchor)
        animationAccountLoadingView.centerYAnchor(equalTo: contentView.centerYAnchor)

        animationAccountReadyView.widthAnchor(equalTo: 25)
        animationAccountReadyView.heightAnchor(equalTo: 25)
        animationAccountReadyView.trailingAnchor(equalTo: contentView.trailingAnchor)
        animationAccountReadyView.centerYAnchor(equalTo: contentView.centerYAnchor)
    }

    func setup(with account: AccountStatus) {
        accountLabel.text = account.name

        if account.status == Constants.CredentialStatus.accountCreated {
            animationAccountReadyView.isHidden = true
            animationAccountLoadingView.play()
            animationAccountLoadingView.loopMode = .loop
        }

        if account.status == Constants.CredentialStatus.transactionsCreated && !account.loaded {
            animationAccountLoadingView.isHidden = true
            animationAccountLoadingView.stop()

            animationAccountReadyView.isHidden = false
            animationAccountReadyView.play()
            account.loaded = true
        }
    }
}
