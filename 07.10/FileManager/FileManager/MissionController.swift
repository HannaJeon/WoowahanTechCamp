//
//  FileManager.swift
//  FileManager
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class MissionController {
    func findContents(path: String) -> [String] {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
            return contents
        } catch {
            return [String]()
        }
    }
    
    func findContentsOfRoot(path: String) -> [String] {
        do {
            let contents = try FileManager.default.subpathsOfDirectory(atPath: path)
            return contents
        } catch {
            return [String]()
        }
    }
}
