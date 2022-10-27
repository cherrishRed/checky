//
//  WeeklyCalendarHelperTest.swift
//  checkyTests
//
//  Created by RED on 2022/10/27.
//

import XCTest
@testable import checky

final class WeeklyCalendarHelperTest: XCTestCase {
  var sut: WeeklyCalendarHelper!

    override func setUpWithError() throws {
      sut = WeeklyCalendarHelper(calendar: Calendar(identifier: .gregorian), weekOption: .KoreanShort, startingWeek: .sunday)
    }

    override func tearDownWithError() throws {
      sut = nil
    }

    func test_plusDate_10월10일로_호출시_10월17일을_반환하는지() {
      // given
      let formatter = DateFormatter()
      let dateString = "2022년 10월 10일"
      formatter.dateFormat = "yyyy년 MM월 dd일"
      let date = formatter.date(from: dateString)!
      
      let expectDateString = "2022년 10월 17일"
      let expectDate = formatter.date(from: expectDateString)!
      
      // when
      let result = sut.plusDate(date)
      // then
      XCTAssertEqual(result, expectDate)
    }
  
  func test_minusDate_10월10일로_호출시_10월3일을_반환하는지() {
    // given
    let formatter = DateFormatter()
    let dateString = "2022년 10월 10일"
    formatter.dateFormat = "yyyy년 MM월 dd일"
    let date = formatter.date(from: dateString)!
    
    let expectDateString = "2022년 10월 3일"
    let expectDate = formatter.date(from: expectDateString)!
    
    // when
    let result = sut.minusDate(date)
    // then
    XCTAssertEqual(result, expectDate)
  }
  
  func test_extractDates_2022년9월8일로_호출시_7일을_잘_반환하는지() {
    // given
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일"
    
    let preDayString1 = "2022년 9월 4일"
    let preDay1 = formatter.date(from: preDayString1)!
    
    let preDayString2 = "2022년 9월 5일"
    let preDay2 = formatter.date(from: preDayString2)!
    
    let preDayString3 = "2022년 9월 6일"
    let preDay3 = formatter.date(from: preDayString3)!
    
    let preDayString4 = "2022년 9월 7일"
    let preDay4 = formatter.date(from: preDayString4)!
    
    let todayString = "2022년 9월 8일"
    let today = formatter.date(from: todayString)!
    
    let nextDayString1 = "2022년 9월 9일"
    let nextDay1 = formatter.date(from: nextDayString1)!
    
    let nextDayString2 = "2022년 9월 10일"
    let nextDay2 = formatter.date(from: nextDayString2)!
    
    let expectResult: [DateValue] = [DateValue(date: preDay1),
                                     DateValue(date: preDay2),
                                     DateValue(date: preDay3),
                                     DateValue(date: preDay4),
                                     DateValue(date: today),
                                     DateValue(date: nextDay1),
                                     DateValue(date: nextDay2)]
    //when
    let result = sut.extractDates(today)
    // then
    XCTAssertEqual(result.first?.date, expectResult.first?.date)
    XCTAssertEqual(result.last?.date, expectResult.last?.date)
  }
}
