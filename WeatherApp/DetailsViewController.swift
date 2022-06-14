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
    
    let sampleList = [1,2,3,4,5,6]
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        
        navigationItem.largeTitleDisplayMode = .never
        configureCollectionView()
        configureOutlets()
    }

    private func configureOutlets() {
        if let weatherInfo = weatherInfo {
            koreanNameLabel.text = CityModel.cities.first { $0.id == weatherInfo.id }?.koreanName
            englishNameLabel.text = weatherInfo.cityName
            descriptionLabel.text = weatherInfo.weather.first!.description

            minTempLabel.text = WeatherModel.generateTemp(weatherInfo.main.minTemp)
            maxTempLabel.text = WeatherModel.generateTemp(weatherInfo.main.maxTemp)

            tempLabel.text = WeatherModel.generateTemp(weatherInfo.main.temp)
            sensibleTempLabel.text = WeatherModel.generateTemp(weatherInfo.main.sensibleTemp)
            humidityLabel.text = "\(weatherInfo.main.humidity)%"
            pressureLabel.text = "\(weatherInfo.main.pressure)hPa"
            windLabel.text = "\(weatherInfo.wind.speed)m/s"
        }
    }
}

extension DetailsViewController {
    typealias Item = Int
    enum Section {
        case main
    }

    private func configureCollectionView() {

        // ui
//        collectionView.backgroundColor = .white.withAlphaComponent(0.7)
//        collectionView.layer.cornerRadius = 15
        collectionView.showsVerticalScrollIndicator = false

        // dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsInfoCell.identifier, for: indexPath) as? DetailsInfoCell else {
                return nil
            }

            return cell
        })

        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(sampleList, toSection: .main)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = configureLayout()
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
