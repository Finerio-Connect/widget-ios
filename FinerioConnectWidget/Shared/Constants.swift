//
//  Constants.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 22/11/20.
//

import Foundation
import UIKit

internal struct Constants {
    /// Texts
    struct Texts {
        struct Errors {
            static let unknownError = "unknown"
            static let unknownErrorMessage = "Ocurrió un error desconocido."
            static let reachabilityError = "No se encontró una conexión a Internet disponible"
        }

        struct InitSection {
            static let bodyLabel =
                """
                Nos gustaría realizar un análisis de tus movimientos para poder conocer tu perfil y ofrecerte mejores productos.

                Para ello, deberemos realizar una vinculación con la banca en línea de tu banco. Esto sin solicitar contraseñas que comprometan tu cuenta, únicamente tus datos de acceso.
                """
            static let titleButton = "Continuar"
        }

        struct BankSection {
            static let titleButton = "Seleccionar"
        }

        struct CredentialSection {
            static let titleDatePicker = "Fecha"
            static let doneButtonTitleDatePicker = "OK"
            static let cancelButtonTitleDatePicker = "Cancelar"
            static let continueButtonTitle = "Continuar"
        }

        struct AccountSection {
            static let titleAlertToken = "Solicitud de token"
            static let labelAlertToken = "Por favor, introduce tu token:"
            static let firstLabelAlertToken = "Por favor, introduce este número en tu token:"
            static let secondLabelAlertToken = "después, escribe aquí el número que salío en tu token:"
            static let titleButton = "Enviar"
        }
    }

    /// Placeholders
    struct Placeholders {
        static var bankId = "@bankId"
        static var bankCode = "@bankCode"
        static var bankName = "?"
    }

    /// Texfields Name
    struct TexfieldsName {
        static var username = "username"
        static var password = "password"
        static var securityCode = "securityCode"
    }
    
    /// Texfields Name
    struct TexfieldsFriendlyName {
        static var user = "Usuario"
    }

    /// Tags
//    struct Tags {
//        static let loader = 200
//        static let fieldSecurityCode = 33
//        static let fieldPassword = 66
//        static let fieldSelect = 99
//    }
    
    struct FieldType {
        static let loader = 200
        static let plainText = 33
        static let passwordText = 66
        static let selectorOptions = 99
    }
    

    /// URLS
    struct URLS {
        static let termsAndConditions = "https://finerioconnect.com/license"
        static let cdnWidget = "https://cdn.finerio.mx/widget"
        static var bankImageOff = "\(cdnWidget)/bank_\(Constants.Placeholders.bankCode)_off.png"
        static var bankImageOn = "\(cdnWidget)/bank_\(Constants.Placeholders.bankCode)_on.png"
        static var bankImageShield = "\(cdnWidget)/rounded_logos/bank_\(Constants.Placeholders.bankCode)_shield.png"
        static var helpWithCredentials = "\(cdnWidget)/help_images/bank_\(Constants.Placeholders.bankCode)_help.png"
    }

    /// Keys
    struct Keys {
        static let publicKey = "MIIBCgKCAQEAv1STVY1D8uelL+j4Tm0zsgOsgof3KMsmWUIyvLtKUnH5SBrcPqEbjI5+gwRTwc1d5QcGWqEgx2uSUSaOdDWyTR6mKG8iSMYWEtEeCI/LmwAKGapGDB/ciguhXzsjVa9dZThlHvW4XiHWEIenxzbahXexBuEQfSP9DiJuM9yRqHX60+aCJxupRtLgaWQkTtFGI5tGQ1tMN0qZW7eat//rvzHrp4MU2EOVXiRE06ypWRQhni8zY+VaNPjXHybPC+dIiXspBqwaySKBKqNVZCXtqVa7ouJfXs3HUrpthJqQ30cPefEt0jAFj6QRJDsGwKTXS3gq7mGz3AYq0Be2LuTD1wIDAQAB"
        static let firebaseNode = "CtkFJ3subunSceVh7vUAPMB4TckRSv"
        static let productionMixpanelToken = "849778938cdb0486c91d953502082582"
        static let sandboxMixpanelToken = "86830d7eeedf9117694afc6e85d94f56"
        static let zendeskChannelKey = "eyJzZXR0aW5nc191cmwiOiJodHRwczovL2ZpbmVyaW9jb25uZWN0aGVscC56ZW5kZXNrLmNvbS9tb2JpbGVfc2RrX2FwaS9zZXR0aW5ncy8wMUcwSzRUMlYyWEtUMDA1WUpYWktTOFk3Ry5qc29uIn0="
    }

    struct ErrorCodes {
        static let Unknown = -1
    }

    struct CredentialStatus {
        static let success = "SUCCESS"
        static let created = "CREATED"
        static let active = "ACTIVE"
        static let failure = "FAILURE"
        static let interactive = "INTERACTIVE"
        static let accountCreated = "ACCOUNT_CREATED"
        static let transactionsCreated = "TRANSACTIONS_CREATED"
    }

    struct MoveKeyboard {
        static let KEYBOARD_ANIMATION_DURATION: CGFloat = 0.3
        static let MINIMUM_SCROLL_FRACTION: CGFloat = 0.2
        static let MAXIMUM_SCROLL_FRACTION: CGFloat = 0.8
        static let PORTRAIT_KEYBOARD_HEIGHT: CGFloat = 216
        static let LANDSCAPE_KEYBOARD_HEIGHT: CGFloat = 162
    }

    struct Fonts {
        static let defaultFontName = "Poppins"
        static let lighFont = "\(Configuration.shared.font!)-Light"
        static let regularFont = "\(Configuration.shared.font!)-Regular"
        static let boldFont = "\(Configuration.shared.font!)-Bold"
        static let italicFont = "\(Configuration.shared.font!)-Italic"
        static let mediumFont = "\(Configuration.shared.font!)-Medium"
    }

    struct Country {
        static let name = "México"
        static let code = "MX"
        static let imageUrl = "https://cdn.finerio.mx/widget/MX.png"
    }

    struct Events {
        static let widgetId = "Widget ID"
        static let banks = "View: Banks"
        static let bankSelected = "Bank selected"
        static let credentials = "View: Credentials"
        static let createCredential = "Create credential"
        static let credentialSuccess = "Credential success"
        static let credentialFailure = "Credential failure"
        static let appName = "APP Name"
    }
    
    struct SuperPropertiesValues {
        static let appName = "WidgetMOBILE"
    }
}
