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
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 15
        layer.masksToBounds = false
    }
}
