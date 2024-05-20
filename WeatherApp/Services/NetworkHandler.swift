//
//  NetworkHandler.swift
//  WeatherApp
//
//  Created by Samuel Adel on 20/05/2024.
//

import Foundation
protocol Fetchable {
    func fetchWeatherData(urlString:String,completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class DataFetcher: Fetchable {
    static let shared = DataFetcher()
    
    func fetchWeatherData(urlString:String,completion: @escaping (Result<WeatherModel, Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("No data found")
                    completion(.failure(NSError(domain: "NetworkHandler", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(WeatherModel.self, from: data)
                    completion(.success(weather))
                } catch {
                    print("Error decoding data: \(error)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
}
