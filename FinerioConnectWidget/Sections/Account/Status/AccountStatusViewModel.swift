//
//  AccountStatusViewModel.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 11/01/21.
//  Copyright © 2021 Finerio. All rights reserved.
//

import FirebaseDatabase
import Foundation

internal class AccountStatusViewModel {
    var errorMessage: String!
    var serviceStatus: ServiceStatus!

    var serviceStatusHandler: (ServiceStatus) -> Void = { _ in }

    func getTitle() -> String {
        return Constants.Titles.bankSection
    }
}
