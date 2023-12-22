//
//  SearchView.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI

import SwiftUI

struct SearchView: View {
    @Binding var searched: String
    @State private var isPersonInfoViewActive = false
    @State private var foundCelebrity: Celebrity? = nil
    @State private var showNotFoundError = false

    @EnvironmentObject var searchHistoryManager: SearchHistoryManager

    var body: some View {
        NavigationView {
            VStack {
                Text("Vyhledávání podle jména")
                    .font(.title.bold())
                    .padding(.bottom, 20)
                    .padding(.top, 40)

                Spacer()

                TextField("Zadejte jméno", text: $searched)
                    .padding()
                   .background(Color(.systemGray6))
                   .cornerRadius(8)
                   .shadow(radius: 2)
                   .padding(.horizontal, 20)
                   .padding(.bottom, 10)
                
                NavigationLink(
                    destination: PersonInfoView(celebrityName: searched, loadedPerson: foundCelebrity),
                    isActive: $isPersonInfoViewActive
                ) {
                    EmptyView()
                }

                Button("Vyhledat") {
                    APICall.shared.fetchCelebrity(forName: searched) { result in
                        switch result {
                        case .success(let celebrity):
                            foundCelebrity = celebrity
                            isPersonInfoViewActive = true
                            showNotFoundError = false
                            searchHistoryManager.addToHistory(searchTerm: celebrity.name.capitalized)
                        case .failure(let error):
                            print("Error searching celebrity: \(error.localizedDescription)")
                            foundCelebrity = nil
                            isPersonInfoViewActive = false
                            showNotFoundError = true
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.horizontal, 20)
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .border(Color.gray, width:1)
            .alert(isPresented: $showNotFoundError) {
                Alert(title: Text("Chyba"), message: Text("Osoba nenalezena"), dismissButton: .default(Text("OK")))
            }
            
            }
        }
    }

#Preview{
    SearchView(searched: .constant("John"))
}
