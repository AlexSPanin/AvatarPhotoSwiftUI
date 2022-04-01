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
    
    var body: some View {
        ZStack {
            ImageScrollView(imageView: UIImageView(image:  viewModel.photo))
            .frame(width: 200, height: 300)
            .cornerRadius(10)
            .sheet(isPresented: $viewModel.isImagePickerDisplay, onDismiss: chagePhoto) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: viewModel.sourceType)
        }
        
        }
    }
}

extension ScrollPhotoView {
    private func chagePhoto() {
        guard let image = selectedImage else { return }
            viewModel.isChange.toggle()
            viewModel.photo = image
    }
}



//struct ScrollPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollPhotoView(viewModel: AvatarPhotoViewModel())
//    }
//}
