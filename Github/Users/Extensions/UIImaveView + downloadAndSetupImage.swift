//
//  UIImaveView + downloadAndSetupImage.swift
//  Github
//
//  Created by Артём Зайцев on 18.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadAndSetupImage(with url: URL?, completion: ((_ ok: Bool) -> Void)?) {
        guard let url = url else { return }
        
        // Setup activity indicator loading, while downloading an image
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    if let completion = completion { completion(false) }
                    return
            }
            DispatchQueue.main.async() {
                // remove activity indicator
//                activityIndicator.removeFromSuperview()
                
                self.image = image
                if let completion = completion { completion(true) }
            }
            }.resume()
    }
}
