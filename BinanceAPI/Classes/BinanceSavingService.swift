//
//  BinanceSavingService.swift
//  BinanceAPI
//
//  Created by Lin Cheng Lung on 2021/8/15.
//

import Foundation

enum ServiceError: Error {
    case dataNotExisted
    case dataDecodeFailure
}

public struct BinanceSavingService {
    let client: BinanceClientProviding
    public init(apiKey: String, secretKey: String) {
        self.client = BinanceClient(apiKey: apiKey, secretKey: secretKey)
    }

    public func getProductList(handler: ((Result<[SavingProduct], Error>) -> Void)?) {
        let config = RequestConfig(
            path: "/sapi/v1/lending/daily/product/list",
            queries: [:],
            httpMethod: .GET)

        resumeTask(with: config, handler: handler)
    }

    private func resumeTask<T: Decodable>(with config: RequestConfig, handler: ((Result<T, Error>) -> Void)?) {
        do {
            let dataTask = try client.makeDataTask(with: config) { data, response, error in
                if let strongError = error {
                    handler?(.failure(strongError))
                    return
                }

                guard let jsonData = data else {
                    handler?(.failure(ServiceError.dataNotExisted))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let decodedObject = try decoder.decode(T.self, from: jsonData)
                    handler?(.success(decodedObject))
                } catch {
                    handler?(.failure(ServiceError.dataDecodeFailure))
                }
            }
            dataTask.resume()
        } catch {
            handler?(.failure(error))
        }
    }
}
