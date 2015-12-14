//
//  Playlist.swift
//  Soma
//
//  Created by Blaine Fahey on 11/23/15.
//  Copyright © 2015 Blaine Fahey. All rights reserved.
//

import Foundation
import Mapper

// MARK: Playlist

public struct Playlist {
    public let id: String
    public let songs: [Song]
}

extension Playlist: Mappable, Equatable {
    public init(map: Mapper) throws {
        try id = map.from("id")
        try songs = map.from("songs")
    }
}

public func ==(lhs: Playlist, rhs: Playlist) -> Bool {
    return lhs.id == rhs.id
}

// MARK: Song

public struct Song {
    public let title: String
    public let artist: String
    public let album: String
    public let date: NSDate
}

extension Song: Mappable, Equatable {
    public init(map: Mapper) throws {
        try title  = map.from("title")
        try artist = map.from("artist")
        try album  = map.from("album")
        try date   = map.from("date")
    }
}

public func ==(lhs: Song, rhs: Song) -> Bool {
    return lhs.title == rhs.title && lhs.artist == lhs.artist && lhs.album == rhs.album
}
