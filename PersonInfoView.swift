//
//  PersonInfoView.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI

struct PersonInfoView: View {
    let celebrityName: String
    @State private var loadedPerson: Celebrity?

    //Init pro načtení osobnosti
    init(celebrityName: String, loadedPerson: Celebrity?) {
        self.celebrityName = celebrityName
        self._loadedPerson = State(initialValue: loadedPerson)
    }

    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        Text("Informace o osobě: \(loadedPerson?.name.capitalized ?? "")")
                            .font(.title)
                            .foregroundColor(.blue)

                        if loadedPerson == nil {
                            //ApiCall
                            ProgressView("Načítám informace o osobě...")
                                .onAppear {
                                    APICall.shared.fetchCelebrity(forName: celebrityName) { result in
                                        switch result {
                                        case .success(let celebrity):
                                            DispatchQueue.main.async {
                                                self.loadedPerson = celebrity
                                            }
                                        case .failure(let error):
                                            print("Error fetching celebrity data: \(error.localizedDescription)")
                                        }
                                    }
                                }
                        } else {
                            Divider()

                            VStack(alignment: .leading, spacing: 12) {
                                InfoRow(title: "Věk", value: "\(loadedPerson!.age)")
                                InfoRow(title: "Národnost", value: loadedPerson!.nationality.uppercased())
                                HStack {
                                    Text("Povolání")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 4) {
                                        ForEach(loadedPerson!.occupation, id: \.self) { occupation in
                                            Text(occupation.formatOccupation())
                                                .font(.system(size: 23))
                                        }
                                    }
                                }
                                InfoRow(title: "Výška", value: String(format: "%.2f m", loadedPerson?.height ?? 0.0))
                                InfoRow(title: "Žije", value: loadedPerson!.isAlive ? "Ano" : "Ne")
                                InfoRow(title: "Net worth", value: "$" + formatNetWorth(loadedPerson?.netWorth ?? 0))
                            }
                            .padding()
                        }

                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }

struct InfoRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .foregroundColor(.blue)
            Spacer()
            Text(value)
                .font(.system(size: 23))
        }
        .padding(.vertical,10)
    }
}

// Uprava vypisu povolání
extension String {
    func formatOccupation() -> String {
        let components = self.components(separatedBy: "_")
        let formattedOccupation = components.map { $0.capitalized }.joined(separator: " ")
        return formattedOccupation
    }
}

#Preview{
        PersonInfoView(celebrityName: "Taylor Swift", loadedPerson: nil)
    }

// Formátování net worth
func formatNetWorth(_ netWorth: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 0
    formatter.currencySymbol = ""
    return formatter.string(from: NSNumber(value: netWorth)) ?? "Chybí"
}
