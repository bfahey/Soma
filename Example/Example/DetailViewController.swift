//
//  DetailViewController.swift
//  Example
//
//  Created by Blaine Fahey on 12/14/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit
import Soma

class DetailViewController: UITableViewController {
    var channel: Channel?
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.channel?.title
        
        guard let channelID = self.channel?.id else { return }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        Soma.requestPlaylist(channelID: channelID) { (playlist, error) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            if (playlist != nil) {
                self.playlist = playlist
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                });
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if let song = playlist?.songs[indexPath.row] {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = "\(song.artist) - \(song.album)"
        }
        
        return cell
    }
    

}
