//
//  BankViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 15/12/20.
//  Copyright © 2021 Finerio Connect. All rights reserved.
//

import Foundation

internal class BankViewModel {
    var banks = SessionManager.shared.banks!

    func getTitle() -> String {
        return Constants.Titles.bankSection
    }
}
