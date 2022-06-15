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
    @IBOutlet var englishNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var imageLoadingIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

        setUIStates()
    }

    func configure(_ weather: WeatherModel) {
        setImage(weather.weather.first!.icon)
        koreanNameLabel.text = CityModel.cities.first { $0.id == weather.id }?.koreanName
        englishNameLabel.text = weather.cityName
        tempLabel.text = WeatherModel.generateTemp(weather.main.temp)
        humidityLabel.text = "\(weather.main.humidity)%"
    }

    func setImage(_ id: String) {
        let url = Server.getImageUrl(id)
        iconImageView.setImageWithUrl(url)
    }

    func setUIStates() {
        imageLoadingIndicator.hidesWhenStopped = true

        // Apply rounded corners
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 15
        layer.masksToBounds = false

        // create effect
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = contentView.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = contentView.alpha

        contentView.insertSubview(effectView, at: 0)
    }
}
