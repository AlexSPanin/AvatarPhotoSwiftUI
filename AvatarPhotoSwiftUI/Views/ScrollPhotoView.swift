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
            Image(uiImage: selectedImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5).stroke(Color.customRed, lineWidth: 3)
                }
                .shadow(color: .sh_darkGrey, radius: 0, x: 0, y: 1)
        }
        . padding(2)
        .sheet(isPresented: $viewModel.isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: viewModel.sourceType)
                    }
    }
}

struct ScrollPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPhotoView(viewModel: AvatarPhotoViewModel())
    }
}
