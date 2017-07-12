//
//  MyRect.swift
//  MyRect
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

struct MyRect {
    private var pointA: CGPoint
    private var pointB: CGPoint
    private var pointC: CGPoint
    private var pointD: CGPoint
    
    init() {
        let initPoint = CGPoint(x: 0, y: 0)
        self.pointA = initPoint
        self.pointB = initPoint
        self.pointC = initPoint
        self.pointD = initPoint
    }
    
    init(origin: CGPoint, width: Double, height: Double) {
        self.pointA = CGPoint(x: Double(origin.x), y: height)
        self.pointB = origin
        self.pointC = CGPoint(x: width, y: Double(origin.y))
        self.pointD = CGPoint(x: width, y: height)
    }
    
    mutating func moveTo(delta: CGPoint) {
        self.pointA = CGPoint(x: pointA.x + delta.x, y: pointA.y + delta.y)
        self.pointB = CGPoint(x: pointB.x + delta.x, y: pointB.y + delta.y)
        self.pointC = CGPoint(x: pointC.x + delta.x, y: pointC.y + delta.y)
        self.pointD = CGPoint(x: pointD.x + delta.x, y: pointD.y + delta.y)
    }
}
