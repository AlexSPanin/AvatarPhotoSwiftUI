//
//  AvatarPhotoViewModel.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

enum TypeSource {
    case camera
    case gallary
}

class AvatarPhotoViewModel: ObservableObject {
    
    let upperButtons = ButtonsPhotoDataManager.getUpperButtonsPhoto()
    let lowerButtons = ButtonsPhotoDataManager.getLowerButtonsPhoto()
    
    var typePressButton: ButtonsPhoto = .getLibrary
    {
        didSet
        {
            pressedButtonsPhoto()
        }
    }
    @Published  var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published  var isImagePickerDisplay: Bool = false
    
    init() {}
    
  
    func pressedButtonsPhoto() {
        switch typePressButton {
        case .getLibrary:
            self.sourceType = .photoLibrary
            self.isImagePickerDisplay.toggle()
        case .getCamera:
            self.sourceType = .camera
            self.isImagePickerDisplay.toggle()
        case .sharePhoto:
            sharePhoto()
        case .rotatedRigth:
            rotatedRigth()
        case .rotatedLeft:
            rotatedLeft()
        }
    }
    
    func sharePhoto() {
        
    }
    
    func rotatedRigth() {
        
    }
    
    func rotatedLeft() {
        
    }
    
}
