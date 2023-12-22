//
//  HomeView.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    CategoryRow(categoryName: "Interpreti", items: Interpreti)
                    CategoryRow(categoryName: "Herci", items: Herci)
                    CategoryRow(categoryName: "Ostatní", items: Ostatni)
                }
                .padding()
            }
            
            .navigationBarTitle("Domovská stránka", displayMode: .large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CategoryRow: View {
    var categoryName: String
    var items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.title.bold())
                

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(items, id: \.self) { imageName in
                        NavigationLink(destination: PersonInfoView(celebrityName: imageName, loadedPerson: nil)) {
                            Image(imageName)
                                .resizable()
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(Color.gray, lineWidth: 3)
                                }
                                .shadow(radius: 2)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.vertical, 30)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}


// Umělá data
let Interpreti = ["taylor_swift", "ed_sheeran", "john_mayer"]
let Herci = ["margot_robbie", "andrew_garfield", "keanu_reeves"]
let Ostatni = ["alan_ritchson", "ryan_reynolds", "ryan_gosling"]

#Preview{
    HomeView()
}
