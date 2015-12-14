//
//  NSDate+Convertible.swift
//  Soma
//
//  Created by Blaine Fahey on 12/13/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import Foundation
import Mapper

/**
 NSDate Convertible implementation
 This implementation assumes the given value is a string which can be used to create a NSDate
 if not a `MapperError` is thrown
 */
extension NSDate: Convertible {
    public static func fromMap(value: AnyObject?) throws -> NSDate {
        if let dateString = value as? String, let interval = Double(dateString) {
            return NSDate(timeIntervalSince1970: interval)
        }
        
        throw MapperError()
    }
}