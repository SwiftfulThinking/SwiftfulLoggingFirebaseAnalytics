//
//  Untitled.swift
//  SwiftfulLoggingFirebaseAnalytics
//
//  Created by Nick Sarno on 9/26/24.
//
import Foundation

extension String {
    func clipped(maxCharacters: Int) -> String {
        String(prefix(maxCharacters))
    }
    
    func replaceSpacesWithUnderscores() -> String {
        self.replacingOccurrences(of: " ", with: "_")
    }
    
    func clean(maxCharacters: Int) -> String {
        self
            .clipped(maxCharacters: 40)
            .replaceSpacesWithUnderscores()
    }
}
