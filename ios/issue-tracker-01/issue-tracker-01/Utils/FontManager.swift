//
//  FontManager.swift
//  issue-tracker-01
//
//  Created by 조호근 on 5/9/24.
//

import UIKit

struct FontManager {
    enum Weight {
        case bold
        case semibold
        case regular
        
        var weight: UIFont.Weight {
            switch self {
            case .bold: .bold
            case .semibold: .semibold
            case .regular: .regular
            }
        }
    }
    
    enum Size {
        case xxlarge
        case xlarge
        case large
        case medium
        case small
        
        var size: CGFloat {
            switch self {
            case .xxlarge: 32
            case .xlarge: 24
            case .large: 18
            case .medium: 15
            case .small: 12
            }
        }
    }
    
    let weight: Weight
    let size: Size
    
    var font: UIFont {
        UIFont.systemFont(ofSize: size.size, weight: weight.weight)
    }
}
