//
//  Constants.swift
//  FinerioConnectWidget
//
//  Created by René Sandoval on 22/11/20.
//

import Foundation
import UIKit

internal struct Constants {
    /// Titles
    struct Titles {
        static let initSection = "Mejora de servicios"
        static let bankSection = "Vincula tu entidad bancaria"
    }

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

        struct CredentialSection {
            static let helpWithCredentialsLabel = "¿Dónde encuentro mis claves?"
            static let tyCLabel = "Al dar clic en Enviar información aceptas expresamente nuestros Términos de servicio así como nuestro Aviso de privacidad."
            static let titleDatePicker = "Fecha"
            static let doneButtonTitleDatePicker = "Ok"
            static let cancelButtonTitleDatePicker = "Cancelar"
        }

        struct AccountSection {
            static let titleAlertToken = "Solicitud de token"
            static let labelAlertToken = "Por favor, introduce tu token:"
            static let firstLabelAlertToken = "Por favor, introduce este número en tu token:"
            static let secondLabelAlertToken = "después, escribe aquí el número que salío en tu token:"
            static let titleButton = "Enviar"
        }

        struct StatusSection {
            static let successTitleLabel = "¡Vinculación exitosa!"
            static let successSubtitleLabel = "Tu cuenta se analizó correctamente."
            static let failureTitleLabel = "¡La vinculación falló!"
            static let failureSubtitleLabel = "Lo sentimos."
            static let successTitleButton = "Vincular otra cuenta"
            static let exitTitleButton = "Cancelar"
        }
    }

    /// Placeholders
    struct Placeholders {
        static var bankId = "@bankId"
        static var bankName = "?"
    }

    /// Texfields Name
    struct TexfieldsName {
        static var username = "username"
        static var password = "password"
        static var securityCode = "securityCode"
    }

    /// URLS
    struct URLS {
        static let privacyTerms = "https://finerioconnect.com/privacy"
        static let termsAndConditions = "https://finerioconnect.com/license"
        static let cdnWidget = "https://cdn.finerio.mx/widget"
        static var bankImageOff = "\(cdnWidget)/bank_\(Constants.Placeholders.bankId)_off.png"
        static var bankImageOn = "\(cdnWidget)/bank_\(Constants.Placeholders.bankId)_on.png"
        static var helpWithCredentialsGif = "\(cdnWidget)/bank_\(Constants.Placeholders.bankId)_help.gif"
    }

    /// Tags
    struct Tags {
        static let loader = 200
        static let fieldSecurityCode = 33
        static let fieldPassword = 66
    }

    /// Keys
    struct Keys {
        static let publicKey = "MIIBCgKCAQEAv1STVY1D8uelL+j4Tm0zsgOsgof3KMsmWUIyvLtKUnH5SBrcPqEbjI5+gwRTwc1d5QcGWqEgx2uSUSaOdDWyTR6mKG8iSMYWEtEeCI/LmwAKGapGDB/ciguhXzsjVa9dZThlHvW4XiHWEIenxzbahXexBuEQfSP9DiJuM9yRqHX60+aCJxupRtLgaWQkTtFGI5tGQ1tMN0qZW7eat//rvzHrp4MU2EOVXiRE06ypWRQhni8zY+VaNPjXHybPC+dIiXspBqwaySKBKqNVZCXtqVa7ouJfXs3HUrpthJqQ30cPefEt0jAFj6QRJDsGwKTXS3gq7mGz3AYq0Be2LuTD1wIDAQAB"
        static let firebaseNode = "CtkFJ3subunSceVh7vUAPMB4TckRSv"
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
        static let lighFont = "\(Configuration.shared.font)-Light"
        static let regularFont = "\(Configuration.shared.font)-Regular"
        static let boldFont = "\(Configuration.shared.font)-Bold"
        static let italicFont = "\(Configuration.shared.font)-Italic"
    }
}
