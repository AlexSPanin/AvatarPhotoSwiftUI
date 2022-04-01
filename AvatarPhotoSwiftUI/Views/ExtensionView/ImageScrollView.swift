//
//  ImageScrollView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 01.04.2022.
//

import SwiftUI

struct ImageScrollView: UIViewRepresentable {
    var imageView: UIImageView

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = CGRect(x: (Screen.width - 200) / 2,
                              y: (Screen.height - 300) / 2,
                              width: 200,
                              height: 300)
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        scroll.decelerationRate = UIScrollView.DecelerationRate.normal
        return scroll
    }()
   
    
   func makeUIView(context: Context) -> UIScrollView {
        scrollView.delegate = context.coordinator
        scrollView.zoomScale = 1.0
        scrollView.addSubview(imageView)

        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
       
        uiView.addSubview(imageView)
        uiView.contentSize = imageView.bounds.size

        let boundsSize = scrollView.bounds.size
        
        var frameToCenter = imageView.frame

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        // если размеры ширины view при зум меньше ширины экрана то view вписывается в ширику экрана
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
       
       
        // присваиваем новый frame
        imageView.frame = frameToCenter
        print(boundsSize, uiView.contentSize, imageView.frame)
        
    }
    
  
    func makeCoordinator() -> Coordinator {
        print("Coordinator")
        return Coordinator(imageView: imageView)
    }
}

extension ImageScrollView {
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var imageView: UIImageView
        
        init(imageView: UIImageView) {
            self.imageView = imageView
        }
        
        
    }
    
}


