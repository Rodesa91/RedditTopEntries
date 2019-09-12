//
//  Entry.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import Foundation

struct Entry:Codable {
    let title: String
    let name: String
    let author: String
    let thumbnail: String?
    let created: Double
    let imageUrl: String?
    let comments: Int
    
    enum CodingKeys : String, CodingKey {
        case title
        case name
        case author
        case thumbnail
        case created = "created_utc"
        case imageUrl = "url"
        case comments = "num_comments"
    }
}

struct ListingResponse:Codable {
    let data : ListingData
}

struct ListingData:Codable {
    let children : [ChildrenData]
}

struct ChildrenData:Codable {
    let data : Entry
}
