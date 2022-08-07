//
//  NetworkManager.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 8/4/22.
//

import UIKit

class NetworkManager {
    // static = every NetworkManager will have shared
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    
    // create image cache
    let cache = NSCache<NSString, UIImage>()
    
    // private init = restricts so you can only have one instance of it
    private init() { }
    
    // Completion returns [Followers]? or String? (for error)
    func getFollowers(for username: String, page: Int,
                      completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }

        }
        task.resume()
    }
}
