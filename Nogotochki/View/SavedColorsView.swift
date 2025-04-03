//
//  SavedColorsView.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 27.03.2025.
//

import SwiftUI

struct SavedColorsView: View {
    let savedColors: [ColorOption]
    var onClose: () -> Void

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 248/255, blue: 252/255)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Закрыть", action: onClose)
                        .padding(.top, 16)
                        .padding(.trailing, 16)
                        .foregroundColor(Color(red: 240/255, green: 120/255, blue: 160/255))
                }

                Text("Сохранённые цвета")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 100/255, green: 55/255, blue: 80/255))
                    .padding(.top, 8)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(savedColors) { color in
                            PolaroidCard(
                                color: color.color,
                                name: color.name,
                                totalHeight: 300,
                                overlayIcon: nil
                            )
                        }
                    }
                    .padding(.top, 20)
                }
            }
        }
    }
}
