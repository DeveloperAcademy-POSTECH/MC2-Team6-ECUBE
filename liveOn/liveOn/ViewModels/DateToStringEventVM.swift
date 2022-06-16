//
//  DateToStringEvent.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/15.
//

import Foundation

func DateToStringEvent(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "MM/dd"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}
