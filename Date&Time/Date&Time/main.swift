//
//  main.swift
//  Date&Time
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

let myCalendar = MyCalendar()

let today = myCalendar.today()
print("\(today.0)년 \(today.1)월 \(today.2)일\n\(today.3)시 \(today.4)분 \(today.5)초\n")

let stringToDate = myCalendar.stringToDate(date: "2016/04/16")
if let date = stringToDate {
    print(myCalendar.dateToKoreanDate(date: date))
}

let intToDate = myCalendar.intToDate(date: (1998, 12, 25))
if let date = intToDate {
    let dateToKorean = myCalendar.dateToKoreanDate(date: date)
    print(dateToKorean)
}

let findFirstDay = myCalendar.findFirstDay(year: 2017, month: 7, dateFormat: "EEEE")
print(findFirstDay)

let weekArray = myCalendar.makeWeekArray(year: 2010, month: 4)
print(weekArray)
