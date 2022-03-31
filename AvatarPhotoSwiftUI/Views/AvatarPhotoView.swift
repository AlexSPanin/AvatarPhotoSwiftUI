//
//  AvatarPhotoView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

struct AvatarPhotoView: View {
    
    @StateObject var viewModel = AvatarPhotoViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            UpperButtonsPhotoView(viewModel: viewModel)
            ScrollPhotoView(viewModel: viewModel)
            LowerButtonsPhotoView(viewModel: viewModel)
            Spacer()
        }
    }
}

struct AvatarPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPhotoView()
    }
}
