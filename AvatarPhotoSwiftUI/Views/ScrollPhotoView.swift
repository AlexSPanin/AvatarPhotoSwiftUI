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
    private let scrollSize: CGSize = CGSize(width: 200, height: 300)
    
    var body: some View {
        ZStack {
            if viewModel.photo != nil {
                ZStack {
                    ImageScrollView(viewModel: viewModel, scrollSize: scrollSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5).stroke( Color.red, lineWidth: 4)
                        )
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
            RoundedRectangle(cornerRadius: 5).stroke( Color.red, lineWidth: 4)
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
    }
}



//struct ScrollPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollPhotoView(viewModel: AvatarPhotoViewModel())
//    }
//}
