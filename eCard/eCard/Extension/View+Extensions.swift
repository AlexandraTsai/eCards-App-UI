//
//  View+Extensions.swift
//  eCard
//
//  Created by Alexandra on 2024/9/6.
//

import SwiftUI

extension View {
    func offsetX(completion: @escaping (CGFloat, CGFloat) -> ()) -> some View {
        if #available(iOS 15.0, *) {
            return self.overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: OffsetXKey.self,
                            value: proxy.frame(in: .global).minX
                        )
                        .onPreferenceChange(OffsetXKey.self, perform: { value in
                            completion(value, proxy.size.width)
                        })
                }
            }
        } else {
            return ZStack {
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: OffsetXKey.self,
                            value: proxy.frame(in: .global).minX
                        )
                        .onPreferenceChange(OffsetXKey.self, perform: { value in
                            completion(value, proxy.size.width)
                        })
                }
                self
            }
        }
    }

    func getWidth(_ width: Binding<CGFloat>) -> some View {
        modifier(GetWidthModifier(width: width))
    }
}

struct GetWidthModifier: ViewModifier {
    @Binding var width: CGFloat
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    let proxyWidth = proxy.size.width
                    Color.clear
                        .task(id: proxy.size.width) {
                            $width.wrappedValue = max(proxyWidth, 0)
                        }
                }
            )
    }
}


struct OffsetXKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
