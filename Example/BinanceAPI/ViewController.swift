//
//  ViewController.swift
//  BinanceAPI
//
//  Created by Cheng Lung Lin on 07/18/2021.
//  Copyright (c) 2021 Cheng Lung Lin. All rights reserved.
//

import BinanceAPI
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let apiKeys = ApiKeys()
        let service = BinanceSavingService(apiKey: apiKeys.apiKey, secretKey: apiKeys.secretKey)
        service.getProductList { result in
            switch result {
            case let .success(products):
                print(products)
            case let .failure(error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

