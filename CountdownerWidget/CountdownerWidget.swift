//
//  CountdownerWidget.swift
//  CountdownerWidget
//
//  Created by shmeelok chakraborty on 1/5/25.
//

import WidgetKit
import SwiftUI
import Foundation


struct Countdown: Codable, Identifiable {
    let id: String
    var name: String
    var description: String?
    var date: Date
    
    init(name: String, description: String? = nil, date: Date? = nil, id: String = UUID().uuidString) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date ?? Countdown.defaultDate()
    }
    
    static func defaultDate() -> Date {
        // Set the default time to 11:59 PM of the current day
        let calendar = Calendar.current
        let now = Date()
        let components = DateComponents(year: calendar.component(.year, from: now),
                                         month: calendar.component(.month, from: now),
                                         day: calendar.component(.day, from: now),
                                         hour: 23,
                                         minute: 59)
        return calendar.date(from: components) ?? now
    }
}

struct CountdownEntry: TimelineEntry {
    var date: Date = Date()
    var countdowns: [Countdown]
}


func fetchCountdownsFromSharedDefaults() -> [Countdown] {
    if let sharedDefaults = UserDefaults(suiteName: APP_GROUP_NAME),
       let data = sharedDefaults.data(forKey: "countdowns") {
        do {
            let countdowns = try JSONDecoder().decode([Countdown].self, from: data)
            return countdowns
        } catch {
            print("Failed to decode count downs: \(error)")
        }
    }
    return []
}


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CountdownEntry {
        CountdownEntry(countdowns: [])
    }

//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
    
    func getSnapshot(in context: Context, completion: @escaping (CountdownEntry) -> Void) {
        let entry = CountdownEntry(countdowns: [Countdown(name: "Assignment")])
        completion(entry)
    }
    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        return Timeline(entries: entries, policy: .atEnd)
//    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CountdownEntry>) -> Void) {
//        var entries: [SimpleEntry] = []
//        
//        for _ in 0 ..< 5 {
//            let entry = SimpleEntry(date: Date())
//            entries.append(entry)
//        }
//        
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
       let countdowns = fetchCountdownsFromSharedDefaults()
       let currentDate = Date()
       let entry = CountdownEntry(date: Calendar.current.date(byAdding: .minute, value: 3, to: currentDate)!, countdowns: countdowns)
       let timeline = Timeline(entries: [entry], policy: .atEnd)
       completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let configuration: ConfigurationAppIntent
}

struct CountdownerWidgetEntryView : View {
    var entry: Provider.Entry
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdownIndex = 0
    var body: some View {
        VStack {
            if(entry.countdowns.isEmpty) {
                Text("No Countdowns")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.body)
                    .padding(.horizontal)
            } else {
                Text(String(getTimeIntervalNumberFromCurrentDate(date: entry.countdowns[countdownIndex].date))).foregroundColor(.white)
                    .fontWeight(.heavy)
                    .fontDesign(.serif)
                    .font(.system(size: 100))
                Text(entry.countdowns[countdownIndex].name).foregroundColor(.white)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .onAppear(perform: {
            if(!entry.countdowns.isEmpty) {
              countdownIndex = Int.random(in: 0..<entry.countdowns.count)
            }
        })
        .containerRelativeFrame([.horizontal, .vertical])
        .background(LinearGradient(gradient: Gradient(colors: [.pink, .red]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
    }
}

struct CountdownerWidget: Widget {
    let kind: String = "CountdownerWidget"

    var body: some WidgetConfiguration {
//        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//            CountdownerWidgetEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
//        }
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CountdownerWidgetEntryView(entry: entry)
                }
                .configurationDisplayName("Countdowner widget")
                .description("Get your recent countdowns")
                .supportedFamilies([.systemSmall])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    CountdownerWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: .now)
}
