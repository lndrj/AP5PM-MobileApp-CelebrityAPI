//
//  HistoryView.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @EnvironmentObject var searchHistoryManager: SearchHistoryManager
    @State private var selectedHistoryItem: SearchHistoryItem?
    @State private var isDeleteConfirmationVisible = false

    var body: some View {
        NavigationView {

                List {
                    ForEach(searchHistoryManager.searchHistory, id: \.self) { historyItem in
                        Button(action: {
                            selectedHistoryItem = historyItem
                        }) {
                            HStack {
                                Text(historyItem.searchTerm)
                                Spacer()
                                Text("\(historyItem.timestamp, formatter: dateFormatter)")
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        selectedHistoryItem = nil
                        isDeleteConfirmationVisible = true
                    })
                }
                .navigationBarTitle("Historie vyhledávání")
                .actionSheet(isPresented: $isDeleteConfirmationVisible) {
                    ActionSheet(
                        title: Text("Opravdu chcete smazat celou historii?"),
                        buttons: [
                            .destructive(Text("Smazat"), action: {
                                searchHistoryManager.clearHistory()
                            }),
                            .cancel()
                        ]
                    )
                }
                .sheet(item: $selectedHistoryItem) { historyItem in
                    PersonInfoView(celebrityName: historyItem.searchTerm, loadedPerson: nil)
                }

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isDeleteConfirmationVisible = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.blue) // Barva ikony koše
                        }
                    }
                }
            }
        }
    

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
