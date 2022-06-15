//
//  ImageModel.swift
//  WeatherApp
//
//  Created by 장재훈 on 2022/06/15.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

extension UIImageView {
    func setImageWithUrl(_ url: String) {
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값

        // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            image = cachedImage
            return
        }

        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                    if let _ = error {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }

                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            // 이미지 캐싱
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        }
                    }

                }.resume()
            }
        }
    }
}
