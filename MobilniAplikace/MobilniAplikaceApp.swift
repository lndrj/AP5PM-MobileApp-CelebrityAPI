//
//  MobilniAplikaceApp.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI

@main
struct MobilniAplikaceApp: App {
    @StateObject private var searchHistoryManager = PersistenceManager.shared
    @State private var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if isActive
                    {
                    ContentView()
                        .environmentObject(searchHistoryManager)
                    }
                else {
                    SplashScreenView(isActive: isActive)
                }
            }
        }
    }
}
