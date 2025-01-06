//
//  CountdownerWidgetLiveActivity.swift
//  CountdownerWidget
//
//  Created by shmeelok chakraborty on 1/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CountdownerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CountdownerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CountdownerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CountdownerWidgetAttributes {
    fileprivate static var preview: CountdownerWidgetAttributes {
        CountdownerWidgetAttributes(name: "World")
    }
}

extension CountdownerWidgetAttributes.ContentState {
    fileprivate static var smiley: CountdownerWidgetAttributes.ContentState {
        CountdownerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CountdownerWidgetAttributes.ContentState {
         CountdownerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CountdownerWidgetAttributes.preview) {
   CountdownerWidgetLiveActivity()
} contentStates: {
    CountdownerWidgetAttributes.ContentState.smiley
    CountdownerWidgetAttributes.ContentState.starEyes
}
