//
//  DynamicIslandBookNowLiveActivity.swift
//  DynamicIslandBookNow
//
//  Created by Eky on 28/11/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DynamicIslandBookNowAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DynamicIslandBookNowLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DynamicIslandBookNowAttributes.self) { context in
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

extension DynamicIslandBookNowAttributes {
    fileprivate static var preview: DynamicIslandBookNowAttributes {
        DynamicIslandBookNowAttributes(name: "World")
    }
}

extension DynamicIslandBookNowAttributes.ContentState {
    fileprivate static var smiley: DynamicIslandBookNowAttributes.ContentState {
        DynamicIslandBookNowAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DynamicIslandBookNowAttributes.ContentState {
         DynamicIslandBookNowAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DynamicIslandBookNowAttributes.preview) {
   DynamicIslandBookNowLiveActivity()
} contentStates: {
    DynamicIslandBookNowAttributes.ContentState.smiley
    DynamicIslandBookNowAttributes.ContentState.starEyes
}
