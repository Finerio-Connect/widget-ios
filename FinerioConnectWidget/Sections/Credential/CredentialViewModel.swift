//
//  CredentialViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

internal class CredentialViewModel {
    var bank: Bank!
    var bankFields: [BankField]!
    var credentialResponse: CredentialResponse!
    var errorMessage: String!
    var totalValidationTextfields: [String] = []

    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }

    func getTitle() -> String {
        return Constants.Titles.bankSection
    }

    func loadBankFields() {
        FinerioConnectWidgetAPI.bankFields(by: bank.id) { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }

            self?.bankFields = result.value
            self?.bankFields?.sort {
                $0.position < $1.position
            }
            self?.serviceStatusHandler(.loaded)
        }
    }

    func createCredential(credential: Credential) {
        FinerioConnectWidgetAPI.createCredential(credential: credential) { result in
            if let error = result.error {
                self.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self.serviceStatusHandler(.error)
                return
            }

            self.credentialResponse = result.value

            if self.credentialResponse.status == Constants.CredentialStatus.active {
                self.serviceStatusHandler(.active)
                return
            }

            self.serviceStatusHandler(.success)
        }
    }

    func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""

        if !text.isEmpty {
            if !totalValidationTextfields.contains(textField.id ?? "") {
                totalValidationTextfields.append(textField.id ?? "")
            }
            return
        }

        while totalValidationTextfields.contains(textField.id ?? "") {
            if let itemToRemoveIndex = totalValidationTextfields.firstIndex(of: textField.id ?? "") {
                totalValidationTextfields.remove(at: itemToRemoveIndex)
            }
        }
    }

    var validForm: Bool {
        return bankFields.count == totalValidationTextfields.count
    }
}
