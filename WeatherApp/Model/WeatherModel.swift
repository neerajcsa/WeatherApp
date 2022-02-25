//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import Foundation

struct WeatherModel : Decodable {
    let hourly : [WeatherList]
}

struct WeatherList : Decodable {
    let dt : UInt
    let temp : Double
    let feels_like : Double
    let humidity : Int
    let clouds : Int
    let visibility: Int
    let wind_speed : Double
    let wind_deg : Int
    let weather : [MainWeather]
}

struct MainWeather : Decodable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}

    
