//
//  PartialRoundedShape.swift
//  eCard
//
//  Created by Alexandra on 2024/9/7.
//

import SwiftUI

struct PartialRoundedShape: Shape {
    // Define the corners that should be rounded, using UIRectCorner to specify which corners (e.g., top left, top right, etc.)
    var corners: UIRectCorner
    // Define the radius for the rounded corners
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        // Create a UIBezierPath with rounded corners for the specified corners and radius
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners, // Specify which corners to round
            cornerRadii: CGSize(width: radius, height: radius) // Set the radius for the rounded corners
        )
        // Convert the UIBezierPath to a Path and return it
        return .init(path.cgPath)
    }
}
