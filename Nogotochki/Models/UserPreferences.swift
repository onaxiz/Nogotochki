//
//  UserPreferences.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

struct UserPreferences: Codable {
    var season: Season?
    var outfitColor: String?
    var mood: Mood?
}

enum Season: String, CaseIterable, Codable {
    case winter = "Зима"
    case spring = "Весна"
    case summer = "Лето"
    case autumn = "Осень"
}

enum Mood: String, CaseIterable, Codable {
    case nude = "Нюд"
    case bright = "Яркий"
    case experimental = "Готова к эксперименту"
}
