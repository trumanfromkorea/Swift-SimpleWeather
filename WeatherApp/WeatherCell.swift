//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    func configure(_ weatherInfo: WeatherInfo) {
        cityNameLabel.text = weatherInfo.cityName
    }
    
}
