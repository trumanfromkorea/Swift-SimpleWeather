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

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        configureDetailsInfo()
        configureCollectionView()
    }

    private func configureDetailsInfo() {
        if let weatherInfo = weatherInfo {
            detailsList.append(DetailsModel(key: "최저 기온", value: WeatherModel.generateTemp(weatherInfo.main.minTemp)))
            detailsList.append(DetailsModel(key: "최고 기온", value: WeatherModel.generateTemp(weatherInfo.main.maxTemp)))
            detailsList.append(DetailsModel(key: "체감 기온", value: WeatherModel.generateTemp(weatherInfo.main.sensibleTemp)))
            detailsList.append(DetailsModel(key: "습도", value: "\(weatherInfo.main.humidity)%"))
            detailsList.append(DetailsModel(key: "기압", value: "\(weatherInfo.main.pressure) hPa"))
            detailsList.append(DetailsModel(key: "풍속", value: "\(weatherInfo.wind.speed) m/s"))
        }
    }
}

extension DetailsViewController {
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

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }
}

class DetailsInfoHeader: UICollectionReusableView {
    static let identifier = "DetailsInfoHeader"
    @IBOutlet var koreanNameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var englishNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ koreanName: String, _ englishName: String, _ description: String, _ temp: String, _ imageID: String) {
        setImage(imageID)
        koreanNameLabel.text = koreanName
        englishNameLabel.text = englishName
        descriptionLabel.text = description
        tempLabel.text = temp
    }
    
    func setImage(_ id: String) {
        let url = Server.getImageUrl(id)
        iconImageView.setImageWithUrl(url)
    }
}
