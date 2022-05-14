//
//  BankViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class BankViewModel {
    var countries: [Country] = [Country]()
    var banks: [Bank] = [Bank]()
    var errorMessage: String!
    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }
    let userDefaults = UserDefaults.standard

    func getCurrentCountry(_ country: String = Configuration.shared.countryCode,
                           completion: @escaping(Country?)->()) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            if let index = self?.countries.firstIndex(where: { $0.code.lowercased() == country.lowercased() }) {
                completion(self?.countries[index])
            } else {
                completion(nil)
            }
        }
    }

    func loadCountries() {
        FinerioConnectWidgetAPI.countries { [weak self] result in
            if let error = result.error {
                self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                self?.serviceStatusHandler(.failure)
            }
            if let value = result.value {
                self?.countries = value
                self?.serviceStatusHandler(.loaded)
            }
        }
    }

    func loadBanks(country: String = Configuration.shared.countryCode, type: BankType = Configuration.shared.bankType) {
        let banksKeyPath = "\(country)_\(type)"
        
        if let localBanks = getLocalBanksFromKeyPath(banksKeyPath) {
            self.banks = localBanks
            self.serviceStatusHandler(.success)
        } else {
            FinerioConnectWidgetAPI.banks(country: country, type: type.rawValue) { [weak self] result in
                if let error = result.error {
                    self?.errorMessage = error.error == Constants.Texts.Errors.unknownError ? Constants.Texts.Errors.unknownErrorMessage : error.message
                    self?.serviceStatusHandler(.failure)
                }
                
                if let value = result.value {
                    self?.banks = value
                    self?.saveBanks(value, for: banksKeyPath)
                    self?.serviceStatusHandler(.success)
                }
            }
        }
    }
}

// MARK: - Local Banks
extension BankViewModel {
    private func getLocalBanksFromKeyPath(_ keyPath: String) -> [Bank]? {
        var localBanks: [Bank]? = nil
        if let banksData = userDefaults.value(forKey: keyPath) as? Data {
            if let banks = try? JSONDecoder().decode([Bank].self, from: banksData) {
                localBanks = banks
            }
        }
        return localBanks
    }
    
    private func saveBanks(_ banks: [Bank],for keyPath: String) {
        if let data = try? JSONEncoder().encode(banks) {
            self.userDefaults.set(data, forKey: keyPath)
        }
    }
}
