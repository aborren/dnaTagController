//
//  TaggableTestObject.swift
//  dnaTagController
//
//  Created by Dan Isacson on 2017-03-21.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import dnaTagController

public struct TaggableTestObject: Taggable, Hashable {
    public var id: String
    public var tags: Set<String>
    
    public var hashValue: Int { return id.hashValue }
    
    public static func ==(lhs: TaggableTestObject, rhs: TaggableTestObject) -> Bool {
        return lhs.id == rhs.id
    }
}
