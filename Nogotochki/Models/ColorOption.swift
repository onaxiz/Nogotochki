//
//  Untitled.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import SwiftUI

struct ColorOption: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let brand: String
    let hex: String
    let style: Style

    enum Style: String, Codable {
        case nude
        case bright
        case experimental
    }

    var color: Color {
        return Color(hex: hex)
    }
}
