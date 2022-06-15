//
//  DetailsInfoCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/15.
//

import UIKit

class DetailsInfoCell: UICollectionViewCell {
    static let identifier = "DetailsInfoCell"

    // IBOutlet
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var detailsIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureUIStyle()
    }

    // UIComponent 설정
    func configure(_ details: DetailsModel) {
        keyLabel.text = details.key
        valueLabel.text = details.value
        detailsIcon.image = UIImage(systemName: details.imageName)
    }

    // cell 모양 설정
    func configureUIStyle() {
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
