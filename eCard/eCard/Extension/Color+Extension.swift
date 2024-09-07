//
//  Color+Extension.swift
//  eCard
//
//  Created by Alexandra on 2024/9/6.
//

import SwiftUI

extension Color {

    /// Used to receive a hexadecimal string representing a color and convert it to a `Color` object.
    /// For example, #FF5733 represents orange.
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")

        // rgb: A 64-bit unsigned integer
        // Used to store the RGB integer value converted from a hexadecimal string.
        var rgb: UInt64 = 0

        // Use the `Scanner` class to scan the hexadecimal string and convert it to a number, storing it in the `rgb` variable.
        Scanner(string: cleanHexCode)
            .scanHexInt64(&rgb)

        /// `rgb >> 16` shifts `rgb` 16 bits to the right, removing the rightmost 16 bits, leaving the value for the red channel.
        /// `& 0xFF` is used to retain only the lowest 8 bits of the red channel (i.e., the red value).
        /// Dividing by `255.0` gives a floating-point number between `0 and 1`, which is the format required by `Color`.
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0

        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
