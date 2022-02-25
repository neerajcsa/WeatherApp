//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import Foundation

struct Endpoints {
    fileprivate static let baseApi = "https://api.openweathermap.org/data/2.5/onecall?exclude=current,minutely,daily,alerts&units=metric"
    
    static let weatherImage = "https://openweathermap.org/img/wn"
    
    static let apiKey = "c0241b7eaa1037e53d1e7a35ebce0f48"
}

enum WeatherError : String, Error {
    case unableToComplete = "Unable to complete your request. Please chekc your internet connection."
    case invalidURL = "Please check the URL once again."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
}

class NetworkManager {
    
    static let shared = NetworkManager()
        
    private init() { }
        
    func getWeatherData(latitude : String, longitude : String, completionHandler : @escaping (Result<WeatherModel, WeatherError>) -> Void) {
        let endpoints = Endpoints.baseApi + "&lat=\(latitude)&lon=\(longitude)&appid=\(Endpoints.apiKey)"
        
        guard let url = URL(string: endpoints) else {
            completionHandler(.failure(.invalidURL))
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                completionHandler(.success(weatherData))
            } catch(let error) {
                debugPrint(error.localizedDescription)
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
