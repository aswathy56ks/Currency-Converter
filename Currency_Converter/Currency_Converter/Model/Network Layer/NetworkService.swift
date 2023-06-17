//
//  NetworkService.swift
//  iOS_Test
//
//  Created by Aswathy Krishnan Sheela on 17/06/23.
//

import Foundation

struct CurrencyRatesResponse: Codable {
    let rates: [String: Double]
}

class NetworkService {
    static func fetchCurrencyRates(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        let urlString = "http://api.exchangeratesapi.io/v1/latest?access_key=a00e38904673a306195a8cec5eb29cc3&format=1"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let response = try JSONDecoder().decode(CurrencyRatesResponse.self, from: data)
                completion(.success(response.rates))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

