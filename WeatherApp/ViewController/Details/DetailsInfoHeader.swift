//
//  DetailsInfoHeader.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/15.
//

import UIKit

// Details Header
class DetailsInfoHeader: UICollectionReusableView {
    static let identifier = "DetailsInfoHeader"

    // IBOutlet
    @IBOutlet var koreanNameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var englishNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUIStyle()
    }

    // UIComponent 설정
    func configure(_ koreanName: String, _ englishName: String, _ description: String, _ temp: String, _ imageID: String) {
        setImage(imageID)
        koreanNameLabel.text = koreanName
        englishNameLabel.text = englishName
        descriptionLabel.text = description
        tempLabel.text = temp
    }

    // 이미지 설정
    func setImage(_ id: String) {
        let url = Server.getImageUrl(id)
        iconImageView.setImageWithUrl(url)
    }

    // header 모양 설정
    func configureUIStyle() {
        // 둥근 모서리
        layer.cornerRadius = 15
        layer.masksToBounds = true

        // 배경 blur
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)

        effectView.frame = bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        insertSubview(effectView, at: 0)
    }
}
