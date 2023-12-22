//
//  HistoryManager.swift
//  MobilniAplikace
//
//  Created by Lukáš on 16.12.2023.
//

import SwiftUI

class SearchHistoryManager: ObservableObject {
    @Published var searchHistory: [SearchHistoryItem] = []

    init() {
        loadSearchHistory()
    }

    func addToHistory(searchTerm: String) {
        let historyItem = SearchHistoryItem(searchTerm: searchTerm, timestamp: Date())
        searchHistory.insert(historyItem, at: 0)
        PersistenceManager.shared.saveHistoryItem(historyItem)
    }

    func deleteFromHistory(indexSet: IndexSet) {
        for index in indexSet {
            let historyItem = searchHistory[index]
            searchHistory.remove(at: index)
            PersistenceManager.shared.deleteHistoryItem(historyItem)
        }
    }

    func clearHistory() {
        searchHistory = []
        PersistenceManager.shared.clearSearchHistory()
    }

    private func loadSearchHistory() {
        searchHistory = PersistenceManager.shared.searchHistory
    }
}
