//
//  EpisodesViewController.swift
//  moviestar
//
//  Created by Douglas Taquary on 09/07/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import TraktKit

class EpisodesViewController: UIViewController {
    
    let cellIdentifier = "BasicCell"
    
    let traktManager = TraktManager.sharedManager
    
    var show: TraktShow!
    
    var episodes: [TraktEpisode] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        showEpisodes()
    }

}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EpisodeViewCell
        
        let episode = episodes[indexPath.row]
        
        cell.setup(with: episode)
        
        return cell
    }
}

extension EpisodesViewController {
    
    func showEpisodes() {
    
        traktManager.getEpisodesForSeason(showID: show.ids.trakt, season: 1 as NSNumber, extended: [ExtendedType.Episodes]) { (result) in
        
            switch result {
            case .success(let result):
                
                self.episodes = result
                self.tableView.reloadData()
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

