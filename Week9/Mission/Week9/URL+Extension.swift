//
//  URL+Extension.swift
//  Week9
//
//  Created by 정재욱 on 11/30/23.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(_ lat: Double, _ lon: Double, _ lang: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Bundle.main.object(forInfoDictionaryKey: "Weatehr API Key") as! String)&lang=\(lang)&units=metric")
    }
}
