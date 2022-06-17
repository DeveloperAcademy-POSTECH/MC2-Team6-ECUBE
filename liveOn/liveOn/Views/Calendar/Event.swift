//
//  Event.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/17.
//

import SwiftUI

class Event: Identifiable, ObservableObject {
    let id: UUID
    let eventDate: String
    let eventTitle: String
    let eventMemo: String
    let emoji: String
    init(eventDate: Date, eventTitle: String, eventMemo: String, emoji: String) {
        id = UUID()
        self.eventDate = DateToStringEvent(eventDate)
        self.eventTitle = eventTitle
        self.eventMemo = eventMemo
        self.emoji = emoji
    }
}

class EventStore: ObservableObject {
    @Published var list: [Event]
    
    init() {
        list = []
    }
    
    func insert(eventDate: Date, eventTitle: String, eventMemo: String, emoji: String) {
        list.insert(Event(eventDate: eventDate, eventTitle: eventTitle, eventMemo: eventMemo, emoji: emoji), at: 0)
    }
}
