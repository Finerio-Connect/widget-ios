//
//  Texts.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

public final class Texts: NSObject {
    public var companyName: String
    public var banksTitle: String
    public var submitLabel: String
    public var createCredentialTitle: String
    public var synchronizationTitle: String
    public var privacyTermsUrl: String
    public var termsAndConditionsUrl: String
    public var mainFont: String

    @objc public init(
        companyName: String = fLocaleCompanyName,
        banksTitle: String = fLocaleBanksTitle,
        createCredentialTitle: String = fLocaleCreateCredentialTitle,
        submitLabel: String = fLocaleSubmitLabel,
        synchronizationTitle: String = fLocaleSynchronizationTitle,
        privacyTermsUrl: String = fLocalePrivacyTermsUrl,
        termsAndConditionsUrl: String = fLocaletermsAndConditionsUrl,
        mainFont: String = "Helvetica") {
        self.companyName = companyName
        self.banksTitle = banksTitle
        self.createCredentialTitle = createCredentialTitle
        self.submitLabel = submitLabel
        self.synchronizationTitle = synchronizationTitle
        self.privacyTermsUrl = privacyTermsUrl
        self.termsAndConditionsUrl = termsAndConditionsUrl
        self.mainFont = mainFont
    }
}

enum Literal: CustomStringConvertible {
    case companyName
    case banksTitle
    case createCredentialTitle
    case submitLabel
    case synchronizationTitle
    case privacyTermsUrl
    case termsAndConditionsUrl
    case mainFont

    var description: String {
        return literal(self) ?? String(hashValue)
    }
}

func literal(_ literal: Literal) -> String? {
    let literals = Configuration.shared.texts

    switch literal {
    case .companyName: return literals.companyName
    case .banksTitle: return literals.banksTitle
    case .createCredentialTitle: return literals.createCredentialTitle
    case .submitLabel: return literals.submitLabel
    case .synchronizationTitle: return literals.synchronizationTitle
    case .privacyTermsUrl: return literals.privacyTermsUrl
    case .termsAndConditionsUrl: return literals.termsAndConditionsUrl
    case .mainFont: return literals.mainFont
    }
}
