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

and then run `pod install --repo-update`. More information about `Cocoapods` [here](https://cocoapods.org/).

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

### FinerioConnectWidget Properties

```swift
let finerioConnectWidget = FinerioConnectWidget.shared
// (Required) Enum to pre-select an environment to work with. Values: [.production, .sandbox]
finerioConnectWidget.environment = .production
// (Optional) Flag to enable or disable the Zendesk help integration chat. DefaultValue: true
finerioConnectWidget.showChat = true
// (Optional) Flag to enable or disable the presentation of an Onboarding flow. DefaultValue: true
finerioConnectWidget.showOnboarding = false
// (Optional) Property to set a custom instance of Onboarding class to display in the Onboarding flow. DefaultValue: nil
finerioConnectWidget.onboarding = Onboarding()
// (Optional) The font name of a given custom font to use in the workflow. DefaultValue: ""
finerioConnectWidget.font = "Ubuntu"
// (Optional) The country code to use in order to fetch banks of that country by default. DefaultValue: ""
finerioConnectWidget.countryCode = "MX"
// (Optional) Flag to enable or disable the Countries dropdown menu from the UI. DefaultValue: true.
finerioConnectWidget.showCountryOptions = false
// (Optional) Flag to enable or disable the BankType selector from the UI. DefaultValue: true.
finerioConnectWidget.showBankTypeOptions = true
// (Optional) Enum to pre-select the BankType from the UI. Values: [.personal, .business, .fiscal] DefaultValue: .personal
finerioConnectWidget.bankType = .personal
// (Optional) Enum to pre-select a theme for the UI. Values: [.automatic, .light, .dark] DefaultValue: .light
finerioConnectWidget.theme = .automatic
// (Optional) Property to set a custom instance of Texts class to display within the worflow. DefaultValue: nil
finerioConnectWidget.texts = Texts(companyName: "Super Bank Company")
// (Optional) Property to set a custom instance of Animations class to display in wait or loading scenarios. DefaultValue: nil
finerioConnectWidget.animations = Animations()
// (Optional) Property to set a custom instance of Palette class to display your custom colors in the components. DefaultValue: nil
finerioConnectWidget.palette = Palette()
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

### Default Colors

Our brand palette of colors is used across the widget's process as a default palette.

```swift
    // LIGHT THEME
    private static let cetaceanBlue = UIColor(hex: "#00113D")!
    private static let americanBlue = UIColor(hex: "#333F65")!
    private static let eucalyptus = UIColor(hex: "#3FD8AF")!
    private static let antiFlashWhite = UIColor(hex: "#F1F2F5")!
    private static let manatee = UIColor(hex: "#989DB3")!
    private static let lightPeriwinkle = UIColor(hex: "#CACDD9")!
    private static let brightGray = UIColor(hex: "#EEEEF0")!
    private static let darkBlueGray = UIColor(hex: "#656E8D")!
    private static let lightSalmonPink = UIColor(hex: "#F89A9A")!
    // DARK THEME
    private static let white = UIColor(hex: "#FFFFFF")!
    private static let caribeanGreen = UIColor(hex: "#07CEA4")!
    private static let arsenic = UIColor(hex: "#373946")!
    private static let darkGunMetal = UIColor(hex: "#24252D")!
    private static let eerieBlack = UIColor(hex: "#1B1A21")!
```

And is grouped by common components and a few number of properties to handle all the personalization across the views.

## Themes for Light and Dark Mode

We have prepared a default theme to toggle the user interface with iOS `Dark Mode` functionality. Additionally you can customize some components properties for the light and dark themes with your own branding colors.

```swift
FinerioConnectWidget.shared.palette = Palette(
    // Tint color for the icon rounded by a circle.
    circleIconTint: FCColor(light: .red, dark: .blue),
    // Background color for the circle that contains an icon.
    circleIconBackground: FCColor(light: .red, dark: .blue),
    // Background color for the buttons that performs a next or continue flow action.
    buttonActiveBackground: FCColor(light: .red, dark: .blue),
    // Tint color for the title of buttons that performs a next or continue flow action.
    buttonActiveText: FCColor(light: .red, dark: .blue),
    // Background color for the buttons that performs an exit or stops the flow action.
    buttonPassiveBackground: FCColor(light: .red, dark: .blue),
    // Tint color for the title of buttons that performs an exit or stops the flow action.
    buttonPassiveText: FCColor(light: .red, dark: .blue),
    // Background color used in all the views
    backgroundView: FCColor(light: .red, dark: .blue),
    // Tint color commonly used for the paragraph texts or normal texts.
    regularSizedText: FCColor(light: .red, dark: .blue),
    // Tint color used in phrases or titles to distinguish from others descriptions.
    mediumSizedText: FCColor(light: .red, dark: .blue),
    // Tint color used in linked texts that redirects to a web site or a view within the flow.
    linkedText: FCColor(light: .red, dark: .blue),
    // Background color used in the text fields.
    fieldsBackground: FCColor(light: .red, dark: .blue),
    // Border tint  color used in the text fields.
    fieldsBorder: FCColor(light: .red, dark: .blue),
    // Tint color used in the right icons of the text fields.
    fieldsRightIcon: FCColor(light: .red, dark: .blue),
    // Background color for segmented controls
    segmentedControlBackground: FCColor(light: .red, dark: .blue),
    // Background color for the active part of segmented controls
    segmentedControlActiveItem: FCColor(light: .red, dark: .blue),
    // Tint color for the text in the dropdown menu
    dropDownMenuTint: FCColor(light: .red, dark: .blue),
    // Tint color for the on status of the toggle switch
    toggleSwitchOn: FCColor(light: .red, dark: .blue),
    // Border color of the banner component
    bannerBorder: FCColor(light: .red, dark: .blue),
    // Tint color for the success icon shown after a correct synchronization process
    successIconTint: FCColor(light: .red, dark: .blue),
    // Tint color for the failure icon shown after a failed synchronization process
    failureIconTint: FCColor(light: .red, dark: .blue),
    // Background color for the status bar
    statusBarBackground: FCColor(light: .red, dark: .blue),
    // Tint color for the phrases or paragraphs with a thin text
    liteText: FCColor(light: .red, dark: .blue),
    // Tint color used in the cell separators of tables
    cellSeparator: FCColor(light: .red, dark: .blue),
    // Tint color used in the icons of disclosure indicators within the cells of tables
    cellDisclosureIndicator: FCColor(light: .red, dark: .blue),
    // Tint color used in the placeholders of the text fields
    fieldsPlaceholder: FCColor(light: .red, dark: .blue),
    // Tint color used in the icon of the close button of the dialog alerts
    dialogCloseButton: FCColor(light: .red, dark: .blue),
    // Tint color used in the current dot of the page control of onboarding components
    pageDotActive: FCColor(light: .red, dark: .blue),
    // Tint color used in the unselected dots of the page control of onboarding components
    pageDotInactive: FCColor(light: .red, dark: .blue)
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
    // Your company name
    companyName: "your_text",
    // The title to be displayed on the BanksListView
    banksHeaderTitle: "your_text",
    // A subtitle to be displayed on the BanksListView
    banksHeaderSubtitle: "your_text",
    // The text that brings context in the select country section of BanksListView
    selectCountryLabel: "your_text",
    // The name to refer to a personal bank type
    personalBankType: "your_text",
    // The name to refer to a business bank type
    businessBankType: "your_text",
    // The name to refer to a fiscal bank type
    fiscalBankType: "your_text",
    // The message to present when there's no banks to show
    titleWithoutBanks: "your_text",
    // The title to be displayed on the CredentialsView
    credentialsHeaderTitle: "your_text",
    // A subtitle to be displayed on the CredentialsView
    credentialsHeaderSubtitle: "your_text",
    // The full plain text to show in a linked text
    plainTyCText: "your_text",
    // The part of text to show with underline in a linked text and that will perform an event.
    linkedTyCText: "your_text",
    // The title to show in the Help button on CredentialsView
    helpWithCredentialsButton: "your_text",
    // The disclaimer text to show on the CredentialsView
    credentialsDisclaimerText: "your_text",
    // The title to be displayed on the SyncAccountsView
    syncHeaderTitle: "your_text",
    // A subtitle to be displayed on the SyncAccountsView
    syncHeaderSubtitle: "your_text",
    // The text that describes the status of the SyncAccountsView
    encryptingData: "your_text",
    // The title to be displayed on the StatusAccountView in case of successfuly process i.e. Congratulations!
    bondingHeaderTitleSuccess: "your_text",
    // The title to be displayed on the StatusAccountView in case of failure process i.e Ops! something goes wrong.
    bondingHeaderTitleFailure: "your_text",
    // A subtitle to be displayed on the StatusAccountView in case of successfuly process i.e communication error
    bondingHeaderSubtitleSuccess: "your_text",
    // A subtitle to be displayed on the StatusAccountView in case of failure process i.e. account saved
    bondingHeaderSubtitleFailure: "your_text",
    // A description to be displayed on the StatusAccountView in case of successfuly process i.e added with success detail
    bondingDescriptionSuccess: "your_text",
    // A description to be displayed on the StatusAccountView in case of failure process i.e. error connection detail
    bondingDescriptionFailure: "your_text",
    // A title for the button to retry the workflow
    failureContinueTitleButton: "your_text",
    // A title for the button to stops the workflow or cancels the process.
    failureExitTitleButton: "your_text",
    // A title for the button to continue the workflow
    successContinueTitleButton: "your_text",
    // A title for the button to stops the workflow or cancels the process.
    successExitTitleButton: "your_text",
    // A title for the button to continue the workflow
    onboardingMainContinueButton: "your_text",
    // A title for the button to stops the workflow or cancels the process.
    onboardingMainExitButton: "your_text",
    // A title for the button to continue the workflow of pages
    onboardingStepContinueButton: "your_text",
    // A title for the button to continue the workflow of pages
    onboardingStepNextButton: "your_text",
    // A title for the button to stops the workflow or cancels the process.
    onboardingStepExitButton: "your_text"
)
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

## Onboarding Flow

The SDK provides a default onboarding flow that can be enabled or disabled in the Widget's Aggregation process. This views can be customized with the given `Palette` of styles. This onboarding process gets called only once during the Widget's Aggregation process.

```swift
FinerioConnectWidget.shared.showOnboarding = true
```

### Customized Pages

The onboarding flow provides a class to inject your custom images and data to present in your own onboarding process. To inject this data you need to enable the `showOnboarding` flag and set the `Onboarding` instance as follows:

```swift
FinerioConnectWidget.shared.showOnboarding = true
FinerioConnectWidget.shared.onboarding = Onboarding(
    main: Onboarding.Main(icon: UIImage(systemName: "gamecontroller")!,
                          title: "Main page title",
                          description: "Description for main page",
                          actionText: TextWithLink(fullPlainText: "Link to show pages")),
    pages: [Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.up.filled")!,
                                      icon: UIImage(systemName: "dpad.up.filled")!,
                                      title: "Bullet Title One",
                                      detail: TextWithLink(fullPlainText: "Description for page one")),
            Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.right.filled")!,
                                      icon: UIImage(systemName: "dpad.right.filled")!,
                                      title: "Bullet Title Two",
                                      detail: TextWithLink(fullPlainText: "Description for page two")),
            Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.down.filled")!,
                                      icon: UIImage(systemName: "dpad.down.filled")!,
                                      title: "Bullet Title Three",
                                      detail: TextWithLink(fullPlainText: "Description for page three")),
            Onboarding.OnboardingPage(image: UIImage(systemName: "dpad.left.filled")!,
                                      icon: UIImage(systemName: "dpad.left.filled")!,
                                      title: "Bullet Title Four",
                                      detail: TextWithLink(fullPlainText: "Description for page four"))
])
```

### Reset Onboarding Flow

In order to handle the reset of the onboarding flow we provide some properties that can be used with some logic to perform a custom reset flow.

```swift
// To know if a user has saw the onboarding flow once.
finerioConnectWidget.hasShownOnboarding = true 
// To show the onboarding tutorial
finerioConnectWidget.showOnboarding = true
```

As an example, if you have some control version of your app or releases, you can configure the logic to reset the onboarding flow every time you update or deploy a new release version.

```swift
if currentVersion > oldVersion {
    // this will reset the onboarding
    finerioConnectWidget.hasShownOnboarding = false
    // You can inject your new features in pages of the Onboarding
    finerioConnectWidget.onboarding = Onboarding()
}
```
