//
//  Untitled.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    var onFinish: (UserPreferences) -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            if viewModel.isFinished {
                Button("Готово ✨") {
                    onFinish(viewModel.preferences)
                }
            } else {
                stepView
            }
        }
        .padding()
    }

    @ViewBuilder
    private var stepView: some View {
        switch viewModel.currentStep {
        case 0:
            Text("Какой сейчас сезон?")
            ForEach(Season.allCases, id: \.self) { season in
                Button(season.rawValue) {
                    viewModel.preferences.season = season
                    viewModel.nextStep()
                }
            }
        case 1:
            Text("Цвет одежды сегодня?")
            ForEach(["Чёрный", "Белый", "Бежевый", "Красный", "Голубой"], id: \.self) { color in
                Button(color) {
                    viewModel.preferences.outfitColor = color
                    viewModel.nextStep()
                }
            }
        case 2:
            Text("Какое настроение?")
            ForEach(Mood.allCases, id: \.self) { mood in
                Button(mood.rawValue) {
                    viewModel.preferences.mood = mood
                    viewModel.nextStep()
                }
            }
        default:
            EmptyView()
        }
    }
}
