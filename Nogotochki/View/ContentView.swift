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
    @State private var savedColorIDs: [UUID] = ColorStorageManager.loadColors()
    @State private var showHeart = false
    @State private var justSaved = false
    @State private var showSavedColors = false

    var filteredColors: [ColorOption] {
        return colors
    }

    var savedColors: [ColorOption] {
        colors.filter { savedColorIDs.contains($0.id) }
    }

    var isCurrentColorSaved: Bool {
        savedColorIDs.contains(filteredColors[currentIndex].id)
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
                        HStack {
                            Button(action: {
                                restartQuiz()
                            }) {
                                Label("Анкета", systemImage: "arrow.uturn.left")
                                    .labelStyle(.titleAndIcon)
                            }
                            .foregroundColor(Color(red: 240/255, green: 120/255, blue: 160/255))

                            Spacer()

                            Button("Мои цвета") {
                                showSavedColors = true
                            }
                            .foregroundColor(Color(red: 240/255, green: 120/255, blue: 160/255))
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                        Spacer().frame(height: 20)

                        Text("Вот твой идеальный оттенок 💅")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 100/255, green: 55/255, blue: 80/255))

                        Spacer().frame(height: 24)

                        PolaroidCard(
                            color: filteredColors[currentIndex].color,
                            name: filteredColors[currentIndex].name,
                            totalHeight: UIScreen.main.bounds.height * 0.60,
                            overlayIcon: showHeart
                                ? Image(systemName: justSaved ? "heart.fill" : "heart.slash")
                                : nil
                        )
                        .id(filteredColors[currentIndex].id)
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .opacity
                        ))
                        .animation(.easeOut(duration: 0.4), value: filteredColors[currentIndex].id)

                        Spacer().frame(height: 24)

                        HStack(spacing: 16) {
                            Button(action: {
                                withAnimation {
                                    currentIndex = (currentIndex + 1) % filteredColors.count
                                }
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
                                let currentColor = filteredColors[currentIndex]

                                if isCurrentColorSaved {
                                    ColorStorageManager.removeColor(id: currentColor.id)
                                    savedColorIDs.removeAll { $0 == currentColor.id }
                                    justSaved = false
                                } else {
                                    ColorStorageManager.saveColor(id: currentColor.id)
                                    savedColorIDs.append(currentColor.id)
                                    justSaved = true
                                }

                                withAnimation {
                                    showHeart = true
                                }

                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation {
                                        showHeart = false
                                    }
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Text(isCurrentColorSaved ? "Удалить" : "Сохранить")
                                }
                                .frame(minWidth: 140)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 14)
                                .background(isCurrentColorSaved
                                            ? Color(red: 180/255, green: 100/255, blue: 140/255)
                                            : Color(red: 240/255, green: 120/255, blue: 160/255))
                                .cornerRadius(16)
                            }
                        }

                        Spacer().frame(height: 24)
                    }
                    .padding(.horizontal, 16)
                }
                .sheet(isPresented: $showSavedColors) {
                    SavedColorsView(savedColors: savedColors) {
                        showSavedColors = false
                    }
                }
            }
        }
    }

    private func restartQuiz() {
        quizVM.reset()
        showQuiz = true
    }
}
