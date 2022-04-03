//
//  ScrollPhotoView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

struct ScrollPhotoView: View {
    
    @ObservedObject var viewModel: AvatarPhotoViewModel
    @State private var selectedImage: UIImage?
    @State private var frameCGRect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize.zero)
    private let scrollSize: CGSize = CGSize(width: 200, height: 300)
    
    var body: some View {
        ZStack {
            if selectedImage != nil {
                ZStack {
                    ImageScrollView(sizeFrame: $frameCGRect, image: viewModel.photo, sizeScroll: scrollSize)
            }
            } else {
                ZStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: scrollSize.width, height: scrollSize.height)
                }
            }
        }
        .frame(width: scrollSize.width, height: scrollSize.height)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke( Color.red, lineWidth: 2)
        )
        .sheet(isPresented: $viewModel.isImagePickerDisplay, onDismiss: chagePhoto) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: viewModel.sourceType)
        }
        
    }
}


extension ScrollPhotoView {
    private func chagePhoto() {
        guard let image = selectedImage else { return }
        viewModel.photo = viewModel.imageFilter(image)
        viewModel.sizeFrame = viewModel.photo.size
    }
}



//struct ScrollPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollPhotoView(viewModel: AvatarPhotoViewModel())
//    }
//}
