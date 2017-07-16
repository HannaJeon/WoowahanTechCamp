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
        
        setGradient(context: context!)
        drawLine(context: context!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setNeedsDisplay()
    }
    
    func setGradient(context: CGContext) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colours = [setColor().cgColor, setColor().cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil)
        let start = CGPoint(x: bounds.midX, y: bounds.minY)
        let end = CGPoint(x: bounds.midX, y: bounds.maxY)
        
        context.drawLinearGradient(gradient!, start: start, end: end, options: [])
    }
    
    func setColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func drawLine(context: CGContext) {
        for _ in 0..<10 {
            let path = UIBezierPath()
            let start = CGPoint(x: Int(arc4random_uniform(UInt32(self.bounds.maxX))), y: Int(arc4random_uniform(UInt32(self.bounds.maxY))))
            let end = CGPoint(x: Int(arc4random_uniform(UInt32(self.bounds.maxX))), y: Int(arc4random_uniform(UInt32(self.bounds.maxY))))
            
            path.move(to: start)
            path.addLine(to: end)
            path.stroke()
            context.addPath(path.cgPath)
            context.setStrokeColor(setColor().cgColor)
        }
    }
    
}
