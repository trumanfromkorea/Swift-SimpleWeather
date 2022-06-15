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

    typealias Item = WeatherModel
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    let cities = CityModel.cities
    var weatherList = [WeatherModel]()

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.title = "전국 날씨"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.sizeToFit()

        configureBackground()

        requestWeatherForCities()

        configureCollectionView()
    }

    private func configureBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_default")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.75
        
        // create effect
        let effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = backgroundImage.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = backgroundImage.alpha
        
        backgroundImage.addSubview(effectView)
        
        view.insertSubview(backgroundImage, at: 0)
    }

    private func configureCollectionView() {
        // delegate
        collectionView.delegate = self

        // ui
        collectionView.showsVerticalScrollIndicator = false

        // dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell else {
                return nil
            }

            cell.configure(itemIdentifier)

            return cell
        })
        
        // header
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeatherHeader.identifier, for: indexPath) as? WeatherHeader else {
                    return UICollectionReusableView()
                }
                
                return header
            } else {
                return UICollectionReusableView()
            }
        }

        // snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(weatherList, toSection: .main)
        dataSource.apply(snapshot)

        // layout
        collectionView.collectionViewLayout = configureLayout()
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

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

// MARK: - 날씨 api 관련

extension MainViewController {
    func requestWeatherForCities() {
        let url = Server.getUrlWithCities(cities)
        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, _, error in
            guard let data = data, error == nil
            else {
                print("something went wrong")
                return
            }

            var responseData: WeatherResponse?

            do {
                responseData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            } catch {
                print("error \(error)")
            }

            guard let result = responseData else { return }

            result.list.forEach { item in
                self.weatherList.append(item)
            }

            semaphore.signal()

        }).resume()

        semaphore.wait()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: DetailsViewController.storyboard, bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        vc.title = "지역 날씨"
        
        vc.weatherInfo = weatherList[indexPath.item]

        navigationController?.pushViewController(vc, animated: true)
    }
}
