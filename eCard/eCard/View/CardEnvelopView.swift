//
//  CardEnvelopView.swift
//  eCard
//
//  Created by Alexandra on 2024/9/6.
//

import SwiftUI

struct CardEnvelopView: View {
    private let layout = Layout()

    @ObservedObject var card: ECardModel

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: layout.envelop.gradientColor.reversed()),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: layout.envelop.size.width, height: layout.envelop.size.height)

            EnvelopeTopShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: card.showCard ? layout.envelop.gradientColor.reversed() : layout.envelop.gradientColor),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: layout.envelop.size.width, height: layout.envelop.size.height)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5) // Only applies shadow to the hypotenuse of the triangle.
                .rotation3DEffect(
                    .degrees(card.showCard ? -180 : 0), // Flip based on the `showCard` property.
                    axis: (x: 1.0, y: 0.0, z: 0.0), // Rotate along the X-axis.
                    anchor: .top, // Anchor point at the top of the view.
                    anchorZ: 0,
                    perspective: 0
                )
                .animation(.easeInOut(duration: 0.6), value: card.showCard)
                .zIndex(card.showCard ? 0 : 2) // Top layer

            EnvelopeFrontShape()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: layout.envelop.gradientColor),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: layout.envelop.size.width, height: layout.envelop.size.height)
                .shadow(radius: 5)
                .zIndex(card.showCard ? 2 : 1) // Top layer

            // eCard
            SmallCard(with: card)
                .offset(y: card.showCard ? -layout.smallCard.showCardOffset : 0) // Extract the current card.
                .offset(y: card.showCard ? -card.cardYOffset : 0)
                .zIndex(card.showCard ? 1 : 0)

            HStack(alignment: .bottom) {
                Text(card.year)
                    .font(.body)
                    .italic()
                    .foregroundColor(layout.envelop.textColor)
                    .padding(5)
                Spacer()
                Text("To \(card.receiver)")
                    .font(.body.bold())
                    .italic()
                    .foregroundColor(layout.envelop.textColor)
                    .padding(5)
            }
            .frame(width: layout.envelop.size.width, alignment: .bottom)
            .padding(5)
            .zIndex(3)
        }
    }
}

private extension CardEnvelopView {
    /// E-Card Preview
    @ViewBuilder
    func SmallCard(with card: ECardModel) -> some View {
        AsyncImage(url: URL(string: card.cardImageUrl), content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: layout.smallCard.size.width, maxHeight: layout.smallCard.size.height, alignment: .top)
        }, placeholder: {
            Color.black
                .frame(width: layout.smallCard.size.width, height: layout.smallCard.size.height, alignment: .center)
        })
        .cornerRadius(10)
    }
}

// MARK: - Shapes

struct EnvelopeTopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // 信封的上蓋 (三角形)
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}

struct EnvelopeFrontShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // 信封的下三角
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width / 2, y: height / 2))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        return path
    }
}


#Preview {
    @StateObject var card: ECardModel = sampleCards.first!

    return CardEnvelopView(card: card)
}
