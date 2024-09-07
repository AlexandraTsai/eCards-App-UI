//
//  ECardModel.swift
//  eCard
//
//  Created by Alexandra on 2024/8/26.
//

import SwiftUI

class ECardListModel: ObservableObject {
    @Published var cards: [ECardModel]

    init(cards: [ECardModel]) {
        self.cards = cards
    }
}

class ECardModel: ObservableObject, Identifiable {
    init(
        cardImageUrl: String,
        content: String,
        receiver: String,
        writer: String,
        year: String,
        showCard: Bool = false,
        cardOffset: CGFloat = 0
    ) {
        self.cardImageUrl = cardImageUrl
        self.content = "Dear \(receiver),\n\n\(content)\n\n From: \(writer)"
        self.receiver = receiver
        self.writer = writer
        self.year = year
        self.showCard = showCard
        self.cardYOffset = cardOffset

        loadImageFromURL()
    }
    
    let id: String = UUID().uuidString
    let cardImageUrl: String
    let content: String
    let receiver: String
    let writer: String
    let year: String

    @Published var showCard: Bool = false
    /// The offset of the card on the y-axis.
    @Published var cardYOffset: CGFloat = 0
    /// The average color of the card image
    @Published var averageColor: Color = .clear

    private func loadImageFromURL() {
        guard let imageURL = URL(string: cardImageUrl) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.averageColor = Color(uiColor: image.averageColor ?? .clear)
                }
            }
        }.resume()
    }
}

var sampleCards: [ECardModel] = [
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2023/10/12/20/16/autumncontest-8311751_960_720.jpg",
        content: """
        🎃 Happy Halloween! 🎃
        As the spooky night approaches, may your home be filled with eerie laughter, ghostly treats, and mysterious fun. Don’t forget to light your jack-o’-lantern and keep an eye out for witches and goblins roaming the streets. Whether you're out trick-or-treating or enjoying a haunted night in, may your Halloween be full of frights and delights!

        Wishing you a boo-tiful and spooktacular Halloween!
        """,
        receiver: "Lyra",
        writer: "Alexandra",
        year: "2024.11"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2016/11/07/12/25/christmas-card-1805661_1280.jpg",
        content: """
        🎄 Merry Christmas! 🎄
        As the holiday season fills the air with warmth and cheer, may your home be filled with love, joy, and laughter. The twinkling lights and cozy moments remind us of the beauty of togetherness and the magic of giving. Whether you're celebrating with family or friends, near or far, may your heart be full of happiness and your days full of festive joy.

        Wishing you a holiday season as magical as the first snowfall and as bright as the Christmas star. Here's to a joyful Christmas and a prosperous New Year!

        🎅✨🎁
        """,
        receiver: "Santa",
        writer: "Alexandra",
        year: "2023.12"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2023/03/06/14/19/fox-7833563_960_720.jpg",
        content: """
        Wishing you a magical and joyful birthday filled with all the things you love most. May your day be as special as you are, surrounded by those who care for you, and filled with happy moments that you'll cherish forever. The Moomins send their warmest wishes too, hoping that your year ahead is full of wonderful adventures and dreams come true.

        Here's to another fantastic year ahead!
        """,
        receiver: "Zephyr",
        writer: "Alexandra",
        year: "2023.06"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2018/07/20/17/42/girl-3551152_960_720.jpg",
        content: """
        🏊‍♂️ Summer Splash! 🌞
        There’s nothing like the refreshing feeling of diving into cool, crystal-clear water on a hot summer day. As the sun shines bright, may your days be filled with laughter, waves, and endless swims. Whether you’re floating under the sun or racing through the water, enjoy every splash, every dive, and every moment of summer freedom!

        Wishing you a summer full of fun, sun, and refreshing swims!

        🌊🌴🌺
        """,
        receiver: "Santa",
        writer: "Alexandra",
        year: "2022.07"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2023/03/06/14/19/crocodile-7833562_960_720.jpg",
        content: """
        Words cannot express how thankful I am for everything you’ve done. Your kindness, support, and unwavering belief in me have meant the world. You've always been there, and I am so grateful to have someone like you in my life. Your generosity has made such a difference, and I want you to know just how much I appreciate all you’ve done. Thank you, from the bottom of my heart.

        With deepest gratitude,
        """,
        receiver: "Cassian",
        writer: "Alexandra",
        year: "2022.01"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2022/06/29/10/58/fox-7291456_960_720.jpg",
        content: """
        Merry Christmas! As we celebrate this joyous season, may your heart be filled with love, peace, and happiness. This time of year reminds us of the importance of family, friends, and the warmth they bring into our lives. May the festive lights and holiday cheer bring you comfort and joy, and may the new year ahead be filled with blessings and new opportunities. Here's to a wonderful holiday season and a prosperous new year!

        Wishing you a Christmas full of love and laughter,
        """,
        receiver: "Orion",
        writer: "Alexandra",
        year: "2019.03"
    ),
    ECardModel(
        cardImageUrl: "https://cdn.pixabay.com/photo/2014/01/27/05/59/easter-eggs-252874_960_720.jpg",
        content: """
        May the full moon bring you joy and peace on this Moon Festival. The roundness of the moon symbolizes togetherness and unity, and I hope that you are surrounded by the warmth of loved ones as you bask in its glow. Enjoy the beauty of the moonlight, the delicious mooncakes, and the time spent with family and friends. May this festival remind you of all the good things in life and bring a sense of tranquility to your heart.

        Wishing you happiness, prosperity, and a life filled with peace.
        """,
        receiver: "Azura",
        writer: "Alexandra",
        year: "2017"
    )
]
