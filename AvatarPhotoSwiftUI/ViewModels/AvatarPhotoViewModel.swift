//
//  AvatarPhotoViewModel.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//
import SwiftUI

class AvatarPhotoViewModel: ObservableObject {
    
    let upperButtons = ButtonsPhotoDataManager.getUpperButtonsPhoto()
    let lowerButtons = ButtonsPhotoDataManager.getLowerButtonsPhoto()
    
    var typePressButton: ButtonsPhoto = .getLibrary
    { didSet { pressedButtonsPhoto() } }
    
    var isChange: Bool = false
    
    @Published var photo: UIImage = UIImage(systemName: "person.fill.questionmark") ?? UIImage()
    { didSet { if isChange { imageFilter() } } }
    
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var isImagePickerDisplay: Bool = false
    
    init() {
        fethPhoto()
    }
    
    func fethPhoto() {
        let dataImage = StorageManager.shared.fetchData()
        if let photo = UIImage(data: dataImage, scale: 1.0) { self.photo = photo }
    }
    
    func pressedButtonsPhoto() {
        switch typePressButton {
        case .getLibrary:
            self.sourceType = .photoLibrary
            self.isImagePickerDisplay.toggle()
        case .getCamera:
            self.sourceType = .camera
            self.isImagePickerDisplay.toggle()
        case .savePhoto:
            savePhoto()
        case .rotatedRigth:
            let rotatedImage = photo.rotate(radians: .pi * 0.5)
            photo = rotatedImage
        case .rotatedLeft:
            let rotatedImage = photo.rotate(radians: .pi * 1.5)
            photo = rotatedImage
        }
    }
    
    func savePhoto() {
        if let dataImage = photo.jpegData(compressionQuality: 1.0) {
            StorageManager.shared.save(at: dataImage) }
    }
    
    // MARK: - применение фильтра и вывод изображения во вью
    func imageFilter() {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: photo)
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")
        currentFilter?.setDefaults()
        currentFilter?.setValue(inputImage, forKey: kCIInputImageKey) // ключ определяет определяет входное изображение
        if let output = currentFilter?.outputImage {
            if let cgImage = context.createCGImage(output, from: output.extent) {
                isChange.toggle()
                photo = UIImage(cgImage: cgImage)
            }
        }
    }
}
