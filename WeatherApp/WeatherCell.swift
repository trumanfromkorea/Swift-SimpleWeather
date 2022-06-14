//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"

    @IBOutlet var koreanNameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    func configure(_ weather: WeatherModel) {
        koreanNameLabel.text = CityModel.cities.first { $0.id == weather.id }?.koreanName
        englishNameLabel.text = weather.cityName
        tempLabel.text = WeatherModel.generateTemp(weather.main.temp)
        humidityLabel.text = "\(weather.main.humidity)%"
    }
}
