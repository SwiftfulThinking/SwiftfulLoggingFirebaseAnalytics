//
//  Dictionary+EXT.swift
//  SwiftfulLoggingFirebaseAnalytics
//
//  Created by Nick Sarno on 9/26/24.
//
import Foundation

extension Dictionary where Key == String {

    mutating func clippingKeys(maxCharacters: Int) {
        for (key, value) in self where key.count > maxCharacters {
            updateValue(value, forKey: key.clipped(maxCharacters: maxCharacters))
            removeValue(forKey: key)
        }
    }

    mutating func limitToFirst(maxItems: Int) {
        var counter: Int = 0
        for (key, _) in self {
            if counter <= maxItems {
                removeValue(forKey: key)
                counter += 1
            } else {
                return
            }
        }
    }
}
