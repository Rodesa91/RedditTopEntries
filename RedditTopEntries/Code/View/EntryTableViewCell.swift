//
//  EntryTableViewCell.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var entryImage: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.1)
        selectedBackgroundView = backgroundView
    }
    
    
    func configureCellWithEntry(entry: RedditEntry) {
        self.authorLabel.text = entry.author
        self.descriptionLabel.text = entry.title
        let currentDate:Date = Date()
        let date = Date(timeIntervalSince1970: TimeInterval(entry.created))
        if let thumbnail = entry.thumbnail {
            self.entryImage.isHidden = false
            self.entryImage.downloadedFrom(link: thumbnail)
            self.entryImage.isUserInteractionEnabled = true
            
        } else {
            self.entryImage.isHidden = true
        }
        
        
        self.commentsCountLabel.text = entry.comments.description + " comments"
        self.timeLabel.text = currentDate.dateTimeAgo(sinceDate: date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        if selected {
            self.backgroundColor = .darkGray
        } else {
            self.backgroundColor = .black
        }
    }

}
