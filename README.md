# BinanceAPI

[![CI Status](https://img.shields.io/travis/Cheng%20Lung%20Lin/BinanceAPI.svg?style=flat)](https://travis-ci.org/Cheng%20Lung%20Lin/BinanceAPI)
[![Version](https://img.shields.io/cocoapods/v/BinanceAPI.svg?style=flat)](https://cocoapods.org/pods/BinanceAPI)
[![License](https://img.shields.io/cocoapods/l/BinanceAPI.svg?style=flat)](https://cocoapods.org/pods/BinanceAPI)
[![Platform](https://img.shields.io/cocoapods/p/BinanceAPI.svg?style=flat)](https://cocoapods.org/pods/BinanceAPI)

The framework BinanceAPI is written in Swift as a client of [Binance API service](https://binance-docs.github.io/apidocs) to monitor the market status or even trade the cryptocurrencies with that.

## Example

To run the example project:

1. Clone the [repo](https://github.com/marslin1220/BinanceAPI).
2. Run `pod install` from the Example directory first.
3. Following the [How to Create API](https://www.binancezh.top/en/support/faq/360002502072) tutorial to create the API and Secret keys
4. Put the keys as parameters of the service (e.g.  `BinanceSavingService` ) contructors.

```swift
let service = BinanceSavingService(
  apiKey: "Replace it with your API Key",
  secretKey: "Replace it with your Secret Key"
)
service.getProductList { result in
    switch result {
    case let .success(products):
        print(products)
    case let .failure(error):
        print(error)
    }
}
```

## Requirements

## Installation

BinanceAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BinanceAPI'
```

## Author

Cheng Lung Lin, marslin@gmail.com

## License

BinanceAPI is available under the MIT license. See the LICENSE file for more info.
