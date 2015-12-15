//
//  ViewController.swift
//  Example
//
//  Created by Blaine Fahey on 11/24/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit

import Soma

class ChannelTableViewCell: UITableViewCell {
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class ViewController: UITableViewController {
    var channels: [Channel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Soma.requestChannels { (channels, error) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if let channels = channels {
                self.channels = channels

                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                });
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ChannelTableViewCell
        
        let channel = channels[indexPath.row]
        cell.titleLabel?.text = channel.title
        cell.descriptionLabel?.text = channel.description

        if let imageURL = channel.imageURL120 {
            cell.channelImageView?.imageFromURL(imageURL)
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow, let detail = segue.destinationViewController as? DetailViewController {
            let channel = channels[indexPath.row]
            detail.channel = channel
        }
    }

}

