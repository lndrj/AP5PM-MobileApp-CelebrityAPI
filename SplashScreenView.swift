//
//  SplashScreen.swift
//  MobilniAplikace
//
//  Created by Lukáš on 20.12.2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                
                VStack {
                    Image("Splashscreen")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .shadow(radius: 20)
                        .padding()
                    Text("Celebrity App")
                        .bold()
                    
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
