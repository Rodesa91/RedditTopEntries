//
//  EntryDetailViewController.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/12/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var entry: RedditEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewData()
        viewDidLayoutSubviews()
    }
    
    func loadViewData() {
        if let entry = entry {
            authorLabel.text = entry.author
            descriptionLabel.text = entry.title
            if let thumbnail = entry.thumbnail {
                thumbnailImage.downloadedFrom(link: thumbnail)
            }
        }
    }
    
}
