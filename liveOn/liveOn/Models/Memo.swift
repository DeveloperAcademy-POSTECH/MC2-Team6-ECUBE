//
//  Memo.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

// Memo Model and Sample Memo
// Array of memos
struct Memo: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// Total Memo Meta View
struct MemoMetaData: Identifiable {
    var id = UUID().uuidString
    var memo: [Memo]
    var memoDate: Date
}

// sample Date for Testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Sample Memos
var memos: [MemoMetaData] = [

    MemoMetaData(memo: [
    
        Memo(title: "NC1, The End"),
        Memo(title: "Get some rest😵"),
        Memo(title: "Pokemon Bread Ticketing")
    ], memoDate: getSampleDate(offset: 0)),
    MemoMetaData(memo: [
    
        Memo(title: "Talk to Rey")
    ], memoDate: getSampleDate(offset: -3)),
    MemoMetaData(memo: [
        
        Memo(title: "Meeting with Lingo")
    ], memoDate: getSampleDate(offset: -8)),
    MemoMetaData(memo: [
    
        Memo(title: "SwiftUI WorkShop")
    ], memoDate: getSampleDate(offset: 10)),
    MemoMetaData(memo: [

        Memo(title: "Get some rest😵")
    ], memoDate: getSampleDate(offset: -22)),
    MemoMetaData(memo: [

        Memo(title: "Nothing Much Workout")
    ], memoDate: getSampleDate(offset: 15)),
    MemoMetaData(memo: [
        
        Memo(title: "Design Workshop")
    ], memoDate: getSampleDate(offset: -20))
 ]
