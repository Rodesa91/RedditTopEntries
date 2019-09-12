//
//  MainViewController.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var entriesTableView: UITableView!

    var topEntries:[Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData(lastID: nil)
    }
    
    func getData(lastID:String?){
        RedditClient.sharedClient.getTopEntries (after: lastID){ (result, error) in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async {
                if let entries = result {
                    self.topEntries.append(contentsOf: entries)
                    self.entriesTableView.reloadData()
                }
            }
        }
    }
}



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell") as! EntryTableViewCell
        cell.configureCellWithEntry(entry:self.topEntries[indexPath.row])
        return cell
    }
    
    
}
