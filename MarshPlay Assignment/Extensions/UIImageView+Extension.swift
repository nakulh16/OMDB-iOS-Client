//
//  UIImageView + Extension.swift
//  Celebrity Finder
//
//  Created by Nakul Hindustani on 11/03/19.
//  Copyright © 2019 Nakul Hindustani. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
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
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        let imageCashe = NSCache<AnyObject, AnyObject>()
        if let imageCashe = imageCashe.object(forKey: link as AnyObject) as? UIImage {
            self.image = imageCashe
        }
        downloaded(from: url, contentMode: mode)
    }

}
