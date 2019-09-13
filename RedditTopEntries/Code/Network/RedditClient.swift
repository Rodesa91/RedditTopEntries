//
//  RedditClient.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit

enum APIRoute {
    static let topListingUrl = "https://www.reddit.com/top.json?limit=10"
}

class RedditClient {
    
    static let sharedClient = RedditClient()
    
    func getTopEntries (after:String?, onCompletion :@escaping (_ response: [RedditEntry]?, _ error: Error?) -> Void)  {
        
        var urlAddress:String = APIRoute.topListingUrl
        
        if let afterID = after {
            urlAddress.append("&after="+afterID)
        }
        
        guard let url = URL(string: urlAddress) else { return }
        
        var topEntries:[RedditEntry] = []
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(ListingResponse.self, from: data)
                
                for child in response.data.children {
                    topEntries.append(child.data)
                }
                
                onCompletion(topEntries, nil)
                
            } catch let jsonError {
                onCompletion([], jsonError)
                print(jsonError)
            }
            }.resume()
    }
}
