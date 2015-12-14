//
//  Channel.swift
//  Soma
//
//  Created by Blaine Fahey on 11/23/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import Foundation
import Mapper

//    "id": "groovesalad",
//    "title": "Groove Salad",
//    "description": "A nicely chilled plate of ambient/downtempo beats and grooves.",
//    "dj": "Rusty Hodge",
//    "djmail": "rusty@somafm.com",
//    "genre": "ambient|electronica",
//    "image": "http://api.somafm.com/img/groovesalad120.png",
//    "largeimage": "http://api.somafm.com/logos/256/groovesalad256.png",
//    "xlimage": "http://api.somafm.com/logos/512/groovesalad512.png",
//    "twitter": "groovesalad",
//    "updated": "1382565808",
//    "playlists": [
//    { "url": "http://somafm.com/groovesalad130.pls", "format": "aac",  "quality": "highest" },
//    { "url": "http://somafm.com/groovesalad.pls", "format": "mp3",  "quality": "high" },
//    { "url": "http://somafm.com/groovesalad64.pls", "format": "aacp",  "quality": "high" },
//    { "url": "http://somafm.com/groovesalad56.pls", "format": "mp3",  "quality": "low" },
//    { "url": "http://somafm.com/groovesalad32.pls", "format": "aacp",  "quality": "low" }
//    ],
//    "listeners": "1863",
//    "lastPlaying": "Sweetback - Sensations"

// MARK: Channel

public struct Channel {
    public let id: String
    public let title: String
    public let description: String
    public let dj: String?
    public let djMail: String?
    public let genre: String?
    public let imageURL120: NSURL?
    public let imageURL256: NSURL?
    public let imageURL512: NSURL?
    public let twitter: String?
    public let updated: NSDate?
    public let playlists: [PlaylistURL]
    public let listeners: Int?
    public let lastPlaying: String?
}

extension Channel: Mappable, Equatable {
    public init(map: Mapper) throws {
        try id          = map.from("id")
        try title       = map.from("title")
        try description = map.from("description")
        dj              = map.optionalFrom("dj")
        djMail          = map.optionalFrom("djmail")
        genre           = map.optionalFrom("genre")
        imageURL120     = map.optionalFrom("image")
        imageURL256     = map.optionalFrom("largeimage")
        imageURL512     = map.optionalFrom("xlimage")
        twitter         = map.optionalFrom("twitter")
        updated         = map.optionalFrom("updated")
        try playlists   = map.from("playlists")
        listeners       = map.optionalFrom("listeners")
        lastPlaying     = map.optionalFrom("lasyPlaying")
    }
}

public func ==(lhs: Channel, rhs: Channel) -> Bool {
    return lhs.id == rhs.id
}

// MARK: PlaylistURL

public struct PlaylistURL {
    public enum Format: String {
        case AAC  = "aac"
        case AACP = "aacp"
        case MP3  = "mp3"
    }
    
    public enum Quality: String {
        case Highest = "highest"
        case High    = "high"
        case Low     = "low"
    }
    
    public let url: NSURL
    public let format: Format
    public let quality: Quality
}

extension PlaylistURL: Mappable, Equatable {
    public init(map: Mapper) throws {
        try url     = map.from("url")
        try format  = map.from("format")
        try quality = map.from("quality")
    }
}

public func ==(lhs: PlaylistURL, rhs: PlaylistURL) -> Bool {
    return lhs.url == rhs.url
}
