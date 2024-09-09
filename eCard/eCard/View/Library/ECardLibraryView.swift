//
//  ECardLibraryView.swift
//  eCard
//
//  Created by Alexandra on 2024/9/6.
//

import SwiftUI
import Combine

struct ECardLibraryView: View {
    public let createButtonTapped = PassthroughSubject<Void, Never>()
    private let layout = Layout()

    // MARK: Cards

    @StateObject var cardList: ECardListModel = ECardListModel(cards: sampleCards)

    public var body: some View {
        NavigationView {
            ZStack {
                layout.backgroundColor
                    .ignoresSafeArea()

                VStack {
                    NavigationBar()
                        .padding(15)

                    LibraryChildView(cardList: cardList)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

// MARK: - Views

private extension ECardLibraryView {

    @ViewBuilder
    func NavigationBar() -> some View {
        HStack(alignment: .top, content: {
            Text("My E-Cards Library")
                .font(.largeTitle.bold())
                .foregroundColor(layout.titleColor)
                .padding(.trailing, 30)

            // To align the button to the right.
            Spacer()

            NavigationLink(
                destination: ECardCarousel(),
                label: {
                    Image(systemName: layout.createButtonImageName)
                        .resizable()
                        .foregroundColor(layout.createCardColor)
                        .frame(width: layout.createButtonSize, height: layout.createButtonSize)
                })
        })
    }
}

#Preview {
    ECardLibraryView()
}
