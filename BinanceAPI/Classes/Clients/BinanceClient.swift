//
//  BinanceClient.swift
//  BinanceAPI
//
//  Created by Lin Cheng Lung on 2021/8/1.
//

import Foundation

public enum BinanceClientError: Error {
    case configureFailed
}

public struct BinanceClient {
    let apiKey: String
    let secretKey: String

    public init(apiKey: String, secretKey: String) {
        self.apiKey = apiKey
        self.secretKey = secretKey
    }

    public func makeDataTask(
        with config: RequestConfig,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) throws -> URLSessionDataTask {

        var request = try makeRequest(with: config)
        request.setValue(apiKey, forHTTPHeaderField: "X-MBX-APIKEY")
        request.httpMethod = config.httpMethod.rawValue

        return URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }

    private func makeRequest(with config: RequestConfig) throws -> URLRequest {
        let baseUrl = getBaseUrl()
        var baseUrlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        baseUrlComponents?.path = config.path
        baseUrlComponents?.query = config.queries.reduce("") { "\($0 ?? "")&\($1.key)=\($1.value)" }

        guard let url = baseUrlComponents?.url else {
            throw BinanceClientError.configureFailed
        }

        let resultUrl: URL
        if config.withSignature {
            resultUrl = try url.appendingTimestamp()
                .appendingSignature(with: secretKey)
        } else {
            resultUrl = url
        }

        return URLRequest(url: resultUrl)
    }

    private func getBaseUrl() -> URL {
        URL(string: "https://api.binance.com/")!
    }
}

public struct RequestConfig {
    let path: String
    let queries: [String: String]
    let httpMethod: HTTPMethod
    let withSignature: Bool

    public init(path: String, queries: [String : String], httpMethod: HTTPMethod, withSignature: Bool = true) {
        self.path = path
        self.queries = queries
        self.httpMethod = httpMethod
        self.withSignature = withSignature
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
