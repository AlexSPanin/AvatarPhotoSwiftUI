//
//  AvatarPhotoViewModel.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import Foundation
import UIKit

class AvatarPhotoViewModel: ObservableObject {
    
    let upperButtons = ButtonsPhotoDataManager.getUpperButtonsPhoto()
    let lowerButtons = ButtonsPhotoDataManager.getLowerButtonsPhoto()
    
    var typePressButton: ButtonsPhoto = .getLibrary
    var photo = UIImage(systemName: "person.fill")
    
    init() {
        
    }
    
    func pressedButtonsPhoto() {
        switch typePressButton {
        case .getLibrary:
            getPhotoLibrary()
        case .getCamera:
            getPhotoCamera()
        case .sharePhoto:
            sharePhoto()
        case .rotatedRigth:
            rotatedRigth()
        case .rotatedLeft:
            rotatedLeft()
        }
    }
    
    func getPhotoLibrary() {
        
    }
    
    func getPhotoCamera() {
        
    }
    
    func sharePhoto() {
        
    }
    
    func rotatedRigth() {
        
    }
    
    func rotatedLeft() {
        
    }
    
}
