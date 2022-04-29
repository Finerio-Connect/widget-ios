//
//  Texts.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 03/02/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

public final class Texts: NSObject {
    public var companyName: String
    //Banks selection view
    public var banksHeaderTitle: String
    public var banksHeaderSubtitle: String
    public var selectCountryLabel: String
    public var personalBankType: String
    public var businessBankType: String
    public var fiscalBankType: String
    public var titleWithoutBanks: String
    // Credentials form view
    public var credentialsHeaderTitle: String
    public var credentialsHeaderSubtitle: String
    public var plainTyCText: String
    public var linkedTyCText: String
    public var helpWithCredentialsButton: String
    public var credentialsDisclaimerText: String
    // Account creation view
    public var syncHeaderTitle: String
    public var syncHeaderSubtitle: String
    public var encryptingData: String
    // Account status view
    public var bondingHeaderTitleSuccess: String
    public var bondingHeaderTitleFailure: String
    public var bondingHeaderSubtitleSuccess: String
    public var bondingHeaderSubtitleFailure: String
    public var bondingDescriptionSuccess: String
    public var bondingDescriptionFailure: String
    public var failureContinueTitleButton: String
    public var failureExitTitleButton: String
    public var successContinueTitleButton: String
    public var successExitTitleButton: String
    // Onboarding views
    public var onboardingMainTitle: String
    public var onboardingMainDescription: String
    public var onboardingMainLinkedLabel: String
    public var onboardingMainLinkedLabelURL: String
    public var onboardingMainBullet1: String
    public var onboardingMainBullet2: String
    public var onboardingMainContinueButton: String
    public var onboardingMainExitButton: String
    public var onboardingStepContinueButton: String
    public var onboardingStepExitButton: String
    
    
    @objc public init(
        companyName: String = fLocaleCompanyName,
        banksHeaderTitle: String = fLocaleBanksHeaderTitle,
        banksHeaderSubtitle: String = fLocaleBanksHeaderSubtitle,
        selectCountryLabel: String = fLocaleSelectCountryLabel,
        personalBankType: String = fLocalePersonalBankType,
        businessBankType: String = fLocaleBusinessBankType,
        fiscalBankType: String = fLocaleFiscalBankType,
        titleWithoutBanks: String = fLocaleTitleWithoutBanks,
        credentialsHeaderTitle: String = fLocaleCredentialsHeaderTitle,
        credentialsHeaderSubtitle: String = fLocaleCredentialsHeaderSubtitle,
        plainTyCText: String = fLocalePlainTyCText,
        linkedTyCText: String = fLocaleLinkedTyCText,
        helpWithCredentialsButton: String = fLocaleHelpWithCredentialsButton,
        credentialsDisclaimerText: String = fLocaleCredentialsDisclaimerText,
        syncHeaderTitle: String = fLocaleSyncHeaderTitle,
        syncHeaderSubtitle: String = fLocaleSyncHeaderSubtitle,
        encryptingData: String = fLocaleEncryptingData,
        bondingHeaderTitleSuccess: String = fLocaleBondingHeaderTitleSuccess,
        bondingHeaderTitleFailure: String = fLocaleBondingHeaderTitleFailure,
        bondingHeaderSubtitleSuccess: String = fLocaleBondingHeaderSubtitleSuccess,
        bondingHeaderSubtitleFailure: String = fLocaleBondingHeaderSubtitleFailure,
        bondingDescriptionSuccess: String = fLocaleBondingDescriptionSuccess,
        bondingDescriptionFailure: String = fLocaleBondingDescriptionFailure,
        failureContinueTitleButton: String = fLocaleFailureContinueTitleButton,
        failureExitTitleButton: String = fLocaleFailureExitTitleButton,
        successContinueTitleButton: String = fLocaleSuccessContinueTitleButton,
        successExitTitleButton: String = fLocaleSuccessExitTitleButton,
        onboardingMainTitle: String = fLocaleOnboardingMainTitle,
        onboardingMainDescription: String = fLocaleOnboardingMainDescription,
        onboardingLinkedLabel: String = fLocaleOnboardingMainLinkedLabel,
        onboardingMainLinkedLabelURL: String = fLocaleOnboardingMainLinkedLabelURL,
        onboardingMainBullet1: String  = fLocaleOnboardingMainBulletCell1,
        onboardingMainBullet2: String = fLocaleOnboardingMainBulletCell2,
        onboardingMainContinueButton: String = fLocaleOnboardingMainContinueButton,
        onboardingMainExitButton: String = fLocaleOnboardingMainExitButton,
        onboardingStepContinueButton: String = fLocaleOnboardingStepContinueButton,
        onboardingStepExitButton: String = fLocaleOnboardingStepExitButton
    ) {
        self.companyName = companyName
        self.banksHeaderTitle = banksHeaderTitle
        self.banksHeaderSubtitle = banksHeaderSubtitle
        self.selectCountryLabel = selectCountryLabel
        self.personalBankType = personalBankType
        self.businessBankType = businessBankType
        self.fiscalBankType = fiscalBankType
        self.titleWithoutBanks = titleWithoutBanks
        self.credentialsHeaderTitle = credentialsHeaderTitle
        self.credentialsHeaderSubtitle = credentialsHeaderSubtitle
        self.plainTyCText = plainTyCText
        self.linkedTyCText = linkedTyCText
        self.helpWithCredentialsButton = helpWithCredentialsButton
        self.credentialsDisclaimerText = credentialsDisclaimerText
        self.syncHeaderTitle = syncHeaderTitle
        self.syncHeaderSubtitle = syncHeaderSubtitle
        self.encryptingData = encryptingData
        self.bondingHeaderTitleSuccess = bondingHeaderTitleSuccess
        self.bondingHeaderTitleFailure = bondingHeaderTitleFailure
        self.bondingHeaderSubtitleSuccess = bondingHeaderSubtitleSuccess
        self.bondingHeaderSubtitleFailure = bondingHeaderSubtitleFailure
        self.bondingDescriptionSuccess = bondingDescriptionSuccess
        self.bondingDescriptionFailure = bondingDescriptionFailure
        self.failureContinueTitleButton = failureContinueTitleButton
        self.failureExitTitleButton = failureExitTitleButton
        self.successContinueTitleButton = successContinueTitleButton
        self.successExitTitleButton = successExitTitleButton
        self.onboardingMainTitle = onboardingMainTitle
        self.onboardingMainDescription = onboardingMainDescription
        self.onboardingMainLinkedLabel = onboardingLinkedLabel
        self.onboardingMainLinkedLabelURL = onboardingMainLinkedLabelURL
        self.onboardingMainBullet1 = onboardingMainBullet1
        self.onboardingMainBullet2 = onboardingMainBullet2
        self.onboardingMainContinueButton = onboardingMainContinueButton
        self.onboardingMainExitButton = onboardingMainExitButton
        self.onboardingStepContinueButton = onboardingStepContinueButton
        self.onboardingStepExitButton = onboardingStepExitButton
    }
}

enum Literal: CustomStringConvertible {
    case companyName
    case banksHeaderTitle
    case banksHeaderSubtitle
    case selectCountryLabel
    case personalBankType
    case businessBankType
    case fiscalBankType
    case titleWithoutBanks
    case credentialsHeaderTitle
    case credentialsHeaderSubtitle
    case plainTyCText
    case linkedTyCText
    case helpWithCredentialsButton
    case credentialsDisclaimerText
    case syncHeaderTitle
    case syncHeaderSubtitle
    case encryptingData
    case bondingHeaderTitleSuccess
    case bondingHeaderTitleFailure
    case bondingHeaderSubtitleSuccess
    case bondingHeaderSubtitleFailure
    case bondingDescriptionSuccess
    case bondingDescriptionFailure
    case failureContinueTitleButton
    case failureExitTitleButton
    case successContinueTitleButton
    case successExitTitleButton
    case onboardingMainTitle
    case onboardingMainDescription
    case onboardingLinkedLabel
    case onboardingMainLinkedLabelURL
    case onboargingMainBullet1
    case onboargingMainBullet2
    case onboardingMainContinueButton
    case onboardingMainExitButton
    case onboardingStepContinueButton
    case onboardingStepExitButton
    
    var description: String {
        return literal(self) ?? String(hashValue)
    }
}

func literal(_ literal: Literal) -> String? {
    let literals = Configuration.shared.texts
    
    switch literal {
    case .companyName: return literals.companyName
    case .banksHeaderTitle: return literals.banksHeaderTitle
    case .banksHeaderSubtitle: return literals.banksHeaderSubtitle
    case .selectCountryLabel: return literals.selectCountryLabel
    case .personalBankType: return literals.personalBankType
    case .businessBankType: return literals.businessBankType
    case .fiscalBankType: return literals.fiscalBankType
    case .titleWithoutBanks: return literals.titleWithoutBanks
    case .credentialsHeaderTitle: return literals.credentialsHeaderTitle
    case .credentialsHeaderSubtitle: return literals.credentialsHeaderSubtitle
    case .plainTyCText: return literals.plainTyCText
    case .linkedTyCText: return literals.linkedTyCText
    case .helpWithCredentialsButton: return literals.helpWithCredentialsButton
    case .credentialsDisclaimerText: return literals.credentialsDisclaimerText
    case .syncHeaderTitle: return literals.syncHeaderTitle
    case .syncHeaderSubtitle: return literals.syncHeaderSubtitle
    case .encryptingData: return literals.encryptingData
    case .bondingHeaderTitleSuccess: return literals.bondingHeaderTitleSuccess
    case .bondingHeaderTitleFailure: return literals.bondingHeaderTitleFailure
    case .bondingHeaderSubtitleSuccess: return literals.bondingHeaderSubtitleSuccess
    case .bondingHeaderSubtitleFailure: return literals.bondingHeaderSubtitleFailure
    case .bondingDescriptionSuccess: return literals.bondingDescriptionSuccess
    case .bondingDescriptionFailure: return literals.bondingDescriptionFailure
    case .failureContinueTitleButton: return literals.failureContinueTitleButton
    case .failureExitTitleButton: return literals.failureExitTitleButton
    case .successContinueTitleButton: return literals.successContinueTitleButton
    case .successExitTitleButton: return literals.successExitTitleButton
    case .onboardingMainTitle: return literals.onboardingMainTitle
    case .onboardingMainDescription: return literals.onboardingMainDescription
    case .onboardingLinkedLabel: return literals.onboardingMainLinkedLabel
    case .onboardingMainLinkedLabelURL: return literals.onboardingMainLinkedLabelURL
    case .onboargingMainBullet1: return literals.onboardingMainBullet1
    case .onboargingMainBullet2: return literals.onboardingMainBullet2
    case .onboardingMainContinueButton: return literals.onboardingMainContinueButton
    case .onboardingMainExitButton: return literals.onboardingMainExitButton
    case .onboardingStepContinueButton: return literals.onboardingStepContinueButton
    case .onboardingStepExitButton: return literals.onboardingStepExitButton
        
    }
}
