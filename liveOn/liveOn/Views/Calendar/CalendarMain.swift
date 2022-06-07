//
//  CalendarMain.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct CalendarMain: View {
        
    @Binding var currentDate: Date

    // 기념일 추가 Button
    @State var showSheet: Bool = false
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    // 색상 변경할려면 여기에 추가하기
    @State private var datecircleColor = Color("Orange")
    @State private var yearColor = Color("Burgundy")
    @State private var monthColor = Color("Burgundy")
    @State private var chevronColor = Color.black
    @State private var plusColor = Color.black
    @State private var dayoftheweekColor = Color.gray
    @State private var dateColor = Color.gray
    
    @Binding var bgColor: Color

    var body: some View {
        
        VStack(spacing: 20) {
            
            // Days
            let days: [String] =
            ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 1) {
                
                Button {
                    withAnimation {
                        self.currentDate = self.moveCurrentMonth(isUp: false)
                    }
                } label: {
                    Image(systemName: "chevron.left")
                    // 색상 변경 요소 chevron 통일
                        .foregroundColor(chevronColor)
                        .font(.title2)
                }
                
                Spacer(minLength: 0)
                
                Text(extraDate(currentDate: self.currentDate)[0])
                    .font(.title.bold())
                // 색상 변경 요소
                    .foregroundColor(yearColor)
                
                Text(".")
                    .font(.title.bold())
                    .foregroundColor(yearColor)
                
                Text(extraDate(currentDate: self.currentDate)[1])
                    .font(.title.bold())
                // 색상 변경 요소
                    .foregroundColor(monthColor)

                // 휠피커 구현하기
                Button {
                    withAnimation {
                        self.currentDate =  self.moveCurrentMonth(isUp: true)
                    }
                } label: {
                    Image(systemName: "chevron.down")
                    // 색상 변경 요소 chevron 통일
                        .foregroundColor(yearColor)
                        .font(.caption2)
                }
                .padding(.leading, 6)
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        self.currentDate =  self.moveCurrentMonth(isUp: true)
                    }
                } label: {
                    Image(systemName: "chevron.right")
                    // 색상 변경 요소 chevron 통일
                        .foregroundColor(chevronColor)
                        .font(.title2)
                }
            }
            
            .padding(.horizontal)
            
            // Day View
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) {day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                    // 색상 변경 요소
                        .foregroundColor(dayoftheweekColor)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Dates
            // Lazy Grid
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns) {
                
                ForEach(extractDate(currentDate: self.currentDate)) { value in
                    
                    CardView(value: value)
                        .background(
                            
                            Circle()
                                .fill(datecircleColor)
                                .padding(.bottom, 49)
                                .padding(.trailing, 27.8)
                                .padding(.leading, 4)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 10) {
                
                HStack {
                    
                    Text("다가오는 기념일")
                        .font(.title2.bold())
                    // 색상 변경 요소
                        .foregroundColor(Color("Burgundy"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, -10)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                        .font(.title3)
                        .foregroundColor(plusColor)
                        .sheet(isPresented: $showSheet, content: {
                            PlusSetting()
                        })
                    }
                }
                
//                if let memo = memos.first(where: { memo in
//                    return isSameDay(date1: memo.memoDate, date2: currentDate)
//                }) {
//                    Form {
//                    ForEach(memo.memo) { memo in
//                        Text(memo.title)
//                    }
//                    .foregroundColor(.indigo)
//                    .listRowBackground(Color("Primary"))
//                    .listRowSeparator(.hidden)
//                }
//                    .background(bgColor)
//                    .frame(height: 200)
//                    .cornerRadius(20)
//                    } else {
//
//                    Text("No Memo Found")
//                    //색상 변경 요소
//                            .foregroundColor(.gray)
//                }
            }
            .padding()
            
        }
        .onChange(of: currentMonth) { _ in
            
            // updating Month...
            currentDate =  getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        
        VStack {
            
            if value.day != -1 {
                
                if let memo = memos.first(where: { memo in
                    
                    return isSameDay(date1: memo.memoDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.callout)
                        .foregroundColor(isSameDay(date1: memo.memoDate, date2: currentDate) ?
                                         // 색상 변경 요소 (메모 있는 특별 날짜 글자)
                            .white : dateColor)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                
                } else {
                    
                    Text("\(value.day)")
                        .font(.callout)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?
                                         // 색상 변경 요소 (메모 없는 기본 날짜 글자)
                            .white : dateColor)
                        .padding(.leading, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 6)
        .frame(height: 80, alignment: .top)
        .border(Color.gray, width: 1)
    }
    
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year and Month for display
    func extraDate(currentDate: Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY M"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func moveCurrentMonth(isUp: Bool) -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: (isUp ? 1 : -1), to: self.currentDate)
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate(currentDate: Date) -> [DateValue] {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date
        let currentMonth = currentDate // getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue
            in
            
            // getting day
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct PlusSetting: View {
    var body: some View {
        Text("다가오는 기념일")
    }
}

struct CalendarMain_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}

// Extending Date to get Current Month Dates
extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // getting start Date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // getting date
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
