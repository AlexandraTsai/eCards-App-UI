//
//  FullCardView.swift
//  eCard
//
//  Created by Alexandra on 2024/9/7.
//

import SwiftUI

struct FullCardView: View {
    private let layout = Layout()

    @ObservedObject var card: ECardModel

    var body: some View {
        ScrollView(.vertical) {
            ZStack(alignment: .top) {
                // Background Color
                PartialRoundedShape(corners: [.bottomLeft, .bottomRight], radius: 25)
                    .fill(card.averageColor)

                AsyncImage(url: URL(string: card.cardImageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {}

                CardContent(card)
                    .padding(.top, layout.card.backgroundImageSize.height / 2)
                    .padding(.all, 30)
            }
            .padding(.horizontal, 30)
        }
    }
    
    @ViewBuilder
    func CardContent(_ card: ECardModel)  -> some View {
        ZStack(alignment: .center) {
            Color.white

            Text(card.content)
                .font(.body)
                .foregroundColor(Color.neutral050)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .bottom, .top])
                .frame(maxWidth: .infinity, alignment: .top)
        }
    }
}

#Preview {
    FullCardView(card: sampleCards.first!)
}
