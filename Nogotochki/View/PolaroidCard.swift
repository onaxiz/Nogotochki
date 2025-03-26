import SwiftUI

struct PolaroidCard: View {
    let color: Color
    let name: String

    var body: some View {
        GeometryReader { geo in
            let totalHeight = geo.size.height
            let horizontalPadding: CGFloat = 16
            let innerPadding: CGFloat = 16
            let bottomPadding: CGFloat = 16
            let topPadding: CGFloat = 16

            let colorHeight = totalHeight - topPadding - bottomPadding - 12 - 20

            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 4)

                VStack(spacing: 0) {
                    Spacer().frame(height: topPadding)

                    color
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .frame(height: colorHeight)
                        .padding(.horizontal, innerPadding)

                    Spacer().frame(height: 12)

                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black.opacity(0.7))

                    Spacer().frame(height: bottomPadding)
                }
                .frame(width: geo.size.width, height: totalHeight)
            }
        }
    }
}
