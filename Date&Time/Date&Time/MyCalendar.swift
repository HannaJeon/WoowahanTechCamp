//
//  MyCalendar.swift
//  Date&Time
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class MyCalendar {
    private let date = Date()
    private let cal = Calendar.current
    private let formatter = DateFormatter()
    
// • 오늘날짜의년,월,일,시,분,초Int를튜플로묶어서리턴하는함수
    func today() -> (Int, Int, Int, Int, Int, Int) {
        let today = (year: cal.component(.year, from: date),
                     month: cal.component(.month, from: date),
                     day: cal.component(.day, from: date),
                     hour: cal.component(.hour, from: date),
                     minute: cal.component(.minute, from: date),
                     second: cal.component(.second, from: date))
        return today
    }
    
// • 년월일 날짜를 문자열로 입력하면 Date 인스턴스를 리턴하는 함수
    func stringToDate(date: String) -> Date? {
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: date)
        return date
    }
    
// • 특정 년도, 월, 일을 Int로 입력하면 Date 인스턴스를 리턴하는 함수
    func intToDate(date: (Int, Int, Int)) -> Date? {
        let components = DateComponents(calendar: cal, year: date.0, month: date.1, day: date.2)
        let date = components.date
        return date
    }
    
// • 날짜 Date 인스턴스를 입력하면 한국식 날짜 표기로 문자열을 리턴하는 함수
    func dateToKoreanDate(date: Date) -> String {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        let date = formatter.string(from: date)
        
        return date
    }
    
// • 특정 년도와 특정 달을 입력하면 1일의 요일을 찾는 함수
    func findFirstDay(year: Int, month: Int, dateFormat: String) -> String {
        let components = DateComponents(calendar: cal, year: year, month: month, day: 1)
        let date = components.date
        formatter.dateFormat = dateFormat
        if let unwarpDate = date {
            return formatter.string(from: unwarpDate)
        }
        return String()
    }
    
// • 특정 년도와 특정 달을 입력하면 일자를 주단위로 배열에 넣고, 주단위 배열을 다시 배열에 넣어 2차원 배열로 리턴하는 함수
    func makeWeekArray(year: Int, month: Int) -> [[Int]] {
        formatter.dateFormat = "ee"
        let nextMonth = DateComponents(calendar: cal, year: year, month: month+1, day: 0)
        let nextMonthDate = nextMonth.date
        var currentDate = Date()
        
        var result = [[Int]]()
        var temp = [Int]()
        var count = 1

        while currentDate != nextMonthDate {
            temp.append(count)
            
            let currentMonth = DateComponents(calendar: cal, year: year, month: month, day: count)
            currentDate = currentMonth.date ?? Date()
            let day = formatter.string(from: currentDate)
            
            if day == "07" || currentDate == nextMonthDate {
                result.append(temp)
                temp = [Int]()
            }
            count += 1
        }
        return result
    }
    
}
