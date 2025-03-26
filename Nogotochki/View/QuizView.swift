//
//  QuizView.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    var onFinish: (UserPreferences) -> Void

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 248/255, blue: 252/255)
                .ignoresSafeArea()

            VStack {
                Spacer()

                if viewModel.isFinished {
                    Button("Готово ✨") {
                        onFinish(viewModel.preferences)
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(Color(red: 240/255, green: 120/255, blue: 160/255))
                    .cornerRadius(16)
                } else {
                    stepView
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }

                Spacer()
            }
        }
    }

    @ViewBuilder
    private var stepView: some View {
        switch viewModel.currentStep {
        case 0:
            questionBlock(
                title: "Какой сейчас сезон?",
                options: Season.allCases.map { $0.rawValue }
            ) { value in
                viewModel.preferences.season = Season(rawValue: value)
                viewModel.nextStep()
            }

        case 1:
            questionBlock(
                title: "Цвет одежды сегодня?",
                options: ["Чёрный", "Белый", "Бежевый", "Красный", "Голубой"]
            ) { value in
                viewModel.preferences.outfitColor = value
                viewModel.nextStep()
            }

        case 2:
            questionBlock(
                title: "Какое настроение?",
                options: Mood.allCases.map { $0.rawValue }
            ) { value in
                viewModel.preferences.mood = Mood(rawValue: value)
                viewModel.nextStep()
            }

        default:
            EmptyView()
        }
    }

    private func questionBlock(title: String, options: [String], action: @escaping (String) -> Void) -> some View {
        VStack(spacing: 24) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 120/255, green: 70/255, blue: 90/255))

            ForEach(options, id: \.self) { option in
                Button(action: {
                    action(option)
                }) {
                    Text(option)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(red: 240/255, green: 120/255, blue: 160/255)) 
                        .padding(.vertical, 6)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
