//
//  Popup.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 31/03/21.
//

import UIKit

internal class Popup: UIView {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: Configuration.shared.texts.mainFont, size: 20)
        label.textColor = Configuration.shared.palette.mainTextColor
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.backgroundColor = Configuration.shared.palette.mainColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Configuration.shared.texts.mainFont, size: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 15 : 18)
        button.addTarget(self, action: #selector(animateScaleOut), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 15 : 16
        button.heightAnchor(equalTo: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 30.0 : 32)
        button.widthAnchor(equalTo: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 30.0 : 32)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(_ gifImage: UIImage?) {
        if let image = gifImage {
            imageView.image = image
        }
    }
    
    func setMessage(_ text: String) {
        messageLabel.text = text
    }

    fileprivate func animateIn() {
        containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        containerView.alpha = 0

        UIView.animate(withDuration: 0.2) {
            self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.containerView.alpha = 1
        }
    }

    @objc fileprivate func animateScaleOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.containerView.alpha = 0
        }, completion: { (_: Bool) in
            self.removeFromSuperview()
        })
    }

    fileprivate func setupView() {
        backgroundColor = .gray.withAlphaComponent(0.8)

        let tap = UITapGestureRecognizer(target: self, action: #selector(animateScaleOut))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)

        addSubview(containerView)
        containerView.centerXAnchor(equalTo: centerXAnchor)
        containerView.centerYAnchor(equalTo: centerYAnchor)
        containerView.widthAnchor(equalTo: widthAnchor, multiplier: 0.85)
        containerView.heightAnchor(equalTo: heightAnchor, multiplier: 0.45)

        containerView.addSubview(imageView)
        imageView.centerXAnchor(equalTo: containerView.centerXAnchor)
        imageView.centerYAnchor(equalTo: containerView.centerYAnchor)
        imageView.widthAnchor(equalTo: containerView.widthAnchor)
        
        containerView.addSubview(messageLabel)
        messageLabel.centerXAnchor(equalTo: containerView.centerXAnchor)
        messageLabel.centerYAnchor(equalTo: containerView.centerYAnchor)
        messageLabel.widthAnchor(equalTo: containerView.widthAnchor)

        containerView.addSubview(closeButton)
        closeButton.topAnchor(equalTo: containerView.topAnchor, constant: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 0 : 15.0)
        closeButton.trailingAnchor(equalTo: containerView.trailingAnchor, constant: UIDevice.current.screenType == .iPhones_6_6s_7_8 ? -7.5 : -15.0)

        animateIn()
    }
}
