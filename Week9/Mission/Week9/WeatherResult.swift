//
//  WeatherModel.swift
//  Week9
//
//  Created by 정재욱 on 11/30/23.
//

import Foundation

struct WeatherResult: Decodable {
    let weather: [WeatherWeather]
    let main: WeatherMain
    let name: String
}

extension WeatherResult {
    static var empty: WeatherResult {
        return WeatherResult(
            weather: [WeatherWeather(id: 800, description: "")],
            main: WeatherMain(temp: 0.0, temp_min: 0.0, temp_max: 0.0, humidity: 0.0),
            name: ""
        )
    }
}

struct WeatherWeather: Decodable {
    let id: Int
    let description: String
}

struct WeatherMain: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}
