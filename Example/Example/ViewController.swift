//
//  ViewController.swift
//  Example
//
//  Created by Blaine Fahey on 11/24/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit

import Soma

class ViewController: UITableViewController {
    var channels: [Channel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 60.0
        
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
    
//    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 60
//    }
//    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let channel = channels[indexPath.row]
        cell.textLabel?.text = channel.title
        cell.detailTextLabel?.text = channel.description
        cell.imageView?.imageFromURL(channel.imageURL120!)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow, let detail = segue.destinationViewController as? DetailViewController {
            let channel = channels[indexPath.row]
            detail.channel = channel
        }
    }

}

