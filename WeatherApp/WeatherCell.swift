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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .tertiarySystemGroupedBackground.withAlphaComponent(0.8)
        // Apply rounded corners
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
    
    func configure(_ weather: WeatherModel) {
        koreanNameLabel.text = CityModel.cities.first { $0.id == weather.id }?.koreanName
        englishNameLabel.text = weather.cityName
        tempLabel.text = WeatherModel.generateTemp(weather.main.temp)
        humidityLabel.text = "\(weather.main.humidity)%"
    }
}
