//
//  ColorStorageManager.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 27.03.2025.
//

import Foundation

struct ColorStorageManager {
    private static let key = "savedColorIDs"

    static func saveColor(id: UUID) {
        var savedIDs = getSavedColorIDs()
        if !savedIDs.contains(id) {
            savedIDs.append(id)
            UserDefaults.standard.set(savedIDs.map { $0.uuidString }, forKey: key)
        }
    }

    static func removeColor(id: UUID) {
        var savedIDs = getSavedColorIDs()
        savedIDs.removeAll { $0 == id }
        UserDefaults.standard.set(savedIDs.map { $0.uuidString }, forKey: key)
    }

    static func getSavedColorIDs() -> [UUID] {
        let idStrings = UserDefaults.standard.stringArray(forKey: key) ?? []
        return idStrings.compactMap { UUID(uuidString: $0) }
    }

    static func isColorSaved(id: UUID) -> Bool {
        return getSavedColorIDs().contains(id)
    }

    static func loadColors() -> [UUID] {
        return getSavedColorIDs()
    }
}
