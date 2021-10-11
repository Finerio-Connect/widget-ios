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
    public var countriesTitle: String
    public var personalBankTitle: String
    public var businessBankTitle: String
    public var fiscalTitle: String
    public var submitLabel: String
    public var createCredentialTitle: String
    public var synchronizationTitle: String
    public var privacyTermsUrl: String
    public var termsAndConditionsUrl: String

    @objc public init(
        companyName: String = fLocaleCompanyName,
        banksTitle: String = fLocaleBanksTitle,
        countriesTitle: String = fLocaleCountriesTitle,
        personalBankTitle: String = fLocalePersonalBankTitle,
        businessBankTitle: String = fLocaleBusinessBankTitle,
        fiscalTitle: String = fLocaleFiscalTitle,
        createCredentialTitle: String = fLocaleCreateCredentialTitle,
        submitLabel: String = fLocaleSubmitLabel,
        synchronizationTitle: String = fLocaleSynchronizationTitle,
        privacyTermsUrl: String = fLocalePrivacyTermsUrl,
        termsAndConditionsUrl: String = fLocaletermsAndConditionsUrl) {
        self.companyName = companyName
        self.banksTitle = banksTitle
        self.countriesTitle = countriesTitle
        self.personalBankTitle = personalBankTitle
        self.businessBankTitle = businessBankTitle
        self.fiscalTitle = fiscalTitle
        self.createCredentialTitle = createCredentialTitle
        self.submitLabel = submitLabel
        self.synchronizationTitle = synchronizationTitle
        self.privacyTermsUrl = privacyTermsUrl
        self.termsAndConditionsUrl = termsAndConditionsUrl
    }
}

enum Literal: CustomStringConvertible {
    case companyName
    case banksTitle
    case countriesTitle
    case personalBankTitle
    case businessBankTitle
    case fiscalTitle
    case createCredentialTitle
    case submitLabel
    case synchronizationTitle
    case privacyTermsUrl
    case termsAndConditionsUrl

    var description: String {
        return literal(self) ?? String(hashValue)
    }
}

func literal(_ literal: Literal) -> String? {
    let literals = Configuration.shared.texts

    switch literal {
    case .companyName: return literals.companyName
    case .banksTitle: return literals.banksTitle
    case .countriesTitle: return literals.countriesTitle
    case .personalBankTitle: return literals.personalBankTitle
    case .businessBankTitle: return literals.businessBankTitle
    case .fiscalTitle: return literals.fiscalTitle
    case .createCredentialTitle: return literals.createCredentialTitle
    case .submitLabel: return literals.submitLabel
    case .synchronizationTitle: return literals.synchronizationTitle
    case .privacyTermsUrl: return literals.privacyTermsUrl
    case .termsAndConditionsUrl: return literals.termsAndConditionsUrl
    }
}
