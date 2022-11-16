//
//  checkyWidget.swift
//  checkyWidget
//
//  Created by RED on 2022/11/15.
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
      Text("오늘은 \(entry.date.month)월 \(entry.date.day)일")
        .fontWeight(.bold)
        .foregroundColor(Color.fontBlack)
      VStack(spacing: 4) {
        if entry.events.count != 0 {
          ForEach(entry.events, id: \.eventIdentifier) { event in
            ZStack(alignment: .leading) {
              RoundedRectangle(cornerRadius: 4)
                .fill(fetchUserDefaultColor(calendar: event.calendar))
              Text(event.title)
                .foregroundColor(Color.basicWhite)
                .fontWeight(.bold)
                .padding(.horizontal, 4)
            }
            .fixedSize(horizontal: false, vertical: true)
          }
        } else {
          Text("오늘은 일정이 없어요!")
            .font(.caption)
            .foregroundColor(Color.fontMediumGray)
            .frame(height: 50)
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
    .description("오늘 할일 목록을 보여주는 위젯입니다")
    .supportedFamilies([.systemSmall])
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
  
  func getAllTaskforToday(date: Date = Date()) -> [EKEvent] {
    let categories = store.calendars(for: .event)
    
    var list: [EKEvent] = []
    
    guard let startDate = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return [] }
    guard let endDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { return [] }
    
    for category in categories {
      let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: [category])
      let eventList = store.events(matching: predicate)
      list.append(contentsOf: eventList.filter { $0.startDate.day == date.day || $0.endDate.day == date.day })
    }
    
    return list
  }
}

extension View {
  func fetchUserDefaultColor(calendar: EKCalendar) -> Color {
    
    guard let colorComponent = UserDefaults.shared.object(forKey: ("\(calendar.calendarIdentifier)_color")) as? [CGFloat] else {
      return Color(cgColor: calendar.cgColor)
    }
    
   return  Color(.sRGB, red: colorComponent[0], green: colorComponent[1], blue: colorComponent[2], opacity: colorComponent[3])
  }
}

extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        let appGroupId = "group.checky.red.taeangel"
        combined.addSuite(named: appGroupId)
        return combined
    }
}
