//
//  ServerModel.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import Foundation

struct Server {
    static let apiKey = "190022c5e2d95c8cd9c30099308d857c"

    static func getUrlWithCity(_ cityName: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
    }

    static func getUrlWithCities(_ cities: [CityModel]) -> String {
        var params = ""

        for city in cities {
            params += "\(city.id),"
        }
        params.removeLast()

        let url = "http://api.openweathermap.org/data/2.5/group?id=\(params)&units=metric&appid=\(apiKey)"
        
        return url
    }
}
