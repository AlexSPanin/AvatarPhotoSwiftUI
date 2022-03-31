//
//  ButtonsPhotoModel.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import Foundation

enum ButtonsPhoto: Int {
    case getLibrary, getCamera, sharePhoto, rotatedRigth, rotatedLeft
}

struct ButtonsPhotoModel {
    var type: ButtonsPhoto
    var nameImage: String
}
