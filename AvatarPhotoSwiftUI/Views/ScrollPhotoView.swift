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
            Image(uiImage: viewModel.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.customRed, lineWidth: 3)
                }
                .shadow(color: .sh_darkGrey, radius: 0, x: 0, y: 1)
        }
        .padding(2)
        .sheet(isPresented: $viewModel.isImagePickerDisplay, onDismiss: chagePhoto) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: viewModel.sourceType)
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



struct ScrollPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPhotoView(viewModel: AvatarPhotoViewModel())
    }
}
