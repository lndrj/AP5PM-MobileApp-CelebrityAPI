//
//  ToolBar.swift
//  MobilniAplikace
//
//  Created by Lukáš on 15.12.2023.
//

import SwiftUI

enum Tabs: String, CaseIterable{
    case house
    case clock
    case magnifyingglass
}

struct ToolBar: View {
    @Binding var selected: Tabs
    private var filled: String{
        selected.rawValue == Tabs.magnifyingglass.rawValue ? selected.rawValue : selected.rawValue + ".fill"
    }
    var body: some View {
        VStack{
            HStack{
                ForEach(Tabs.allCases, id: \.rawValue) {tab in
                    Spacer()
                    Image(systemName: selected == tab ? filled : tab.rawValue)
                        .scaleEffect(selected == tab ? 1.25 : 1.0)
                        .foregroundColor(selected == tab ? .blue : .gray)
                        .font(.system(size: 22))
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.1)) {
                                selected = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.white)
            .cornerRadius(5)
            .shadow(radius: 1)

        }
    }
}

#Preview {
    ToolBar(selected: .constant(.house))
}
