//
//  ContentView.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @State private var selected: Tabs = .house
    @State private var searched: String = ""
    
    @StateObject private var searchHistoryManager = SearchHistoryManager()

    
    var body: some View {
        ZStack {
             VStack {
                 TabView(selection: $selected) {
                     ForEach(Tabs.allCases, id: \.rawValue) { tab in
                         getContent(for: tab)
                             .tag(tab)
                     }
                 }
            }
             VStack {
                 Spacer()
                 ToolBar(selected: $selected)
             }
         }
         .environmentObject(searchHistoryManager)
     }
        
    
    private func getContent(for tab: Tabs) -> some View {
        switch tab {
        case .house:
            return AnyView(HomeView())
        case .clock:
            return AnyView(HistoryView())
            
        case .magnifyingglass:
            return AnyView(SearchView(searched: $searched))
        }
    }
}


#Preview {
    ContentView()
}
