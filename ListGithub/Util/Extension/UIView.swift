//
//  UIView.swift
//  ListGithub
//
//  Created by Fernanda de Lima on 25/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import UIKit
extension UIView {
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        translatesAutoresizingMaskIntoConstraints = false
     
         if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
         }
         if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
         }
         if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
         }
         if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
         }
         if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
         }
         if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
         }
    }
}
