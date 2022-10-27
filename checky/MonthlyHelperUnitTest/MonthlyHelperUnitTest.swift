//
//  checkyTests.swift
//  checkyTests
//
//  Created by song on 2022/10/27.
//

import XCTest
@testable import checky


final class MonthlyCalendarHelper: XCTestCase {
  
  var sut: MonthyCalendarHelper!
  override func setUpWithError() throws {
    sut = MonthyCalendarHelper()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_오늘날자를_입력하였을때_saveDaysOfCurrentMonth메서드를_호출하면_data의_값이_4인지() {
    //given
    let today = Date()
    
    //when
    let previousDates = sut.saveDaysOfCurrentMonth(today)
    
    //then
    XCTAssertEqual(previousDates.count , 31)
  }
  
  func test_오늘날자를_입력하였을때_saveDaysOfCurrentMonth메서드를_호출하고_이번달의첫째날의_data_값이_1인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    
    //when
    guard let firstDayOfMonth = days.first else {
      return
    }
    
    //then
    XCTAssertEqual(firstDayOfMonth.date.day , "1")
  }
  
  func test_오늘날자를_입력하였을때_saveDaysOfCurrentMonth메서드를_호출하고_이번달의마지막의_data_값이_31인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    
    //when
    guard let lastDayOfMonth = days.last else {
      return
    }
    
    //then
    XCTAssertEqual(lastDayOfMonth.date.day , "31")
  }
  
  func test_이달의_첫날을_구하여_previousDates메서드를_호출하면_previousDates의_count가_6인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    guard let firstDayOfMonth = days.first else {
      return
    }
    
    //when
    let previousDates = sut.previousDates(currentday: firstDayOfMonth)
    
    //then
    XCTAssertEqual(previousDates.count , 6)
  }
  
  func test_이달의_마지막날을_구하여_nextDates메서드를_호출하면_nextDates의_count가_5인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    guard let lastDayOfMonth = days.last else {
      return
    }
    
    //when
    let previousDates = sut.nextDates(currentday: lastDayOfMonth)
    
    //then
    XCTAssertEqual(previousDates.count , 5)
  }
  
  func test_이달의_마지막날을_구하여_nextDates메서드를_호출하면_nextDates의_iscurrent가_false인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    guard let lastDayOfMonth = days.last else {
      return
    }
    let previousDates = sut.nextDates(currentday: lastDayOfMonth)
    
    //when
    let isCurrentMonth = previousDates.first?.isCurrentMonth
    
    //then
    XCTAssertEqual(isCurrentMonth , false)
  }
  
  func test_이달의_첫날을_구하여_previousDates메서드를_호출하면_previousDates의_isCurrent가_false인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    guard let firstDayOfMonth = days.first else {
      return
    }
    let previousDates = sut.previousDates(currentday: firstDayOfMonth)
    
    //when
    let isCurrentMonth = previousDates.first?.isCurrentMonth
    
    //then
    XCTAssertEqual(isCurrentMonth, false)
  }
  
  func test_오늘날자를_입력하였을때_saveDaysOfCurrentMonth메서드를_호출하고_이번달의_data의_isCurrent_true인지() {
    //given
    let today = Date()
    let days = sut.saveDaysOfCurrentMonth(today)
    
    //when
    let currentDay = days.first?.isCurrentMonth
    
    //then
    XCTAssertEqual(currentDay, true)
  }
  
  func test_오늘날자를_입력하고을때_plusDate메서드를_호출하면_다음달의_dates의_count값이_30인지() {
    //given
    var today = Date()
    today = sut.plusDate(today)
    let days = sut.saveDaysOfCurrentMonth(today)
    
    //when
    let nextDaysCount = days.count
    
    //then
    XCTAssertEqual(nextDaysCount, 30)
  }
  
  func test_오늘날자를_입력하고을때_minusDate메서드를_호출하면_이전달의_dates의_count값이_30인지() {
    //given
    var today = Date()
    today = sut.minusDate(today)
    let days = sut.saveDaysOfCurrentMonth(today)
    
    //when
    let nextDaysCount = days.count
    
    //then
    XCTAssertEqual(nextDaysCount, 30)
  }
}
