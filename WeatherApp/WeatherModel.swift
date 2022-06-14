//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import Foundation

struct Location {
    // 공주, 광주, 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울,
    // 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
    static let cityList = [
        "Gongju",
        "Gwangju",
        "Gumi",
        "Gunsan",
        "Daegu",
        "Daejeon",
        "Mokpo",
        "Busan",
        "Seosan",
        "Seoul",
        "Sokcho",
        "Suwon",
        "Suncheon",
        "Ulsan",
        "Iksan",
        "Jeonju",
        "Jeju",
        "Cheonan",
        "Cheongju",
        "Chuncheon",
    ]
}

// 도시이름, 날씨아이콘, 현재기온, 현재습도
// 체감기온, 최저기온, 최고기온, 기압, 풍속, 날씨 설명
struct WeatherInfo: Codable, Hashable {
    
    static func == (lhs: WeatherInfo, rhs: WeatherInfo) -> Bool {
        return lhs.cityName == rhs.cityName
    }
    
    var cityName: String
    var weather: [WeatherData]
    var main: MainData
    var wind: WindData

    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case weather
        case main
        case wind
    }
}

struct WeatherData: Codable, Hashable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainData: Codable, Hashable {
    var temp: Double
    var sensibleTemp: Double
    var minTemp: Double
    var maxTemp: Double
    var pressure: Int
    var humidity: Int

    private enum CodingKeys: String, CodingKey {
        case temp
        case sensibleTemp = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}

struct WindData: Codable, Hashable {
    var speed: Double
}
