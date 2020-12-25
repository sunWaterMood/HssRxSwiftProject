//
//  Foundation+HssRxSwiftProject.swift
//  HssRxSwiftProject
//
//  Created by sy on 2020/12/24.
//

import Foundation
import UIKit

extension String{
    // 富文本设置 字体大小 行间距 字间距
        func attributedString(font: UIFont, textColor: UIColor, lineSpaceing: CGFloat, wordSpaceing: CGFloat) -> NSAttributedString {
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpaceing
            let attributes = [
                    NSAttributedString.Key.font             : font,
                    NSAttributedString.Key.foregroundColor  : textColor,
                    NSAttributedString.Key.paragraphStyle   : style,
                    NSAttributedString.Key.kern             : wordSpaceing]
                as [NSAttributedString.Key : Any]
            let attrStr = NSMutableAttributedString.init(string: self, attributes: attributes)
            return attrStr
        }
}
