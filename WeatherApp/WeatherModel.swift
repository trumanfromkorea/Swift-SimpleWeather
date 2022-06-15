//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import Foundation

struct CityModel {
    var id: Int
    var koreanName: String

    // 공주, 광주, 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울,
    // 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
    static let cities = [
        CityModel(id: 1842616, koreanName: "공주"),
        CityModel(id: 1841811, koreanName: "광주"),
        CityModel(id: 1842225, koreanName: "구미"),
        CityModel(id: 1842025, koreanName: "군산"),
        CityModel(id: 1835327, koreanName: "대구"),
        CityModel(id: 1835224, koreanName: "대전"),
        CityModel(id: 1841066, koreanName: "목포"),
        CityModel(id: 1838524, koreanName: "부산"),
        CityModel(id: 1835895, koreanName: "서산"),
        CityModel(id: 1835848, koreanName: "서울"),
        CityModel(id: 1836553, koreanName: "속초"),
        CityModel(id: 1835553, koreanName: "수원"),
        CityModel(id: 1835648, koreanName: "순천"),
        CityModel(id: 1833747, koreanName: "울산"),
        CityModel(id: 1843491, koreanName: "익산"),
        CityModel(id: 1845457, koreanName: "전주"),
        CityModel(id: 1846266, koreanName: "제주"),
        CityModel(id: 1845759, koreanName: "천안"),
        CityModel(id: 1845604, koreanName: "청주"),
        CityModel(id: 1845136, koreanName: "춘천"),
    ]
}

// 도시이름, 날씨아이콘, 현재기온, 현재습도
// 체감기온, 최저기온, 최고기온, 기압, 풍속, 날씨 설명
struct WeatherResponse: Codable, Hashable {
    var list: [WeatherModel]
}

struct WeatherModel: Codable, Hashable {
    var id: Int
    var cityName: String
    var weather: [WeatherData]
    var main: MainData
    var wind: WindData

    private enum CodingKeys: String, CodingKey {
        case id
        case cityName = "name"
        case weather
        case main
        case wind
    }
    
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func generateTemp(_ temp: Double) -> String {
        return "\(Int(temp))°C"
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

// DetailsCell 위한 인스턴스
struct DetailsModel: Hashable {
    var key: String
    var value: String
}
