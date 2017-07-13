//
//  MyView.swift
//  DrawRect
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class MyView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colours = [UIColor.red.cgColor, UIColor.blue.cgColor] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil)
        let start = CGPoint(x: bounds.midX, y: bounds.minY)
        let end = CGPoint(x: bounds.midX, y: bounds.maxY)
        
        context?.drawLinearGradient(gradient!, start: start, end: end, options: [])
    }
}
