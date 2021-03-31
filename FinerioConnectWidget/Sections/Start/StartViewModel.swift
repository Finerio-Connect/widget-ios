//
//  StartViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 10/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class StartViewModel {
    var errorMessage: String!
    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }

    func getTitle() -> String {
        return Constants.Titles.initSection
    }

    func loadBanks() {
        FinerioConnectWidgetAPI.banks { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }

            SessionManager.shared.banks = result.value
            self?.serviceStatusHandler(.loaded)
        }
    }
}
