//
//  Layout.swift
//  eCard
//
//  Created by Alexandra on 2024/9/7.
//

import Swift
import SwiftUI

struct Layout {
    static let totalWidth = UIScreen.main.bounds.width

    let envelop = Envelop()
    let smallCard = SmallCard()
    let card = Card()

    let backgroundColor = Color.white
    let titleColor = Color.primary060
    let createCardColor = Color.primary040
    let createButtonImageName = "plus.circle.fill"
    let createButtonSize: CGFloat = 50
    let standerColor = Color.primary020
    let standerBackgroundColor = Color.neutral030

    struct Envelop {
        let size: CGSize
        /// Used to pre-display the next envelope.
        let offset: CGFloat
        let previousOffset: CGFloat = 70
        let nextOffset: CGFloat = 60
        let textColor = Color.envelopText
        let gradientColor = [Color.card, Color.card1]

        init() {
            let width = totalWidth / 2
            self.size = CGSize(width: width, height: (130 / 200) * width)
            self.offset = CGFloat(-((35 / 210) * width))
        }
    }

    struct SmallCard {
        let size: CGSize
        /// 抽出半張卡
        let showCardOffset: CGFloat

        init() {
            let width = (180 / 430) * totalWidth
            self.size = CGSize(width: width, height: (110 / 180) * width)
            self.showCardOffset = width / 2
        }
    }

    struct Card {
        let backgroundImageSize: CGSize
        let hPadding: CGFloat

        init() {
            let hPadding: CGFloat = 30
            let width = totalWidth - hPadding * 2
            self.backgroundImageSize = CGSize(width: width, height: width)
            self.hPadding = hPadding
        }
    }
}
