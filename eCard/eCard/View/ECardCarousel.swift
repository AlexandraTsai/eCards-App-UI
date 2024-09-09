//
//  ECardCarousel.swift
//  eCard
//
//  Created by Alexandra on 2024/9/8.
//

import SwiftUI

struct ECardCarousel: View {

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HStack(spacing: 12) {
                    // 其他內容
                }

                Text("Choose A New Card")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 10)

                /// Parallax Carousel
                GeometryReader(content: { geometry in
                    let size = geometry.size

                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(eCardImages) { image in
                                /// In order to move the card in reverse direction
                                GeometryReader(content: { geometry in
                                    let cardSize = geometry.size
                                    /// Parallax (視差) Effect
                                    let minX = geometry.frame(in: .scrollView).minX
                                    let _ = print("[\(image.imageName)] minX: \(minX)")

                                    Image(image.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x: -minX)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)

                                })

                                .frame(
                                    width: size.width - 30 * 2,
                                    height: size.height - 50 // the shadow at the bottom is not visible since the scrollview wraps the wrap view -> thus giving it some space to show shadows at the bottom.
                                )
                                /// Scroll Animation
                                .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                    view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }

                        }
                        .padding(.horizontal, 30)
                        .frame(height: size.height, alignment: .top)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                })
                .frame(height: 500)
                .padding(.horizontal, -15)
                .padding(.top, 10)
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    ECardLibraryView()
}
