//
//  ExtensionView.swift
//  AvatarPhotoSwiftUI
//
//  Created by Александр Панин on 31.03.2022.
//

import SwiftUI

extension Color {
    
    static let customRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    static let sh_basicRed = Color(#colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1))
    
    static let sh_darkRed = Color(#colorLiteral(red: 0.7529411765, green: 0.1098039216, blue: 0.09411764706, alpha: 1))
    static let sh_lightRed = Color(#colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1))
    
    static let customGray = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    static let sh_basicGrey = Color(#colorLiteral(red: 0.3137254902, green: 0.3333333333, blue: 0.3607843137, alpha: 1))
    
    static let sh_darkGrey = Color(#colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1))
    
    static let customLightGray = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    static let sh_Grey = Color(#colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1))
    
    static let sh_lightGrey = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 1))
    
    static let sh_colorFrame = Color(#colorLiteral(red: 0.937254902, green: 0.9333333333, blue: 0.9333333333, alpha: 0.4492752378))
    
        }
// MARK: - расширение для UIImage функция поворота
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        return self
    }
}
