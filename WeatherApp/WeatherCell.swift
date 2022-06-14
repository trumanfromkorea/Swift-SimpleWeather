//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"

    @IBOutlet var cityNameLabel: UILabel!

    func configure(_ weather: WeatherModel) {
        cityNameLabel.text = CityModel.cities.first { $0.id == weather.id }?.koreanName
    }
}
