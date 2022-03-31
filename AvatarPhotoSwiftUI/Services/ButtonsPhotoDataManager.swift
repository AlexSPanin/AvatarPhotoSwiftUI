//
//  ButtonsPhotoDataManager.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import Foundation

struct ButtonsPhotoDataManager {
    
    static func getButtonsPhoto() -> [ButtonsPhotoModel] {
      [
        ButtonsPhotoModel(type: .getLibrary, nameImage: "photo"),
        ButtonsPhotoModel(type: .getCamera, nameImage: "camera"),
        ButtonsPhotoModel(type: .sharePhoto, nameImage: "square.and.arrow.up"),
        ButtonsPhotoModel(type: .rotatedRigth, nameImage: "rotate.right"),
        ButtonsPhotoModel(type: .rotatedLeft, nameImage: "rotate.left"),
      ]
    }
}
