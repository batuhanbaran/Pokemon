//
//  MainFont.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import UIKit

enum MainFont: GenericValueProtocol {
    
    typealias Value = UIFont?
    
    case black(CGFloat)
    case blackItalic(CGFloat)
    case bold(CGFloat)
    case boldItalic(CGFloat)
    case italic(CGFloat)
    case light(CGFloat)
    case lightItalic(CGFloat)
    case medium(CGFloat)
    case mediumItalic(CGFloat)
    case regular(CGFloat)
    case thin(CGFloat)
    case thinItalic(CGFloat)
    
    var value: UIFont? {
        switch self {
        case .black(let size):
            return UIFont(name:"Roboto-Black", size: size)
        case .blackItalic(let size):
            return UIFont(name:"Roboto-BlackItalic", size: size)
        case .bold(let size):
            return UIFont(name:"Roboto-Bold", size: size)
        case .boldItalic(let size):
            return UIFont(name:"Roboto-BoldItalic", size: size)
        case .italic(let size):
            return UIFont(name:"Roboto-Italic", size: size)
        case .light(let size):
            return UIFont(name:"Roboto-Light", size: size)
        case .lightItalic(let size):
            return UIFont(name:"Roboto-LightItalic", size: size)
        case .medium(let size):
            return UIFont(name:"Roboto-Medium", size: size)
        case .mediumItalic(let size):
            return UIFont(name:"Roboto-MediumItalic", size: size)
        case .regular(let size):
            return UIFont(name:"Roboto-Regular", size: size)
        case .thin(let size):
            return UIFont(name:"Roboto-Thin", size: size)
        case .thinItalic(let size):
            return UIFont(name:"Roboto-ThinItalic", size: size)
        }
    }
    
}
