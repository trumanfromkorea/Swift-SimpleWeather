//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

// Main 화면 CollectionView Cell
class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"

    // IBOutlet
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
    
    // UIComponent 설정
    func configure(_ weather: WeatherModel) {
        setImage(weather.weather.first!.icon)
        
        koreanNameLabel.text = CityModel.cities.first { $0.id == weather.id }?.koreanName
        englishNameLabel.text = weather.cityName
        tempLabel.text = WeatherModel.generateTemp(weather.main.temp)
        humidityLabel.text = "\(weather.main.humidity)%"
    }
    
    // 이미지 설정
    func setImage(_ id: String) {
        let url = Server.getImageUrl(id)
        iconImageView.setImageWithUrl(url)
    }
    
    // UI 설정
    func setUIStates() {
        // 이미지 로딩 후 indicator 멈추기
        imageLoadingIndicator.hidesWhenStopped = true

        // 둥근 모서리
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        // 배경 blur
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)

        effectView.frame = contentView.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = contentView.alpha

        contentView.insertSubview(effectView, at: 0)
    }
}
