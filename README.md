# NewsReader

An iOS UIKit prototype of an online News Reader.

## Features

| ![Simulator Screen Shot - iPhone 14 Pro Max - 2023-02-15 at 14 03 46](https://user-images.githubusercontent.com/545146/218926952-a8e64493-4043-46ba-9c05-899fa1b46a6f.png) | ![Simulator Screen Shot - iPhone 14 Pro Max - 2023-02-15 at 14 03 55](https://user-images.githubusercontent.com/545146/218926964-2d5b4982-0ae5-448e-9cb4-4944d19502f8.png) | ![Simulator Screen Shot - iPhone 14 Pro Max - 2023-02-15 at 14 04 04](https://user-images.githubusercontent.com/545146/218926982-2f6a5edb-82b4-4731-9e04-265f13856644.png) |
| - | - | - |

## Get Started

* Xcode 14.1 (Xcode 13.x not available due to developer's macOS version requirement).
* Open the `NewsReader.xcodeproj` and start building.
* Swift Package Manager is used as the dependency manager of choice, so no further installation steps required.
* Unit tests are included as part of the main `NewsReader` scheme.
* For UI tests, switch to `NewsReaderUITests` scheme to trigger.

## Architecture

There are 2 main layers of the application:

* **Presentation** layer for controlling the UI, MVVM is used with closure callbacks for data binding due to its simplicity. For more complex data binding mangements a Functional Reactive Programming framework should be used e.g. Combine, RxSwift, ReactiveSwift etc.
* **Data** layer for handling API requests and local storages, all calls to data providers (`URLSession`, `UserDefaults` etc.) are wrapped inside protocols to utilise dependency injection for testing purpose.

## 3rd party libraries

* [Kingfisher](https://github.com/onevcat/Kingfisher) for asynchronous image loading & caching.
* [Ambassador](https://github.com/envoy/Ambassador) for stubbing network requests in UI tests.

## Notes

* All screens are sharing a single `Main.storyboard` file, can split out into separate storyboards for better management.
* Navigation are performed directly inside view controllers, coordinator/router pattern can be utilised to improve reusability and testability of navigations.
* Timestamp values from the JSON are parsed as `Int`, property wrappers can be implemented to automate the parsing of this value into `Date` type for more usability client side.
* Article Details screen has no view model due to its simplicity, can introduce as more requirements arise.
