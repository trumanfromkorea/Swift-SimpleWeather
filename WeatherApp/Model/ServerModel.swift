//
//  ServerModel.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import Foundation

// api 관련 모델
struct Server {
    static let apiKey = ""
    static let imageUrl = "http://openweathermap.org/img/wn/"

    // image id 에 따라 url 구성
    static func getImageUrl(_ id: String) -> String {
        return imageUrl + id + "@2x.png"
    }

    // 20개 도시 id 모두 url 에 삽입
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
