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
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var thumbnailImage: UIImageView!

    let showImageSegueIdentifier = "showImageScreen"

    var entry: RedditEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailImage.isUserInteractionEnabled = true
        thumbnailImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewData()
        viewDidLayoutSubviews()
    }
    
    func loadViewData() {
        if let entry = entry {
            authorLabel.text = entry.author
            contentTextView.text = entry.title
            if let thumbnail = entry.thumbnail {
                thumbnailImage.downloadedFrom(link: thumbnail)
            }
        }
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        if (entry?.imageUrl) != nil {
            performSegue(withIdentifier: showImageSegueIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == showImageSegueIdentifier,
            let destination = segue.destination as? ImageViewController,
            let entryImageUrl = entry?.imageUrl
        {
            destination.imageUrl = entryImageUrl
        }
    }
}
