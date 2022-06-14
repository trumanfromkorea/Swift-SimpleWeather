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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(weatherInfo)
    }
    
}
