//
//  HistoryItem.swift
//  MobilniAplikace
//
//  Created by Lukáš on 16.12.2023.
//

import Foundation

class SearchHistoryItem: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var searchTerm: String
    var timestamp: Date

    init(searchTerm: String, timestamp: Date) {
        self.id = UUID().uuidString
        self.searchTerm = searchTerm
        self.timestamp = timestamp
    }

    // implementace Equatable
    static func == (lhs: SearchHistoryItem, rhs: SearchHistoryItem) -> Bool {
        return lhs.id == rhs.id
    }

    // implementace Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
