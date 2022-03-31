//
//  LowerButtonsPhotoView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

struct LowerButtonsPhotoView: View {
    @ObservedObject var viewModel: AvatarPhotoViewModel
    var body: some View {
        HStack(spacing: 70) {
            ForEach(viewModel.lowerButtons, id: \.self) { button in
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
//
//struct LowerButtonsPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        LowerButtonsPhotoView(viewModel: AvatarPhotoViewModel())
//    }
//}
