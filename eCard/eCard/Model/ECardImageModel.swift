//
//  ECardImageModel.swift
//  eCard
//
//  Created by Alexandra on 2024/9/8.
//

import Foundation

struct ECardImageModel: Identifiable {
    var id: UUID = .init()
    var imageName: String
}

var eCardImages: [ECardImageModel] = (1...8).compactMap({ECardImageModel(imageName: "ecard-image-\($0)")})
