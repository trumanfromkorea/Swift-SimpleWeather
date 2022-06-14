//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

class DetailsViewController: UIViewController {
    static let identifier = "DetailsViewController"
    static let storyboard = "Main"

    var weatherInfo: WeatherModel?

    @IBOutlet var koreanNameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var englishNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!

    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var sensibleTempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOutlets()
    }

    private func configureOutlets() {
        
        if let weatherInfo = weatherInfo {
            koreanNameLabel.text = CityModel.cities.first { $0.id == weatherInfo.id }?.koreanName
            englishNameLabel.text = weatherInfo.cityName
            descriptionLabel.text = weatherInfo.weather.first!.description
            
            minTempLabel.text = "\(weatherInfo.main.minTemp)°C"
            maxTempLabel.text = "\(weatherInfo.main.maxTemp)°C"
            
            tempLabel.text = "\(weatherInfo.main.temp)°C"
            sensibleTempLabel.text = "\(weatherInfo.main.sensibleTemp)°C"
            humidityLabel.text = "\(weatherInfo.main.humidity)%"
            pressureLabel.text = "\(weatherInfo.main.pressure)hPa"
            windLabel.text = "\(weatherInfo.wind.speed)m/s"
        }
        
        
    }
}
