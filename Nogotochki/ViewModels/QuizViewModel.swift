//
//  QuizViewModel.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var preferences = UserPreferences()
    @Published var currentStep = 0
    @Published var isFinished = false
    
    func nextStep() {
        if currentStep < 2 {
            currentStep += 1
        } else {
            isFinished = true
        }
    }
    
    func reset() {
        preferences = UserPreferences()
        currentStep = 0
        isFinished = false
    }
}
