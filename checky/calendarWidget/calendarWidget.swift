//
//  calendarWidget.swift
//  calendarWidget
//
//  Created by song on 2022/11/08.
//

import WidgetKit
import SwiftUI
import Intents
import EventKit

struct Provider: IntentTimelineProvider {
  let eventManager = EventManagerForWidget()
  
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), events: [])
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), events: eventManager.getAllTaskforToday())
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, events: eventManager.getAllTaskforToday())
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let events: [EKEvent]
}

struct calendarWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack {
      Text("오늘은 \(Date().month)월 \(Date().day)일")
        .fontWeight(.bold)
        .foregroundColor(Color.basicGreen)
      VStack(spacing: 4) {
        ForEach(entry.events, id: \.eventIdentifier) { event in
          ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
              .fill(Color(cgColor: event.calendar.cgColor))
            Text(event.title)
              .foregroundColor(Color.basicWhite)
              .fontWeight(.bold)
              .padding(.horizontal, 4)
          }
          .fixedSize(horizontal: false, vertical: true)
        }
      }
      Spacer()
    }
    .padding(.vertical, 10)
    .padding(.horizontal, 10)
  }
}

@main
struct calendarWidget: Widget {
  let kind: String = "calendarWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      calendarWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("오늘 목록")
    .description("This is an example widget.")
  }
}

struct calendarWidget_Previews: PreviewProvider {
  static var previews: some View {
    calendarWidgetEntryView(entry: SimpleEntry(date: Date(), events: []))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}




struct EventManagerForWidget  {
  var store: EKEventStore
  var calendar: Calendar

  init(store: EKEventStore = EKEventStore(),
       calendar: Calendar = Calendar(identifier: .gregorian)) {
    self.store = store
    self.calendar = calendar
  }
  
  // 오늘 이벤트 받아 오는 메서드
  func getAllTaskforToday(date: Date = Date()) -> [EKEvent] {
    
    let categories = store.calendars(for: .event)
    
    var list: [EKEvent] = []
    
    for category in categories {
      let predicate = store.predicateForEvents(withStart: date, end: date, calendars: [category])
      let eventList = store.events(matching: predicate)
      list.append(contentsOf: eventList)
    }
    
    return list
  }
  
}

extension View {
  func fetchUserDefaultColor(calendarIdentifier: String) -> Color {
    guard let colorComponent = UserDefaults.standard.object(forKey: ("\(calendarIdentifier)_color")) as? [CGFloat] else {
      return Color.white
    }
    
   return  Color(.sRGB, red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], opacity: colorComponent[3])
  }
}
