//
//  Taggable.swift
//  Pods
//
//  Created by Dan Isacson on 2017-03-21.
//
//

import Foundation

public protocol Taggable {
    var tags: Set<String> { get set }
}
