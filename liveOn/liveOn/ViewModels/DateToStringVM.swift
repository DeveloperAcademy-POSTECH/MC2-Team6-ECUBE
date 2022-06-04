//
//  DateToStringVM.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/04.
//

import Foundation

func DateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "YYMMdd"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

