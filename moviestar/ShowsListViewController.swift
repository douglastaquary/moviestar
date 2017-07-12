//
//  ShowsListViewController.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import TraktKit

class ShowsListViewController: UIViewController {
    
    let cellIdentifier = "BasicCell"
    
    let traktManager = TraktManager.sharedManager
    
    var shows: [TraktShow] = []
    
    var show: TraktShow!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        showsRequest()
    }
}

extension ShowsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowListViewCell
        
        show = shows[indexPath.row]
        
        cell.setup(with: show)
        
        return cell
    }
    
}

extension ShowsListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEpisodes" {
            
            let episodesDetails = segue.destination as! EpisodesViewController
            episodesDetails.show = show
            
        }
    }

    func showsRequest() {
    
        traktManager.getPopularShows(page: 1, limit: 20, extended: [.Full]) { [weak self] (result) in
        
            switch result {
            case .success(let result):
                
                self?.shows = result
                self?.tableView.reloadData()
                 UIApplication.shared.isNetworkActivityIndicatorVisible = false
                break
            case .error(let error):
                
                 UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                print("\(String(describing: error!))")
                break
            }
        }
        
        
    }

}
