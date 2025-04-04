//
//  PolaroidCard.swift
//  Nogotochki
//
//  Created by Евгения Максимова on 26.03.2025.
//

import SwiftUI

struct PolaroidCard: View {
    let color: Color
    let name: String
    let totalHeight: CGFloat
    let overlayIcon: Image?

    var body: some View {
        let horizontalPadding: CGFloat = 16
        let innerPadding: CGFloat = 16
        let topPadding: CGFloat = 16
        let bottomPadding: CGFloat = 32
        let nameHeight: CGFloat = 20

        let colorHeight = totalHeight - topPadding - bottomPadding - nameHeight

        return ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 4)

            VStack(spacing: 0) {
                Spacer().frame(height: topPadding)

                ZStack {
                    color
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .frame(height: colorHeight)
                        .padding(.horizontal, innerPadding)

                    if let icon = overlayIcon {
                        icon
                            .font(.system(size: 48))
                            .foregroundColor(Color(red: 240/255, green: 120/255, blue: 160/255))
                            .transition(.scale)
                    }
                }

                Spacer().frame(height: 12)

                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.black.opacity(0.7))

                Spacer().frame(height: bottomPadding)
            }
        }
        .frame(height: totalHeight)
        .padding(.horizontal, horizontalPadding)
    }
}
