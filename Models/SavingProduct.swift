//
//  SavingProduct.swift
//  BinanceAPI
//
//  Created by Lin Cheng Lung on 2021/8/22.
//

import Foundation

// https://binance-docs.github.io/apidocs/spot/en/#get-flexible-product-list-user_data
public struct SavingProduct: Codable {
    let asset: String
    let avgAnnualInterestRate: Decimal?
    let canPurchase: Bool
    let canRedeem: Bool
    let featured: Bool
    let minPurchaseAmount: Decimal?
    let productId: String
    let purchasedAmount: Decimal?
    let status: String
    let upLimit: Decimal?
    let upLimitPerUser: Decimal?
    var tierAnnualInterestRate: [String: Decimal?]?

    enum CodingKeys: String, CodingKey {
        case asset
        case avgAnnualInterestRate
        case canPurchase
        case canRedeem
        case featured
        case minPurchaseAmount
        case productId
        case purchasedAmount
        case status
        case upLimit
        case upLimitPerUser
        case tierAnnualInterestRate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        asset = try container.decode(String.self, forKey: .asset)
        avgAnnualInterestRate = Decimal(string: try container.decode(String.self, forKey: .avgAnnualInterestRate))
        canPurchase = try container.decode(Bool.self, forKey: .canPurchase)
        canRedeem = try container.decode(Bool.self, forKey: .canRedeem)
        featured = try container.decode(Bool.self, forKey: .featured)
        minPurchaseAmount = Decimal(string: try container.decode(String.self, forKey: .minPurchaseAmount))
        productId = try container.decode(String.self, forKey: .productId)
        purchasedAmount = Decimal(string: try container.decode(String.self, forKey: .purchasedAmount))
        status = try container.decode(String.self, forKey: .status)
        upLimit = Decimal(string: try container.decode(String.self, forKey: .upLimit))
        upLimitPerUser = Decimal(string: try container.decode(String.self, forKey: .upLimitPerUser))
        if let stringDict = try? container.decode([String: String].self, forKey: .tierAnnualInterestRate) {
            tierAnnualInterestRate = Dictionary(uniqueKeysWithValues: stringDict.map { ($0.0, Decimal(string: $0.1)) })
        }
    }
}
