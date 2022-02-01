# Finerio Connect iOS Widget
![Language](https://img.shields.io/badge/Language-Swift-orange.svg) [![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FinerioAccountWidget.svg)](https://cocoapods.org/pods/FinerioAccountWidget)

Finerio Connect iOS Widget for the API Finerio Connect 2.0 reduces friction in the process of requesting their online banking credentials from your users, by taking care of the implementation and improving user experience.

## 📲 Installation


### Prerequisites

- You must have an active account with Finerio Connect 2.0

### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod 'FinerioAccountWidget'
```

...or for a specific version


```ruby
pod 'FinerioAccountWidget', '~> 1.5'
```

and then run `pod install --repo-update`. More info about CocoaPods [here](https://cocoapods.org)

## ⚙️ Use

In your application add the following code:


First import the module:

``` swift
import FinerioAccountWidget
```

and then the start:

``` swift
let finerioConnectWidget = FinerioConnectWidget.shared
finerioConnectWidget.start(
             widgetId: "your_widget_id",
             customerName: "René Sandoval",
             presentingViewController: self)
```

## 💡Advanced integration

### Environment

The default environment is `sandbox`, you can do this:
``` swift
finerioConnectWidget.environment = .production
```

### Logs and debugging

Logs and debugging
In some cases, you'll find it useful to see what is happening inside FinerioConnectWidget. If so, you can enable logs for debugging purposes.


``` swift
finerioConnectWidget.logLevel = .info
```

### Country

You can configure the list of banks based on a country, the available countries are Mexico, Colombia, and Chile.
The default country is Mexico (MX), you can
do this to assign a country based on its codes (`MX, CO, CH`)
``` swift
finerioConnectWidget.countryCode = "CO"
```

You can also choose if you want to hide the options to choose country, the default value is `true`, you can do this:
``` swift
finerioConnectWidget.showCountryOptions = false
```

### Banks Type

You can configure the default load of a bank type, the available types are: Personal, Business, and Fiscal. The default type is personal (.personal), you can do this to assign a type based on the enumerable (.personal, .business, .fiscal)

``` swift
finerioConnectWidget.bankType = .business
```

You can also choose if you want to hide the options to choose the bank type, the default is `true`, you can do this:
``` swift
finerioConnectWidget.showBankTypeOptions = false
```

### Custom fonts

You can customize the default SDK font by adding the font name, keeping the following convention in mind:

- Ubuntu[-Light]

- Ubuntu[-Regular]

- Ubunt[-Bold]

- Ubuntu[-Italic]

``` swift
finerioConnectWidget.font = "Ubuntu"
```

### Customize colors

You can create a new instance of the `Palette` class and assign it to `FinerioConnectWidget.shared.palette`

```swift
FinerioConnectWidget.shared.palette = Palette(
    mainColor: .blue,
    backgroundColor: .white,
    mainTextColor: .darkGray,
    termsTextColor: .lightText
)
```

The SDK has FinerioConnectWidget colors by default so, if you only need to change the main color, yo can do this:

```swift
FinerioConnectWidget.shared.palette = Palette(
    mainColor: .green
)
```

Or even directly change the property

```swift
FinerioConnectWidget.shared.palette.mainColor = .green
```

### Customize string texts

You can customize the SDK string texts to fit your app:

```swift
FinerioConnectWidget.shared.texts = Texts(
    companyName: "Finerio Connect",
    banksTitle: "Banks Availables",
    createCredentialTitle: "Enter your credentials for ?",
    submitLabel: "Submit",
    synchronizationTitle: "Synchronization"
)
```
### Customize animations

The SDK has animations by default with [Lottie](https://github.com/airbnb/lottie-ios) so, if you only need to change the animations by files or URL, you can do this:

```swift
FinerioConnectWidget.shared.animations = Animations(
    syncingAnimation: "syncingAnimation",
    loadingAccountAnimation: "https://cdn.finerio.mx/widget/account_loading.json",
    accountReadyAnimation: "accountReadyAnimation",
    successAnimation: "successAnimation",
    failureAnimation: "https://cdn.finerio.mx/widget/syncing_failure.json"
)
```