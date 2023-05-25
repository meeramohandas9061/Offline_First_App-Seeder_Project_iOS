//
//  Fonts.swift
//  Offline-First-App-Seeder-Project
//
//  Created by Meera Mohandas on 03/05/23.
//

import Foundation
import UIKit

//Add any custom fonts here
enum CustomFonts: String {
     case regular   =     "Sample-Regular"
     case bold      =     "Sample-Bold"
     case semibold  =     "Sample-SemiBold"
     case extrabold =     "Sample-Thin"
}

extension CustomFonts {
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
