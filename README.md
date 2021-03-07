# Finerio Connect iOS Widget

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Language](https://img.shields.io/badge/Language-Swift-orange.svg)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/FinerioAccountWidget.svg)](https://cocoapods.org/pods/FinerioAccountWidget)


Finerio Connect iOS Widget for the API Finerio Connect 2.0 reduces friction in the process of requesting their online banking credentials from your users, by taking care of the implementation and improving user experience.

## 📲 Installation


### Prerequisites

- You must have an active account with Finerio Connect 2.0

### Using [CocoaPods](https://cocoapods.org)

Edit your `Podfile` and specify the dependency:

```ruby
pod 'FinerioAccountWidget'
```

...or for spesific version


```ruby
pod 'FinerioAccountWidget', '~> 1.1'
```

and then run `pod install`. More info about CocoaPods [here](https://cocoapods.org)

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
             widgetId: "pparKeszQYwBF64A8WsWab5VDnVdE8QDnVCp2pgVubJRxyNU46",
             customerName: "René Sandoval",
             presentingViewController: self)
```

## 💡Advanced integration

### Logs and debugging

Logs and debugging
In some cases you'll find usefull to see what is happening inside FinerioConnectWidget. If so, you can enable logs for debugging purposes.

#### Swift

``` swift
finerioConnectWidget.logLevel = .info
```

### Customize colors

You can create a new instance of `Palette` class and assign it to `FinerioConnectWidget.shared.palette`

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
    synchronizationTitle: "Synchronization",
    mainFont: "Ubuntu"
)
```
### Customize animations

The SDK has animations by default with [Lottie](https://github.com/airbnb/lottie-ios) so , if you only need to change the animations by files or URL, yo can do this:

```swift
FinerioConnectWidget.shared.animations = Animations(
    syncingAnimation: "syncingAnimation",
    loadingAccountAnimation: "https://cdn.finerio.mx/widget/account_loading.json",
    accountReadyAnimation: "accountReadyAnimation",
    successAnimation: "successAnimation",
    failureAnimation: "https://cdn.finerio.mx/widget/syncing_failure.json"
)
```

## Dependency
  - Firebase iOS SDK with v7.7.0
  - SwiftyRSA with v1.6.0
  - Lottie iOS SDK with 3.2.1
