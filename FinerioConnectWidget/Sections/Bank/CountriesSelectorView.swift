//
//  CountriesPickerView.swift
//  FinerioAccountWidget
//
//  Created by Jesus G on 29/11/21.
//

import UIKit

// MARK: - Countries Picker View
protocol CountriesSelectorViewDelegate: AnyObject {
    func countriesPickerView(countriesSelectorView: CountriesSelectorView, didTapSelector: UILabel)
}

class CountriesSelectorView: UIView {
    // Components
    lazy var countryImage: UIImageView = setupCountryImage()
    lazy var countryNameLabel: UILabel = setupCountryLabel()
    lazy var selectorTitleLabel: UILabel = setupTitleLabel()
    lazy var roundedContainerView: UIView = setupRoundedContainerView()
    lazy var arrowImageView: UIImageView = UIImageView()
    
    // Vars
    weak var delegate: CountriesSelectorViewDelegate?
    
    // Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

// MARK: - Data
extension CountriesSelectorView {
    func setCountry(_ country: Country) {
        countryImage.setImage(with: URL(string: country.imageUrl))
        countryNameLabel.text = country.name
    }
}

// MARK: - UI
extension CountriesSelectorView {
    func configureView() {
        // Flag and country name stack
        let flagBorderSpacing: CGFloat = 12
        let flagNameStack = UIStackView(arrangedSubviews: [countryImage, countryNameLabel])
        flagNameStack.axis = .horizontal
        flagNameStack.spacing = flagBorderSpacing
        
        roundedContainerView.addSubview(flagNameStack)
        flagNameStack.centerYAnchor(equalTo: roundedContainerView.centerYAnchor)
        flagNameStack.leadingAnchor(equalTo: roundedContainerView.leadingAnchor,
                                    constant: flagBorderSpacing)
        flagNameStack.trailingAnchor(equalTo: roundedContainerView.trailingAnchor,
                                     constant: -flagBorderSpacing)
        
        
        // Countries Selector and Description label
        let views = [selectorTitleLabel, roundedContainerView]
        let countryStackView = UIStackView(arrangedSubviews: views)
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        
        addSubview(countryStackView)
        countryStackView.topAnchor(equalTo: topAnchor)
        countryStackView.leadingAnchor(equalTo: leadingAnchor)
        countryStackView.trailingAnchor(equalTo: trailingAnchor)
        changeStyle()
    }
    
    private func commonSetupLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        let fontSize:CGFloat = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 14 : 16
        label.font = .fcRegularFont(ofSize: fontSize)
        return label
    }
    
    private func setupTitleLabel() -> UILabel {
        let label = commonSetupLabel()
        label.text = literal(.selectCountryLabel)
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        label.font = .fcRegularFont(ofSize: CGFloat(fontSize))
        return label
    }
    
    private func setupCountryLabel() -> UILabel {
        let label = commonSetupLabel()
        let fontSize = UIDevice.current.screenType == .iPhones_6_6s_7_8 ? 12 : 14
        label.font = .fcMediumFont(ofSize: CGFloat(fontSize))
        label.frame.size = label.intrinsicContentSize
        roundedContainerView.addSubview(label)
        return label
    }
    
    private func setupCountryImage() -> UIImageView {
        let countryImageView = UIImageView()
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        countryImageView.setImage(with: URL(string: Constants.Country.imageUrl))
        countryImageView.contentMode = .scaleAspectFit
        
        let flagSize: CGFloat = 25
        countryImageView.heightAnchor(equalTo: flagSize)
        countryImageView.widthAnchor(equalTo: flagSize)
        
        roundedContainerView.addSubview(countryImageView)
        return countryImageView
    }
    
    private func setupRoundedContainerView() -> UIView {
        let roundedView = UIView()
        roundedView.layer.borderWidth = CGFloat(1.0)
        roundedView.layer.cornerRadius = CGFloat(10.0)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapCountrySelector))
        roundedView.addGestureRecognizer(tap)
        roundedView.isUserInteractionEnabled = true
        
        let containerHeight = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? 35.0 : 40.0
        roundedView.heightAnchor(equalTo: containerHeight)
        
        arrowImageView = UIImageView(image: Images.downArrow.image())
        arrowImageView.contentMode = .center
        roundedView.addSubview(arrowImageView)
        
        let sizeImg: CGFloat = 20
        arrowImageView.widthAnchor(equalTo: sizeImg)
        arrowImageView.heightAnchor(equalTo: sizeImg)
        arrowImageView.centerYAnchor(equalTo: roundedView.centerYAnchor)
        arrowImageView.trailingAnchor(equalTo: roundedView.trailingAnchor, constant: -12)
        return roundedView
    }
    
    enum RotateAngle {
        case up
        case down
    }
    
    func rotateArrow(_ rotate: RotateAngle) {
        UIView.animate(withDuration: 0.2) {[weak self] in
            switch rotate {
            case .up:
                self?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            case .down:
                self?.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }
        }
    }
}

// MARK: - Actions
extension CountriesSelectorView {
    @objc private func didTapCountrySelector() {
        rotateArrow(.down)
        delegate?.countriesPickerView(countriesSelectorView: self,
                                      didTapSelector: countryNameLabel)
    }
}

// MARK: - Style
extension CountriesSelectorView {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        changeStyle()
    }
    
    private func changeStyle() {
        let palette = Configuration.shared.palette
        roundedContainerView.backgroundColor = palette.fieldsBackground.dynamicColor
        roundedContainerView.layer.borderColor = palette.fieldsBorder.dynamicColor.cgColor
        arrowImageView.tintColor = palette.dropDownMenuTint.dynamicColor
    }
}
