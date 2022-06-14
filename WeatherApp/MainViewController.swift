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

    let cityList = Location.cityList
    var weatherInfoList = [WeatherInfo]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackground()
        requestWeatherForCities()
    }

    private func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_default")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}

// MARK: - 날씨 api 관련

extension MainViewController {
    func requestWeatherForCities() {
        for city in cityList {
            let url = Server.getUrlWithCity(city)

            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _, error in
                guard let data = data, error == nil
                else {
                    print("something went wrong")
                    return
                }

                var responseData: WeatherInfo?

                do {
                    responseData = try JSONDecoder().decode(WeatherInfo.self, from: data)
                } catch {
                    print("error \(error)")
                }

                guard let result = responseData else { return }

                self.weatherInfoList.append(result)

            }).resume()
        }
    }
}
