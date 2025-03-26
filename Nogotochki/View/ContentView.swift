//
//  ContentView.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 25.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var quizVM = QuizViewModel()
    @State private var showQuiz = true
    @State private var preferences: UserPreferences?

    let colors = ColorLoader.loadColors()
    @State private var currentIndex = 0

    var filteredColors: [ColorOption] {
        return colors
    }

    var body: some View {
        if showQuiz {
            QuizView(viewModel: quizVM) { selected in
                preferences = selected
                showQuiz = false
            }
        } else {
            if filteredColors.isEmpty {
                Text("Не удалось загрузить цвета")
                    .foregroundColor(.gray)
            } else {
                ZStack {
                    Color(red: 255/255, green: 248/255, blue: 252/255)
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        Spacer().frame(height: 40)

                        Text("Вот твой идеальный оттенок 💅")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 100/255, green: 55/255, blue: 80/255))

                        Spacer().frame(height: 24)

                        PolaroidCard(
                            color: filteredColors[currentIndex].color,
                            name: filteredColors[currentIndex].name,
                            totalHeight: UIScreen.main.bounds.height * 0.60
                        )

                        Spacer().frame(height: 24)

                        HStack(spacing: 16) {
                            Button(action: {
                                currentIndex = (currentIndex + 1) % filteredColors.count
                            }) {
                                Text("Не подходит")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(red: 150/255, green: 100/255, blue: 120/255))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 14)
                                    .background(Color.gray.opacity(0.08))
                                    .cornerRadius(16)
                            }

                            Button(action: {
                                //todo
                            }) {
                                Text("Сохранить")
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 14)
                                    .background(Color(red: 240/255, green: 120/255, blue: 160/255))
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}
