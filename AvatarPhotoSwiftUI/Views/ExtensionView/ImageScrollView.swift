//
//  ImageScrollView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 01.04.2022.
//

import SwiftUI

struct ImageScrollView: UIViewRepresentable {
    
    @Binding var sizeFrame: CGRect
    
    var image: UIImage
    var sizeScroll: CGSize
    let imageView: UIImageView = UIImageView()
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
        print("Make")
        
        scrollView.delegate = context.coordinator
        imageView.image = image
        imageView.sizeToFit()
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        
        
        scrollView.minimumZoomScale = setZoomScale(boundsSize: sizeScroll, imageSize: image.size).minScale
        scrollView.maximumZoomScale = setZoomScale(boundsSize: sizeScroll, imageSize: image.size).maxScale
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        imageView.frame = positionImage(scrollSize: sizeScroll, imageFrame: imageView.frame)
        
        
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        print("Update")
        imageView.removeFromSuperview()
        imageView.image = image
        imageView.sizeToFit()
        uiView.addSubview(imageView)
        uiView.contentSize = imageView.bounds.size
        uiView.minimumZoomScale = setZoomScale(boundsSize: sizeScroll, imageSize: image.size).minScale
        uiView.maximumZoomScale = setZoomScale(boundsSize: sizeScroll, imageSize: image.size).maxScale
        uiView.zoomScale = uiView.minimumZoomScale
        imageView.frame = positionImage(scrollSize: sizeScroll, imageFrame: imageView.frame)
        sizeFrame = imageView.frame
        
        
       
        
 //       positionImage(uiView)
// print( uiView.zoomScale, uiView.minimumZoomScale, uiView.contentSize, imageView.frame)
        
    }
    
  
    func makeCoordinator() -> Coordinator {
       Coordinator(scroll: self)
    }
    
    func setZoomScale(boundsSize: CGSize, imageSize: CGSize) -> (minScale: CGFloat, maxScale: CGFloat){
        print("Set")
        // вычисляем соотношения экранов по x и y
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        // определяем минимальный и максимальный зум
        let minScale = min(xScale, yScale)
        let maxScale: CGFloat = max(0.5, minScale)
        // задаем параметры минимального и максимального зума
//        scrollView.minimumZoomScale = minScale
//        scrollView.maximumZoomScale = maxScale
//        scrollView.zoomScale = minScale
        
// imageView.removeFromSuperview()
        print("After Zoom")
        print(boundsSize, imageSize, Int(xScale), Int(yScale), imageView.frame)
        
        return (minScale, maxScale)
    }
    
    func positionImage(scrollSize: CGSize, imageFrame: CGRect ) -> CGRect {
     print("Position")
        let boundsSize = scrollSize
        
        var frameToCenter = imageFrame
     
        // если размеры высоты view при зум меньше ширины экрана то view вписывается в ширику экрана
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
      return frameToCenter
        // присваиваем новый frame
  //      imageView.frame = frameToCenter
  //    print(boundsSize, frameToCenter)
    }
    
    
    
    
    
    
    
}

extension ImageScrollView {
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var scroll: ImageScrollView
        
        init(scroll: ImageScrollView) {
            self.scroll = scroll
        }
       
        // Запрашивает делегата о масштабировании вида при приближении масштабирования на виде прокрутки.
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            print("ForZooming")
            return scroll.imageView
        }
        // Сообщает делегату, что коэффициент масштабирования вида прокрутки изменился.
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
 //           scroll.positionImage(scrollSize: scroll.sizeScroll, imageFrame: scroll.sizeFrame)
        }
    }
    
}


