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
    var detailsList = [DetailsModel]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    typealias Item = DetailsModel
    enum Section {
        case main
    }

    // IBOutlet
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackground()
        configureDetailsInfo()
        configureCollectionView()
    }
    
    // Background 이미지 설정
    private func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_default")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.75

        view.insertSubview(backgroundImage, at: 0)
    }
}

// MARK: - CollectionView 관련 설정들

extension DetailsViewController {
    // Details ColletionView 에 들어갈 데이터 삽입
    private func configureDetailsInfo() {
        if let weatherInfo = weatherInfo {
            detailsList.append(DetailsModel(key: "최저 기온", value: WeatherModel.generateTemp(weatherInfo.main.minTemp), imageName: "thermometer.sun.fill"))
            detailsList.append(DetailsModel(key: "최고 기온", value: WeatherModel.generateTemp(weatherInfo.main.maxTemp), imageName: "thermometer.snowflake"))
            detailsList.append(DetailsModel(key: "체감 기온", value: WeatherModel.generateTemp(weatherInfo.main.sensibleTemp), imageName: "thermometer"))
            detailsList.append(DetailsModel(key: "습도", value: "\(weatherInfo.main.humidity)%", imageName: "humidity.fill"))
            detailsList.append(DetailsModel(key: "기압", value: "\(weatherInfo.main.pressure) hPa", imageName: "circle.dashed.inset.filled"))
            detailsList.append(DetailsModel(key: "풍속", value: "\(weatherInfo.wind.speed) m/s", imageName: "wind"))
        }
    }

    // CollectionView 설정
    private func configureCollectionView() {
        // ui
        collectionView.showsVerticalScrollIndicator = false

        // dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsInfoCell.identifier, for: indexPath) as? DetailsInfoCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })

        // header
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailsInfoHeader.identifier, for: indexPath) as? DetailsInfoHeader else {
                    return UICollectionReusableView()
                }

                header.configure(
                    CityModel.cities.first { $0.id == self.weatherInfo!.id }!.koreanName,
                    self.weatherInfo!.cityName,
                    self.weatherInfo!.weather.first!.description,
                    WeatherModel.generateTemp(self.weatherInfo!.main.temp),
                    self.weatherInfo!.weather.first!.icon
                )

                return header
            } else {
                return UICollectionReusableView()
            }
        }

        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(detailsList, toSection: .main)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = configureLayout()
    }

    // CollectionView Layout
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)

        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }
}
