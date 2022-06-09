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



func DateToStringKR(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "YYYY년 M월 d일"
    
    let dateString = dateFormatter.string(from: date)
    
    return dateString
}

 
extension Date {
    func toString(dateFormat format: String ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }

}
