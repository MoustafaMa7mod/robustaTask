//
//  UIImageView+Cashing.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import UIKit
   fileprivate let imageCache =  NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func downloadImage(url: NSURL? , contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        self.image = UIImage(named: "avatar")
        guard let url = url else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in

                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Image loading error")
                    return
                }
                
                DispatchQueue.main.async{
                    if let downloadedImage = UIImage(data: data) {
                        imageCache.setObject(downloadedImage, forKey: url)
                        self.image = downloadedImage
                    }
                }
            }).resume()
        }
    }
}
