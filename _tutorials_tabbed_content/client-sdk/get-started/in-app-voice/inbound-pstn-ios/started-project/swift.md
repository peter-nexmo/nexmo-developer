---
title: Swift
language: swift
menu_weight: 1
---


Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-PhoneToApp-Voice-Swift).

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `Constants.swift` file and replace the user token:

    ```swift
        enum Constant {
        static var userName = "Jane"
        static var userToken = "" //TODO: swap with a token for Jane
    }
    ```

2. Open `MainViewController.swift` file and make sure the following lines exist:

* `import NexmoClient` - imports the sdk
* `var client: NXMClient?` - property for the client instance
* `var call: NXMCall?` - property for the call instance
