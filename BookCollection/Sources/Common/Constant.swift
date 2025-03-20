//
//  Constant.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import Foundation
import UIKit

extension UIScreen {
    public static let screenWidth = UIScreen.main.bounds.width
    public static let screenHeight = UIScreen.main.bounds.height
    
    public static var navigationHeight: CGFloat {
        return UIScreen.statusBarHeight + 44
    }
    
    public static var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 20
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            statusBarHeight = window?.safeAreaInsets.top ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    public static let fourInchPhoneWidth: CGFloat = 320
}

extension UIDevice {
    public func isiPhoneX() -> Bool {
        let window = UIApplication.shared.windows.first
        if window?.safeAreaInsets.top  ?? 0 > 20 {
            return true
        } else {
            return false
        }
    }
    
}

extension UIColor: NamespaceProtocol {}
extension NamespaceWrapper where WrappedType == UIColor {
    public static let mainBlack = UIColor(rgba: "#333333")
    public static let minorBlack = UIColor(rgba: "#999999")
    public static let orange = UIColor(rgba: "#DF912B")
    public static let shadowColor = UIColor(rgba: "#CCCCCC")
    public static let separateColor = UIColor(rgba: "#D9DADC")
    public static let mainFontBlack = UIColor(rgba: "#1F1F1F")
    public static let minorFontBlack = UIColor(rgba: "#353535")
    public static let minorFontLightBlack = UIColor(rgba: "#838383")
    public static let backgroundColor = UIColor(rgba: "#EDF0F4")
}

