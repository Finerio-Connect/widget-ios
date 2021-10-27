//
//  BankViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class BankViewModel {
    var countries: [Country]!
    var banks: [Bank]!
    var errorMessage: String!
    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }

    func getTitle() -> String {
        return Constants.Titles.bankSection
    }

    func getCurrentCountry(_ country: String = Configuration.shared.countryCode) -> Country? {
        if let index = countries.firstIndex(where: { $0.code.lowercased() == country.lowercased() }) {
            return countries[index]
        }

        return nil
    }

    func loadCountries() {
        FinerioConnectWidgetAPI.countries { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }

            self?.countries = result.value
            self?.serviceStatusHandler(.loaded)
        }
    }

    func loadBanks(country: String = Configuration.shared.countryCode, type: BankType = Configuration.shared.bankType) {
        FinerioConnectWidgetAPI.banks(country: country, type: type.rawValue) { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }
            
            self?.banks = result.value
            self?.serviceStatusHandler(.success)
        }
    }
}
