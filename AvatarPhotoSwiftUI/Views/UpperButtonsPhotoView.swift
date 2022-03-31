//
//  UpperButtonsPhotoView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

struct UpperButtonsPhotoView: View {
    @ObservedObject var viewModel: AvatarPhotoViewModel
    var body: some View {
        HStack(spacing: 150) {
            ForEach(viewModel.upperButtons, id: \.self) { button in
                Button {
                    viewModel.typePressButton = button.type
                } label: {
                    Image(systemName: button.nameImage)
                        .foregroundColor(Color.customRed)
                }
            }
        } .padding(2)
            .background(Color.white)
    }
}
//
//struct UpperButtonsPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpperButtonsPhotoView(viewModel: AvatarPhotoViewModel())
//    }
//}
