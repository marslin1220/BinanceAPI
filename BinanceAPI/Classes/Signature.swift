//
//  Signature.swift
//  BinanceAPI
//
//  Created by Lin Cheng Lung on 2021/7/18.
//

import CryptoKit

struct Signature {
    enum SignatureError: Error {
        case messageEncodingFailed
        case keyEncodingFailed
    }

    func generate(_ message: String, key: String) throws -> String {
        guard let messageData = message.data(using: .utf8) else {
            throw SignatureError.messageEncodingFailed
        }
        
        guard let keyData = key.data(using: .utf8) else {
            throw SignatureError.keyEncodingFailed
        }

        let symmetricKey = SymmetricKey(data: keyData)
        let authCode = HMAC<SHA256>.authenticationCode(for: messageData, using: symmetricKey)

        return authCode.map { String(format: "%02hhx", $0) }.joined()
    }
}
