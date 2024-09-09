//
//  CardsContainerView.swift
//  eCard
//
//  Created by Alexandra on 2024/9/2.
//

import SwiftUI

struct LibraryChildView: View {
    private let layout = Layout()

    @ObservedObject var cardList: ECardListModel

    // MARK: Custom Scroller Properties

    @State var currentIndex: Int = 0
    @State var currentCard: ECardModel?

    var body: some View {
        VStack {
            CardsEnvelopeScroller()
                .zIndex(1) // Top Layer
            StandView
                .zIndex(0)
                .padding(.horizontal, -10)
                .frame(height: 10, alignment: .top)
                .scaleEffect(CGSize(width: 1.5, height: 1))

            // MARK: Custom Scroller

            TabView {
                ForEach($cardList.cards) { $card in
                    FullCardView(card: card)

                        .offsetX { value, width in
                            let cardIndex = getIndex(card: card)
                            let isCurrentCard = currentIndex == cardIndex

                            if isCurrentCard {
                                // MARK: updating offset

                                // Converting FullCardView's offsetX to layout.smallCard.showCardOffset
                                // Small card will goes inside when doing swipe on both sides
                                var offset = ((value > 0 ? -value : value) / width) * layout.smallCard.showCardOffset
                                offset = (-offset < layout.smallCard.showCardOffset ? offset : -layout.smallCard.showCardOffset)
                                card.cardYOffset = offset
                            }

                            // MARK: Updating Card When The Card is Released

                            if value == 0 && !isCurrentCard {
                                card.cardYOffset = 0
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    cardList.cards[currentIndex].showCard = false
                                    currentIndex = getIndex(card: card)
                                    currentCard = cardList.cards[currentIndex]
                                }
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1).delay(0.4)) {
                                    // 將 showCard 設為 true，以抽出卡片
                                    cardList.cards[currentIndex].showCard = true
                                }
                            }
                        }

                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .zIndex(0)
            .onAppear(perform: {

                // Showing card for first greeting card
                // 抽出第一張卡的動畫
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1).delay(1)) {
                    cardList.cards[currentIndex].showCard = true
                }
            })
            .padding(15)
        }
        .onAppear(perform: {
            self.currentCard = cardList.cards.first
        })

    }
}

// MARK: E-Card Index

private extension LibraryChildView {

    func getIndex(card: ECardModel) -> Int {
        return cardList.cards.firstIndex { _card in
            card.id == _card.id
        } ?? 0
    }
}

// MARK: - Views

private extension LibraryChildView {

    @ViewBuilder
    func CardsEnvelopeScroller() -> some View {
        GeometryReader(content: { proxy in
            let size = proxy.size

            // MARK: Showing Before And After Cards

            LazyHStack {
                ForEach($cardList.cards) { $card in
                    let cardIndex = getIndex(card: card)
                    let isPreviousCard = currentIndex > cardIndex
                    let isCurrentCard = currentIndex == cardIndex

                    CardEnvelopView(card: card)
                        .offset(x: layout.envelop.offset)
                        .frame(
                            width: size.width,
                            alignment:
                            isPreviousCard ? .trailing : // Used to display part of the previous envelope.
                                (isCurrentCard ? .center : .leading) // Used to display part of the next envelope.
                        )
                        .scaleEffect(currentCard?.id == card.id ? 1 : 0.8, anchor: .bottom)
                        .offset(x: isPreviousCard ? layout.envelop.previousOffset : (isCurrentCard ? 0 : -layout.envelop.nextOffset)) // Used to display parts of the previous and next envelopes.
                }
            }
            // When you change the paging of the TabView, the scroller will slide to the corresponding card.
            .offset(x: CGFloat(currentIndex) * -size.width)
        })
        .frame(height: layout.envelop.size.height)
    }

    /// Card display stand（展示台）
    var StandView: some View {
        ZStack(alignment: .top, content: {
            Rectangle()
                .fill(layout.standerColor)
                .shadow(color: layout.standerColor.opacity(0.85), radius: 20, x: 0, y: 5)
                .frame(height: 10)
                .scaleEffect(1.5)

            Rectangle()
                .fill(layout.standerBackgroundColor)
                .frame(height: 385)
                .rotation3DEffect(
                    .init(degrees: -98),
                    axis: (x: 1.0, y: 0.0, z: 0.0),
                    anchor: .top,
                    anchorZ: 0.5,
                    perspective: 1
                )
                .shadow(color: .gray.opacity(0.88), radius: 25, x: 0, y: 5)
                .shadow(color: .gray.opacity(0.88), radius: 5, x: 0, y: 15)
        })
    }
}

#Preview {
    @StateObject var sampleCardList: ECardListModel = ECardListModel(cards: sampleCards)

    return LibraryChildView(cardList: sampleCardList)
}
