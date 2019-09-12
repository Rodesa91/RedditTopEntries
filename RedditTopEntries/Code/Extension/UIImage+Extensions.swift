//
//  UIImage+Extensions.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: .scaleAspectFit)
    }
}
