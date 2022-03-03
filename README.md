# Finerio Connect iOS Widget
![Platform](https://img.shields.io/badge/platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/languages-swift-orange.svg)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FinerioAccountWidget.svg)](https://cocoapods.org/pods/FinerioAccountWidget)
## Introduction

The iOS widget for the Finerio Connect 2.0 API reduces friction in the process of asking users for their online banking credentials by taking care of the implementation and improving the user experience.

----

## Installation

### Requirements

- iOS 11.0+
- Swift 5.0

### Prerequisites

* You must have an active account with `FinerioConnect`.

### Using Cocoapods

Edit your `Podfile` and specify the dependency:

```swift
pod 'FinerioAccountWidget'
```

... or for a specific version:

```swift
pod 'FinerioAccountWidget', '~> 2.0.0'
```

and then run `pod install`. More information about `Cocoapods` [here](https://cocoapods.org/).

## Usage

Add the following code in your application:

```swift
import FinerioAccountWidget
```

To use the solution that provides the entire embedded account aggregation process, use the following initialization form. Be sure to provide a `ViewController` that has a `NavigationController` for the `presentingViewController` parameter.

```swift
let finerioConnectWidget = FinerioConnectWidget.shared 

finerioConnectWidget.start( 
  widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46", 
  customerName: "René Sandoval",
  presentingViewController: self)
```

To use customized navigation through the use of individual views, use the following initialization method:

```swift
let finerioConnectWidget = FinerioConnectWidget.shared 

finerioConnectWidget.start( 
  widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46", 
  customerName: "René Sandoval")
```

## Separation by Views

### FCBankSelectionView

This view presents a list of available banks according to the bank type and country selected, either through the selected interface controls or through the internal parameters configured in the `FinerioConnectWidget` initialization.

```swift
let bankSelectionView = FCBankSelectionView()
bankSelectionView.delegate = self

view.addSubview(bankSelectionView)
bankSelectionView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    bankSelectionView.topAnchor.constraint(equalTo: view.topAnchor),
    bankSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    bankSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    bankSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])
```

#### Delegate methods

##### FCBankSelectionViewDelegate

The `didSelectBank` method is called when the user selects a bank from the available list. Within the parameters, the `nextFlowView` parameter returns a configured instance with the required data of the next view to be presented within the suggested flow.

```swift
func bankSelectionView(didSelect bank: Bank, nextFlowView: FCCredentialsFormView) {
    let vc = UIViewController()
    vc.view.addSubview(nextFlowView)
    nextFlowView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
        nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
        nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
        nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
        nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
    ])

    self.present(vc, animated: true)
}
```

The `onFailure` method is called when an error occurs during bank recovery from the server.

```swift
func bankSelectionView(onFailure: ServiceStatus, message: String) {
    // Your implementation
}
```

### FCCredentialsFormView

This screen presents a form with the required fields for each bank according to the bank that is passed as a configuration parameter.

```swift
let credentialsFormView = FCCredentialsFormView()
credentialsFormView.delegate = self

view.addSubview(credentialsFormView)
credentialsFormView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    credentialsFormView.topAnchor.constraint(equalTo: view.topAnchor),
    credentialsFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    credentialsFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    credentialsFormView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])
```

#### Methods

The `setBank` method allows you to inject data from a particular bank to customize the form with the required fields from that bank.

```swift
let bank = Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active")
credentialsFormView.setBank(bank)
```

#### Delegate methods

##### FCCredentialsFormViewDelegate

The `onActive` delegate is triggered when it is detected that the credentials sent for the selected bank have already been previously registered and are active, so it is not necessary to register them again.

Within the parameters, the `nextFlowView` parameter returns a configured instance with the required data of the next view to be presented within the suggested flow. 

```swift
func credentialsFormView(onActive: ServiceStatus, bank: Bank, nextFlowView: FCAccountStatusView) {
    // Your implementation
    let vc = UIViewController()
    vc.view.addSubview(nextFlowView)
    nextFlowView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
        nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
        nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
        nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
        nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
    ])

    self.present(vc, animated: true)
}
```

The `onSuccess` delegate is triggered as soon as the indicated bank credentials have been successfully created and its remote process has been completed.

Within the parameters, the `nextFlowView` parameter returns a configured instance with the required data of the next view to be presented within the suggested flow.

```swift
func credentialsFormView(onSuccess: ServiceStatus, bank: Bank, credentialId: String, nextFlowView: FCAccountCreationView) {
    // Your implementation    
    let vc = UIViewController()
    vc.view.addSubview(nextFlowView)
    nextFlowView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
            nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])

    self.present(vc, animated: true)
}
```

The `onFailure` delegate is triggered when an error occurs on the server side in obtaining the fields for the form according to the selected bank.

```swift
func credentialsFormView(onFailure: ServiceStatus, bank: Bank) {
    // Your implementation
}
```

The `onError` delegate is triggered when an error occurs during the creation of credentials of the selected bank.

```swift
func credentialsFormView(onError: ServiceStatus, message: String) {
    // Your implementation
}
```

### FCAccountCreationView

Se presenta una pantalla de actividad en espera, la cual actualiza en su interfaz los nombres de las cuentas que se van creando durante el proceso.

```swift
let accountCreationView = FCAccountCreationView()
accountCreationView.delegate = self

view.addSubview(accountCreationView)
accountCreationView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    accountCreationView.topAnchor.constraint(equalTo: view.topAnchor),
    accountCreationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    accountCreationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    accountCreationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])
```

#### Methods

The `setBank` method allows injecting the necessary data through the interface to display the account creation process.

```swift
let bank = Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active")
accountCreationView.setBank(bank, credentialId: "d009c665-7681-49b7-a234-fb8c0036a6e4")
```

#### Delegate methods

##### FCAccountCreationViewDelegate

The `onSuccess` method is triggered as soon as the account creation has been successfully completed.

Within the parameters, in the `nextFlowView` parameter a configured instance is returned with the required data of the next view to be presented within the suggested flow.

```swift
func accountCreationView(onSuccess: ServiceStatus, bank: Bank, nextFlowView: FCAccountStatusView) {
    // Your implementation
    let vc = UIViewController()
    vc.view.addSubview(nextFlowView)
    nextFlowView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
        nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
        nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
        nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
        nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
    ])

    self.present(vc, animated: true)
}
```

The `onFailure` method is executed when there is a problem during account creation, returning the relevant error message.

Within the parameters, the `nextFlowView` parameter returns a configured instance with the required data of the next view to be presented within the suggested flow. In this case, a defined error screen would be displayed.

```swift
func accountCreationView(onFailure: ServiceStatus, message: String, bank: Bank, nextFlowView: FCAccountStatusView) {
    // Your implementation
let vc = UIViewController()
        vc.view.addSubview(nextFlowView)
        nextFlowView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nextFlowView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            nextFlowView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            nextFlowView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            nextFlowView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])

        self.present(vc, animated: true)
}
```

The `accountCreated` method is optional and is executed each time the creation of an account is completed.

```swift
func accountCreationView(accountCreated: CredentialAccount) {
    // Your implementation
}
```

### FCAccountStatusView

This class presents a success or failure screen depending on whether it has transpired during the account creation process.

```swift
let accountStatusView = FCAccountStatusView()

view.addSubview(accountStatusView)
accountStatusView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    accountStatusView.topAnchor.constraint(equalTo: view.topAnchor),
    accountStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    accountStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    accountStatusView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])
```

#### Methods

The `setBank` method allows you to inject the bank data needed to customize the account status interface.

```swift
let bank = Bank(id: "1", name: "BBVA Bancomer", code: "BBVA", status: "Active")
accountStatusView.setBank(bank)
```

The `setStatus` method allows to indicate whether there was success or failure in the account creation process to display a completion or error interface accordingly.

```swift
accountStatusView.setStatus(.success)
accountStatusView.setStatus(.failure)
```

#### Delegate methods

The `didSelectContinueButton` delegate method allows you to implement the widget termination flow for continuation events, for example, if you would like to allow the user to add new credentials.

```swift
func accountStatusView(didSelectContinueButton: UIButton) {
    // Your implementation
}
```

The `didSelectExitButton` delegate method allows you to implement the widget's termination flow for termination events, for example, if you would like your user to not log back into the account aggregation flow and continue browsing in your own app.

```swift
func accountStatusView(didSelectExitButton: UIButton) {
    // Your implementation
}
```

-----

## Advanced integration

#### Logging and debugging

In some cases, you may find it useful to see what is happening inside the `FinerioConnectWidget`. If so, you can enable logging for debugging purposes.

```swift
finerioConnectWidget.logLevel = .info
```

## UI/UX customization

### Colors

You can create a new instance of the `Palette` class and assign it to `FinerioConnectWidget.shared.palette`.

```swift
FinerioConnectWidget.shared.palette = Palette(
    mainColor: .blue,
    mainTextColor: .black,
    mainSubTextColor: .gray,
    bankCellDetailColor: .white,
    bankCellSeparatorColor: .lightGray,
    termsTextColor: .lightGray,
    borderTextField: .lightGray,
    grayBackgroundColor: .darkGray)
```

The SDK has a default `Finerio Connect` color palette, if you want to customize the main color, you can do the following:

```swift
FinerioConnectWidget.shared.palette = Palette( 
  mainColor: .green 
)
```

Or even change the property directly, as follows:

```swift
FinerioConnectWidget.shared.palette.mainColor = .green
```

### Themes for Light and Dark Mode

We have prepared a default theme to toggle the user interface with iOS `Dark Mode` functionality. Additionally you can customize some of the component properties of each of the views included in this SDK. Either change them property by property or as a whole using the `Palette` object.

```swift
FinerioConnectWidget.shared.palette = Palette(
    banksBackground: FCColor(light: .red, dark: .blue),
    banksHeaderTitle: FCColor(light: .red, dark: .blue),
    banksHeaderSubtitle: FCColor(light: .red, dark: .blue),
    banksHeaderIcon: FCColor(light: .red, dark: .blue),
    banksHeaderIconBackground: FCColor(light: .red, dark: .blue),
    banksSelectCountryLabel: FCColor(light: .red, dark: .blue),
    banksSelectedCountryName: FCColor(light: .red, dark: .blue),
    banksSelectorFieldBackground: FCColor(light: .red, dark: .blue),
    banksCountrySelectorArrow: FCColor(light: .red, dark: .blue),
    banksCountryCellBackground: FCColor(light: .red, dark: .blue),
    banksSelectorFieldBorder: FCColor(light: .red, dark: .blue),
    credentialsFieldsTextPlaceholder: 
    banksSegmentedControlBackground: FCColor(light: .red, dark: .blue),
    banksSegmentedControlActiveItem: FCColor(light: .red, dark: .blue),
    banksSegmentedControlActiveText: FCColor(light: .red, dark: .blue),
    banksSegmentedControlText: FCColor(light: .red, dark: .blue),
    banksListCellBackground: FCColor(light: .red, dark: .blue),
    banksListCellTitle: FCColor(light: .red, dark: .blue),
    banksListCellSeparator: FCColor(light: .red, dark: .blue),
    banksCountryCellTitle: FCColor(light: .red, dark: .blue),
    banksListCellDisclosureIndicator: FCColor(light: .red, dark: .blue),
    credentialsBackground: FCColor(light: .red, dark: .blue),
    credentialsHeaderTitle: FCColor(light: .red, dark: .blue),
    credentialsHeaderSubtitle: FCColor(light: .red, dark: .blue),
    credentialsFieldsTitle: FCColor(light: .red, dark: .blue),
    credentialsFieldsBorder: FCColor(light: .red, dark: .blue),
    credentialsFieldsBackground: FCColor(light: .red, dark: .blue),
    credentialsFieldsIcon: FCColor(light: .red, dark: .blue),
    credentialsFieldsText: FCColor(light: .red, dark: .blue),
    credentialsSwitchOn: FCColor(light: .red, dark: .blue),
    credentialsTermsPlainText: FCColor(light: .red, dark: .blue),
    credentialsTermsLinkedText: FCColor(light: .red, dark: .blue),
    credentialsContinueButtonBackground: FCColor(light: .red, dark: .blue),
    credentialsContinueButtonText: FCColor(light: .red, dark: .blue),
    credentialsHelpButtonBackground: FCColor(light: .red, dark: .blue),
    credentialsHelpButtonText: FCColor(light: .red, dark: .blue),
    credentialsBannerBorder: FCColor(light: .red, dark: .blue),
    credentialsBannerIcon: FCColor(light: .red, dark: .blue),
    credentialsBannerText: FCColor(light: .red, dark: .blue),
    accountCreationBackground: FCColor(light: .red, dark: .blue),
    accountCreationHeaderTitle: FCColor(light: .red, dark: .blue),
    accountCreationHeaderSubtitle: FCColor(light: .red, dark: .blue),
    accountCreationStatusText: FCColor(light: .red, dark: .blue),
    accountStatusBackground: FCColor(light: .red, dark: .blue),
    accountStatusHeaderTitle: FCColor(light: .red, dark: .blue),
    accountStatusHeaderSubtitle: FCColor(light: .red, dark: .blue),
    accountStatusBodyText: FCColor(light: .red, dark: .blue),
    accountStatusSuccessIcon: FCColor(light: .red, dark: .blue),
    accountStatusFailureIcon: FCColor(light: .red, dark: .blue),
    accountStatusContinueButtonBackground: FCColor(light: .red, dark: .blue),
    accountStatusExitButtonBackground: FCColor(light: .red, dark: .blue),
    accountStatusContinueButtonText: FCColor(light: .red, dark: .blue),
    accountStatusExitButtonText: FCColor(light: .red, dark: .blue)
)
```

For each of the properties, it will be required to define a `UIColor` for the `Light` theme and optionally a `UIColor` for the `Dark` theme via the `FCColor` object.

Internally, the `SDK` will take care of evaluating whether to present the color for `Dark Mode` or `Light Mode` according to the context specifications.

```swift
FCColor(light: .red)
FCColor(light: .red, dark: .blue)
FCColor(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#000000"))
```

### Default theme

It is possible to assign a default theme to last for the entire account aggregation process flow, to specify it three different variants are provided: `.light`, `.dark` and `.automatic`. If not specified, it will take the value of `.light`. The `.automatic` variant will consider the operating system settings to display one theme or another.

```swift
FinerioConnectWidget.shared.theme = .dark
```

### Titles, captions and fonts

You can customize the SDK string texts to suit your application:

```swift
FinerioConnectWidget.shared.texts = Texts(
    companyName: "Finerio Connect",
    countriesTitle: "Seleccione un país",
    personalBankTitle: "Banca personal",
    businessBankTitle: "Banca empresarial",
    fiscalTitle: "Banca fiscal")
```

To customize the font, import your preferred font files and set them in the traditional way. Finally add the name of the font in the property:

```swift
FinerioConnectWidget.shared.font = "Ubuntu"
```

### Default values

When initializing your instance of `FinerioConnectWidget` you will be able to indicate some default values to preload the `FCBankSelectionView`according to your needs:

```swift
FinerioConnectWidget.shared.countryCode = "MX"
FinerioConnectWidget.shared.showCountryOptions = false
FinerioConnectWidget.shared.showBankTypeOptions = true
FinerioConnectWidget.shared.bankType = .personal
```

### Animations

The SDK has animations by default with `Lottie`. You only need to change the animations to files or URLs of your convenience:

```swift
FinerioConnectWidget.shared.animations = Animations(
    loadingAnimation: "https://assets3.lottiefiles.com/packages/lf20_d4dil7mw.json",
    accountCreationAnimation: "accountAnimation")
```
