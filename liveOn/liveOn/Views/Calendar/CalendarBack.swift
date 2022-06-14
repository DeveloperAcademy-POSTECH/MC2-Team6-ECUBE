//
//  CalendarBack.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct CalendarBack: View {
    
    @State var currentDate: Date = Date()
    @State private var bgColor = Color("background")
        
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 20) {
                CalendarMain(
//                    autoDate: self.currentDate,
                             bgColor: $bgColor,
                             currentDate: $currentDate)
            }
            .padding(.vertical)
            .background(bgColor)
        }
        .background(bgColor)
    }
}

struct CalendarBack_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}
