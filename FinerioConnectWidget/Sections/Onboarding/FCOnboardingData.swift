//
//  FCOnboardingData.swift
//  FinerioConnectWidget
//
//  Created by Jesus G on 06/05/22.
//  Copyright © 2022 Finerio Connect. All rights reserved.
//

import Foundation

// Main Data
let descriptionLinked = TextWithLink(fullPlainText: "Conocer mi seguridad y beneficios",
                                     linkedTextPhrase: "Conocer mi seguridad y beneficios",
                                     urlSource: "https://www.google.com")

let main = Onboarding.Main(icon: Images.buildingIcon.image()!,
                           title: "¡Bienvenido!",
                           description: "Agrega tu cuenta bancaria ahora mismo y accede a un crédito a tu medida con aprobación rápida",
                           actionText: descriptionLinked)


// Paginator Data
let linkedDescriptionStepOne = TextWithLink(fullPlainText:"Recuerda en ningún momento se realizarán movimientos o compras. Si tienes dudas de la privacidad puedes consultarlo aquí.",
                                            linkedTextPhrase: "aquí",
                                            urlSource: "https://www.google.com")

let linkedDEscriptionStepTwo = TextWithLink(fullPlainText: "Al agregar tus credenciales podemos conocerte mejor, podrás obtener beneficios a tu medida y sin complicaciones.")

let onboardingFinerioPages = [
    Onboarding.OnboardingPage(image: Images.stepLockIcon.image()!,
                              icon: Images.lockIcon.image()!,
                              title: "Completamente seguro",
                              detail: linkedDescriptionStepOne),
    
    Onboarding.OnboardingPage(image: Images.stepRayIcon.image()!,
                              icon: Images.rayIcon.image()!,
                              title: "Evaluación al instante",
                              detail: linkedDEscriptionStepTwo)
]

// Outter Object
let onboardingFinerioData = Onboarding(main: main, pages: onboardingFinerioPages)
