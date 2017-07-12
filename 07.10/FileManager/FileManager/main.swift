//
//  main.swift
//  FileManager
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

let path = "/Library/Desktop Pictures"
let contents = MissionController().findContents(path: path)
print(contents)

let allContents = MissionController().findContentsOfRoot(path: path)
print(allContents)
