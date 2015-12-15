//
//  DetailViewController.swift
//  Example
//
//  Created by Blaine Fahey on 12/14/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit
import Soma
import AVFoundation

class DetailViewController: UITableViewController {
    var channel: Channel?
    var playlist: Playlist?
    var player: AVPlayer?
    var currentPlaylistURL: PlaylistURL? {
        didSet {
            updatePlayButton()
        }
    }
    var isPlaying = false
    
    func toggleRadio() {
        guard let url = currentPlaylistURL?.url else { return }

        if isPlaying == false {
            RadioPlayer.sharedInstance.play(url)
            isPlaying = true
        } else {
            RadioPlayer.sharedInstance.pause()
            isPlaying = false
        }
        
        updatePlayButton()
    }
    
    func updatePlayButton() {
        let style: UIBarButtonSystemItem = isPlaying ? .Pause : .Play
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: style, target: self, action: "toggleRadio")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.channel?.title
        
        guard let channel = self.channel else { return }
        
        // Get the `high` quality playlist URL.
        let mid = channel.playlists.count / 2
        self.currentPlaylistURL = channel.playlists[mid]
            
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        Soma.requestPlaylist(channelID: channel.id) { (playlist, error) in
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
