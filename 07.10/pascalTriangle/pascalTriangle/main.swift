//
//  main.swift
//  pascalTriangle
//
//  Created by woowabrothers on 2017. 7. 10..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

func makePascalTriangle(numOfRows : Int) -> ([[Int]]) {
    var array = [[Int]]()
    
    for i in 0..<numOfRows {
        var inner = [Int]()
        
        for j in 0...i {
            if j == 0 || j == i {
                inner.append(1)
            } else {
                let val = array[i-1][j] + array[i-1][j-1]
                inner.append(val)
            }
        }
        array.append(inner)
    }
    
    return array
}

func makePascalTriangle1(numOfRows: Int, result: [[Int]]) -> ([[Int]]) {
    if numOfRows == 1 {
        return result
    } else {
        let value = result.last!
        let line = zip(value+[0], [0]+value).map{ $0 + $1 }
        return makePascalTriangle1(numOfRows: numOfRows-1, result: result + [line])
    }
}

let result = makePascalTriangle1(numOfRows: 5, result: [[1]])
print(result)

for arg in CommandLine.arguments {
    if let input = Int(arg) {
        let triangle = makePascalTriangle(numOfRows: input)
        print(triangle)
        
        var ouputString = "[\n"
        
        for val in triangle {
            ouputString += "\(val),\n"
        }
        ouputString += "]"
        print(ouputString)
    }
}

