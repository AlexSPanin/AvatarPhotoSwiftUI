//
//  ImageScrollView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 01.04.2022.
//

import SwiftUI

struct ImageScrollView: UIViewRepresentable {
    
    @ObservedObject var viewModel: AvatarPhotoViewModel
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    var scrollSize: CGSize
    
    func makeUIView(context: Context) -> UIScrollView {
        scrollView.frame = CGRect(x: (Screen.width - scrollSize.width) / 2,
                              y: (Screen.height - scrollSize.height) / 2,
                              width: scrollSize.width,
                              height: scrollSize.height)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        scrollView.delegate = context.coordinator
        scrollView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        return scrollView
    }
    
    func setMinimumZoom() {
        guard let image = viewModel.photo else { return }
        scrollView.contentSize = image.size
        scrollView.minimumZoomScale = setZoomScale(boundsSize: scrollSize, imageSize: image.size).minScale
        scrollView.maximumZoomScale = setZoomScale(boundsSize: scrollSize, imageSize: image.size).maxScale
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        guard let image = viewModel.photo else { return }
        context.coordinator.scroll.imageView.image = image
        imageView.sizeToFit()
        setMinimumZoom()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator (scroll: self)
    }
    
    func setZoomScale(boundsSize: CGSize, imageSize: CGSize) -> (minScale: CGFloat, maxScale: CGFloat){
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        let maxScale: CGFloat = max(0.5, minScale)
        return (minScale, maxScale)
    }
    
    func positionImage(scrollSize: CGSize, imageFrame: CGRect ) -> CGRect {
        let boundsSize = scrollSize
        var frameToCenter = imageFrame
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
      return frameToCenter
    }
}

extension ImageScrollView {
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var scroll: ImageScrollView
        lazy var zoomingTap: UITapGestureRecognizer = {
            let zoom = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
            zoom.numberOfTapsRequired = 2
            return zoom
        }()
        
        init(scroll: ImageScrollView) {
            self.scroll = scroll
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            scroll.imageView.addGestureRecognizer(zoomingTap)
            return scroll.imageView
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            print("Did Zoom")
            scroll.imageView.frame = scroll.positionImage(scrollSize: scroll.scrollSize, imageFrame: scroll.imageView.frame)
            let width: CGFloat = scrollView.bounds.width / scrollView.zoomScale
            let height: CGFloat = scrollView.bounds.height / scrollView.zoomScale
            let x = scrollView.bounds.origin.x / scrollView.zoomScale
            let y = scrollView.bounds.origin.y / scrollView.zoomScale
            
            let cgRect = CGRect(x: x,
                                y: y,
                                width: width,
                                height: height)
            
            scroll.viewModel.frameCGRect = cgRect
        }
        
        @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
            let location = sender.location(in: sender.view)
            let currectScale = scroll.scrollView.zoomScale
            let minScale = scroll.scrollView.minimumZoomScale
            let maxScale = scroll.scrollView.maximumZoomScale
            
            var zoomRect = CGRect.zero
            
            if (minScale == maxScale && minScale > 1) { return }
            let toScale = maxScale
            let finalScale = (currectScale == minScale ) ? toScale : minScale
            
            let bounds = scroll.scrollView.bounds
            
            zoomRect.size.width = bounds.size.width / finalScale
            zoomRect.size.height = bounds.size.height / finalScale
            
            zoomRect.origin.x = location.x - (zoomRect.size.width / 2)
            zoomRect.origin.y = location.y - (zoomRect.size.height / 2)
            
            scroll.scrollView.zoom(to: zoomRect, animated: true)
        }
    }
}


