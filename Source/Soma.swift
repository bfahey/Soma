//
//  Soma.swift
//  Soma
//
//  Created by Blaine Fahey on 11/23/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import Foundation

public let SomaBaseURL = "http://www.somafm.com"

typealias JSONDictionary = [String: AnyObject]

public func requestChannels(completion: ([Channel]?, NSError?) -> Void) -> NSURLSessionDataTask {
    let url = NSURL(string: "\(SomaBaseURL)/channels.json")!
    let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        do {
            let json = try decodeJSON(data!)
            let array = json["channels"] as! [JSONDictionary]
            let channels = array.flatMap { Channel.from($0) }

            dispatch_async(dispatch_get_main_queue()) {
                completion(channels, nil)
            }
            
        } catch let error as NSError {
            dispatch_async(dispatch_get_main_queue()) {
                completion(nil, error)
            }
        }
    })
    task.resume()
    return task
}

public func requestPlaylist(withID id:String, completion: (Playlist?, NSError?) -> Void) -> NSURLSessionDataTask {
    let url = NSURL(string: "\(SomaBaseURL)/songs/\(id).json")!
    let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        do {
            let json = try decodeJSON(data!)
            let playlist = Playlist.from(json)
            
            dispatch_async(dispatch_get_main_queue()) {
                completion(playlist, error)
            }
            
        } catch let error as NSError {
            dispatch_async(dispatch_get_main_queue()) {
                completion(nil, error)
            }
        }
    })
    task.resume()
    return task
}

func decodeJSON(data: NSData) throws -> JSONDictionary {
    guard let dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary else {
        throw NSError(
            domain: NSURLErrorDomain,
            code: NSURLErrorCannotParseResponse,
            userInfo: [NSLocalizedDescriptionKey: "Data is not a dictionary."])
    }
    return dict
}
