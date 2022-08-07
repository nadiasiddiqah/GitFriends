//
//  GFAvatarIV.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/5/22.
//

import UIKit

class GFAvatarIV: UIImageView {
    
    // access image cache
    let cache = NetworkManager.shared.cache
    
    // You can force unwrap if in your assets (not if you're downloading from internet)
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        // Change UIImageView's cornerRadius instead of the UIImage's cornerRadius
        layer.cornerRadius = 10
        clipsToBounds = true
        // Placeholder image
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        // Check if you have the image in the cache
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        // If cache doesn't contain, download image
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            // Add image to cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}
