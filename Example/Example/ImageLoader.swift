//
//  ImageLoader.swift
//  Example
//
//  Created by Blaine Fahey on 12/14/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import UIKit

struct ImageLoader {
    static let cache: NSCache = NSCache()
    
    static func loadImage(withURL url: NSURL, completionHandler: (UIImage?, NSHTTPURLResponse?, NSError?) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            if let foundData = self.cache.objectForKey(url.absoluteString) as? NSData {
                let image = UIImage(data: foundData)

                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(image, nil, nil)
                    return
                });
            }

            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                let image = UIImage(data: data!)
                
                if let data = data {
                    self.cache.setObject(data, forKey: url.absoluteString)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(image, response as? NSHTTPURLResponse, error)
                });
            })
            
            task.resume()
        })
    }
}

extension UIImageView {
    func imageFromURL(url: NSURL) {
        ImageLoader.loadImage(withURL: url) { (image, response, error) in
            if let image = image {
                dispatch_async(dispatch_get_main_queue(), {
                    self.image = image
                });
            }
        }
    }
}
