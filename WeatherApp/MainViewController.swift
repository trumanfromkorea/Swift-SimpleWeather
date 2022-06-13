//
//  MainViewController.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/14.
//

import UIKit

class MainViewController: UIViewController {
    static let identifier = "MainViewController"
    static let storyboard = "Main"

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackground()
    }
    
    private func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_default")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
