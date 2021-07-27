//
//  URL+UtilsTests.swift
//  BinanceAPI_Tests
//
//  Created by Lin Cheng Lung on 2021/7/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import BinanceAPI

class URL_UtilsTests: XCTestCase {
    func testAppendingSignature() throws {
        // Given
        let url = URL(string: "https://www.example.com/path?symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559")!
        let urlWithSignature = URL(string: "https://www.example.com/path?symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559&signature=c8db56825ae71d6d79447849e617115f4a920fa2acdcab2b053c4b2838bd6b71")!
        let key = "NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j"

        // When
        let result = try url.appendingSignature(with: key)

        // Then
        XCTAssertEqual(result, urlWithSignature)
    }

    func testAppendingTimestamp() throws {
        // Given
        let url = URL(string: "https://www.example.com/path?symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000")!
        let currentTimestamp = Int(Date().timeIntervalSince1970 * 1000)

        // When
        let result = try url.appendingTimestamp()

        // Then
        let components = try XCTUnwrap(URLComponents(url: result, resolvingAgainstBaseURL: true))
        let targetTimestamp = try XCTUnwrap(components.queryItems?.first { $0.name == "timestamp" }?.value)
        let targetTimeStampInt = try XCTUnwrap(Int(targetTimestamp))

        XCTAssertLessThanOrEqual(currentTimestamp, targetTimeStampInt)
        XCTAssertLessThanOrEqual(targetTimeStampInt - currentTimestamp, 5000)
    }
}
