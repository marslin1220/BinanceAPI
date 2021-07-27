//
//  URL+Utils.swift
//  BinanceAPI
//
//  Created by Lin Cheng Lung on 2021/7/26.
//

import Foundation

enum QuerySignatureError: Error {
    case noQueryString
    case componentEncodeFailed
    case urlDecodeFailed
}

extension URL {
    func appendingSignature(with key: String) throws -> URL {
        guard let queryString = self.query else { throw QuerySignatureError.noQueryString }
        let signatureProvider = Signature()

        let signature = try signatureProvider.generate(queryString, key: key)

        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            throw QuerySignatureError.componentEncodeFailed
        }

        components.queryItems?.append(URLQueryItem(name: "signature", value: signature))

        guard let url = components.url else {
            throw QuerySignatureError.urlDecodeFailed
        }

        return url
    }

    func appendingTimestamp() throws -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            throw QuerySignatureError.componentEncodeFailed
        }

        let timestamp = Int(Date().timeIntervalSince1970 * 1000)
        components.queryItems?.append(URLQueryItem(name: "timestamp", value: "\(timestamp)"))

        guard let url = components.url else {
            throw QuerySignatureError.urlDecodeFailed
        }

        return url
    }
}
