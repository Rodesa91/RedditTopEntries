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
    let detailSegueIdentifier = "goToEntryDetail"
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MainViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.orange
        
        return refreshControl
    }()

    var topEntries:[RedditEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.entriesTableView.addSubview(self.refreshControl)
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
    
    @IBAction func dissmissAllPressed(_ sender: Any) {
        self.topEntries = []
        entriesTableView.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.getData(lastID: nil)
        self.entriesTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == detailSegueIdentifier,
            let destination = segue.destination as? EntryDetailViewController,
            let entryIndex = entriesTableView.indexPathForSelectedRow?.row
        {
            destination.entry = topEntries[entryIndex]
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
        
        if (indexPath.row+1 == self.topEntries.count) {
            self.getData(lastID: self.topEntries[indexPath.row].name)
            self.entriesTableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
