//
//  PersistenceManager.swift
//  MobilniAplikace
//
//  Created by Lukáš on 16.12.2023.
//

import Foundation

class PersistenceManager: ObservableObject {
    static let shared = PersistenceManager()

    @Published var searchHistory: [SearchHistoryItem] = [] {
        didSet {
            saveSearchHistory()
        }
    }

    private init() {
        loadSearchHistory()
    }

    func saveHistoryItem(_ item: SearchHistoryItem) {
        searchHistory.insert(item, at: 0)
    }

    func deleteHistoryItem(_ item: SearchHistoryItem) {
        if let index = searchHistory.firstIndex(of: item) {
            searchHistory.remove(at: index)
        }
    }

    private func saveSearchHistory() {
        if let encodedHistory = try? JSONEncoder().encode(searchHistory) {
            UserDefaults.standard.set(encodedHistory, forKey: "SearchHistory")
        }
    }

    private func loadSearchHistory() {
        if let encodedHistory = UserDefaults.standard.data(forKey: "SearchHistory"),
           let history = try? JSONDecoder().decode([SearchHistoryItem].self, from: encodedHistory) {
            searchHistory = history
        }
    }
    
    func clearSearchHistory() {
            searchHistory = []  // Vyprázdní seznam historie
            UserDefaults.standard.removeObject(forKey: "SearchHistory")  // Smazání z UserDefaults
        }
}
