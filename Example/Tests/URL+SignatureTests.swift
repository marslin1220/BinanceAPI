//
//  URL+SignatureTests.swift
//  BinanceAPI_Tests
//
//  Created by Lin Cheng Lung on 2021/7/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import BinanceAPI

class URL_SignatureTests: XCTestCase {
    func testAppendSignature() throws {
        let url = URL(string: "https://www.example.com/path?symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559")!
        let urlWithSignature = URL(string: "https://www.example.com/path?symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559&signature=c8db56825ae71d6d79447849e617115f4a920fa2acdcab2b053c4b2838bd6b71")!
        let key = "NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j"
        let result = try url.appendSignature(with: key)
        XCTAssertEqual(result, urlWithSignature)
    }
}
