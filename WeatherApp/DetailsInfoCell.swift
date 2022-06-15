//
//  DetailsInfoCell.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/15.
//

import UIKit

class DetailsInfoCell: UICollectionViewCell {
    @IBOutlet var keyLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet weak var detailsIcon: UIImageView!
    
    static let identifier = "DetailsInfoCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        // Apply rounded corners
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = 15
        layer.masksToBounds = false
    }

    func configure(_ details: DetailsModel) {
        keyLabel.text = details.key
        valueLabel.text = details.value
        detailsIcon.image = UIImage(systemName: details.imageName)
    }
}
