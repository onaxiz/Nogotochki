//
//  Untitled.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import Foundation

class ColorLoader {
    static func loadColors() -> [ColorOption] {
        guard let url = Bundle.main.url(forResource: "ColorData", withExtension: "json") else {
            print("Файл не найден")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([ColorOption].self, from: data)
            print("Загрузили \(decoded.count) цветов")
            return decoded
        } catch {
            print("Ошибка при загрузке: \(error)")
            return []
        }
    }
}
