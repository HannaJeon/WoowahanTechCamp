//
//  Extension.swift
//  StringExtension
//
//  Created by HannaJeon on 2017. 7. 17..
//  Copyright © 2017년 HannaJeon. All rights reserved.
//

import Foundation

extension String {
    func filterHangulWord() -> [String] {
        var koreanString = String()
        
        for character in self.unicodeScalars {
            if character >= "ㄱ".unicodeScalars.first! {
                koreanString += String(character)
            } else {
                koreanString += "-"
            }
        }
        
        return koreanString.components(separatedBy: "-").filter{ $0 != "" }
    }
}
