//
//  main.swift
//  MyRect
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

let rect1 = MyRect()
print(rect1)

let origin = CGPoint(x: 4.5, y: 3.5)
var rect2 = MyRect(origin: origin, width: 15, height: 10.5)
print(rect2)

rect2.moveTo(delta: CGPoint(x: -3, y: 1.5))
print(rect2)
