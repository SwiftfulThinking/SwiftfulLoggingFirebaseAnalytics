//
//  Untitled.swift
//  SwiftfulLoggingFirebaseAnalytics
//
//  Created by Nick Sarno on 9/26/24.
//
import Foundation

extension String {
    private func clipped(maxCharacters: Int) -> String {
        String(prefix(maxCharacters))
    }
    
    private func replaceSpacesWithUnderscores() -> String {
        self.replacingOccurrences(of: " ", with: "_")
    }
    
    func clean(maxCharacters: Int) -> String {
        self
            .clipped(maxCharacters: maxCharacters)
            .replaceSpacesWithUnderscores()
    }
}
