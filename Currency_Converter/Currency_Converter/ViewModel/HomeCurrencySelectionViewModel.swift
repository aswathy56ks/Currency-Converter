//
//  HomeCurrencySelectionViewModel.swift
//  iOS_Test
//
//  Created by Aswathy Krishnan Sheela on 17/06/23.
//

import Foundation

class HomeCurrencySelectionViewModel {
    private var networkService: NetworkService

    var currencies: [String] = []
    var currencyRates: [String: Double] = [:]

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func fetchCurrencyRates(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        NetworkService.fetchCurrencyRates { result in
            switch result {
            case .success(let rates):
                self.currencyRates = rates
                self.currencies = Array(rates.keys)
                completion(.success(rates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

