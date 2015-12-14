//
//  ViewController.swift
//  Example
//
//  Created by Blaine Fahey on 11/24/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit

import Soma

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var channels: [Channel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.estimatedRowHeight = 60
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Soma.requestChannels { (channels, error) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if let c = channels {
                self.channels = c
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let channel = channels[indexPath.row]
        cell.textLabel?.text = channel.title
        cell.detailTextLabel?.text = channel.description
        
        return cell
    }

}

