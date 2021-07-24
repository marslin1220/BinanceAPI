//
//  SignatureTests.swift
//  BinanceAPI_Tests
//
//  Created by Lin Cheng Lung on 2021/7/24.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import BinanceAPI

class SignatureTests: XCTestCase {

    func testGenerateSignature() throws {
        // Given
        let message = "symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559"
        let key = "NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j"
        let sut = Signature()

        // When
        let signature = try sut.generate(message, key: key)

        // Then
        XCTAssertEqual(signature, "c8db56825ae71d6d79447849e617115f4a920fa2acdcab2b053c4b2838bd6b71")
    }

}
