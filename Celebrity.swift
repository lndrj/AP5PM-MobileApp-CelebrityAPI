//
//  Celebrity.swift
//  MobilniAplikace
//
//  Created by Lukáš on 16.12.2023.
//

import Foundation

class Celebrity: Identifiable, Decodable {
    let name: String
    let netWorth: Int
    let gender: String
    let nationality: String
    let occupation: [String]
    let height: Double
    let birthday: String
    let age: Int
    let isAlive: Bool
    
    private enum CodingKeys: String, CodingKey {
        case name
        case netWorth
        case gender
        case nationality
        case occupation
        case height
        case birthday
        case age
        case isAlive
    }
    
}
