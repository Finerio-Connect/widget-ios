//
//  OnboardingModel.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 02/05/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation
import UIKit

struct OnboardingModel {
    var main: Main
    var pages: [Page]?
}

// MARK: - Structs
extension OnboardingModel {
    struct Main {
        var icon: UIImage
        var headerTitle: String
        var headerDescription: String
        var listItems: [ListItem]
        var textWithLink: TextWithLink
    }

    struct Page {
        var image: UIImage
        var title: String
        var textWithLink: TextWithLink
    }
    
    struct ListItem {
        var icon: UIImage
        var description: String
    }
}


//MARK: - TESTING DATA
#warning("EXAMPLE DATA")
// Main Data
let listItems = [
    OnboardingModel.ListItem(icon: Images.lockIcon.image()!, description: "Completamente seguro")
    ,OnboardingModel.ListItem(icon: Images.rayIcon.image()!, description: "Evaluación al instante")
]

let descriptionLinked = TextWithLink(fullPlainText: "Conocer mi seguridad y beneficios",
                                            linkedTextPhrase: "Conocer mi seguridad y beneficios",
                                            urlSource: "https://www.google.com")

let main = OnboardingModel.Main(icon: Images.buildingIcon.image()!,
                                headerTitle: "¡Bienvenido!",
                                headerDescription: "Agrega tu cuenta bancaria ahora mismo y accede a un crédito a tu medida con aprobación rápida",
                                listItems: listItems,
                                textWithLink: descriptionLinked)


// Paginator Data
let linkedDescriptionStepOne = TextWithLink(fullPlainText:"Recuerda en ningún momento se realizarán movimientos o compras. Si tienes dudas de la privacidad puedes consultarlo aquí.",
                                                   linkedTextPhrase: "aquí",
                                                   urlSource: "https://www.google.com")

let linkedDEscriptionStepTwo = TextWithLink(fullPlainText: "Al agregar tus credenciales podemos conocerte mejor, podrás obtener beneficios a tu medida y sin complicaciones.")

let onboardingModelTestData = [
    OnboardingModel.Page(image: Images.stepLockIcon.image()!,
                   title: "Completamente seguro",
                  textWithLink: linkedDescriptionStepOne),
    
    OnboardingModel.Page(image: Images.stepRayIcon.image()!,
                   title: "Evaluación al instante",
                   textWithLink: linkedDEscriptionStepTwo)
]

// Outter Object
let finerioOnboarding = OnboardingModel(main: main, pages: onboardingModelTestData)
