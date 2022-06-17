//
 //  CalendarMain.swift
 //  liveOn
 //
 //  Created by Keum MinSeok on 2022/06/07.

import SwiftUI

struct CalendarMain: View {
    
    // 기본 베이스가 되는 날짜 변수
    @State var currentDate: Date = Date()
    
    // 기념일 추가 Button
    @State var showSheet = false

    // MoveDatePicker 아래에 블러 효과 넣기
    @State private var isClicked = false
    
    // 달력에서 Date Picker로 날짜 이동 Button
    @State var showDatePicker = false
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    // 달력에 쓰이는 색깔
    @State private var orangeColor = Color("Orange")
    @State private var burgundyColor = Color("Burgundy")
    @State private var ivoryColor = Color("Ivory")
    
    // 다가오는 기념일에 쓰일 변수
    @State var eventbaseDate: Date = Date()
    
    @State private var eventTitle: String = ""
    @State private var eventMemo: String = ""
    @State private var emoji: String = ""
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                ZStack {
                    VStack(spacing: 20) {
                        
                        // Days
                        let days: [String] =
                        ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                        
                        HStack(spacing: 1) {
                            
                            // 달력 이전 달로 이동
                            Button {
                                withAnimation {
                                    self.currentDate = self.moveCurrentMonth(isUp: false)
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(burgundyColor)
                                    .font(.system(size: 18, weight: .light))
                            }
                            .padding()
                            
//                            Spacer(minLength: 0)
                            
                            // 달력의 년도/월/moveDatePicker Popup
                            Text(extraDate(currentDate: self.currentDate)[0])
                                .font(.title.bold())
                                .foregroundColor(burgundyColor)
                            
                            Text(".")
                                .font(.title.bold())
                                .foregroundColor(burgundyColor)
                            
                            Text(extraDate(currentDate: self.currentDate)[1])
                                .font(.title.bold())
                                .foregroundColor(burgundyColor)
                            
                            // 메인 달력 날짜 고르는 DatePicker
                            Button {
                                showDatePicker.toggle()
                                isClicked.toggle()
                            } label: {
                                Image(systemName: "calendar")
                                    .foregroundColor(burgundyColor)
                                    .font(.title2.bold())
                            }
                            .padding(.leading, 6)
                            
//                            Spacer(minLength: 0)
                            
                            // 달력 다음 달로 이동
                            Button {
                                withAnimation {
                                    self.currentDate =  self.moveCurrentMonth(isUp: true)
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(burgundyColor)
                                    .font(.system(size: 18, weight: .light))
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        
                        // Day View
                        HStack(spacing: 0) {
                            ForEach(days, id: \.self) {day in
                                
                                Text(day)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        
                        // Dates
                        // Lazy Grid
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            
                            ForEach(extractDate(currentDate: self.currentDate)) { value in
                                
                                CardView(value: value)
                                    .background(
                                        Circle()
                                            .fill(orangeColor)
                                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                            .padding(.vertical, 36)
                                            .padding(.bottom, 16)
                                            .padding(.top, -32)
                                            .padding(.leading, -26)
                                    )
                                    .onTapGesture {
                                        currentDate = value.date
                                    }
                            }
                        }
                        
                        // 다가오는 기념일
                        VStack(spacing: 10) {
                            
                            HStack {
                                
                                Text("다가오는 기념일")
                                    .font(.title2.bold())
                                    .foregroundColor(Color("Burgundy"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, -10)
                                
                                Spacer(minLength: 0)
                                
                                Button(action: {
                                    showSheet.toggle()
                                }) {
                                    Image(systemName: "plus.circle")
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .sheet(isPresented: $showSheet, content: {
                                            PlusSetting(
                                                eventDate: self.eventbaseDate,
                                                eventbaseDate: $eventbaseDate,
                                                eventTitle: $eventTitle,
                                                eventMemo: $eventMemo,
                                                emoji: $emoji)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        })
                                }
                            }
                            
                            Group {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .frame(width: 355, height: 66)
                                    
                                    HStack {
                                        Capsule()
                                            .fill(Color("Burgundy"))
                                            .frame(width: 38, height: 8)
                                            .rotationEffect(Angle(degrees: 90))
                                            .padding(.trailing, 14)
                                        
                                        VStack {
                                            // emoji
                                             Text(emoji)
                                                .font(.system(size: 28))
                                                .padding(.bottom, -5)
                                            
                                            //  eventDate
                                            Text(DateToStringEvent(_:eventbaseDate))
                                                .font(.system(size: 13))
                                                .foregroundColor(Color("Burgundy"))
                                        }
                                        .padding(.leading, -21)
                                        
                                        VStack {
                                            //  eventTitle
                                              Text(eventTitle)
                                                .foregroundColor(Color("Burgundy"))
                                                .font(.system(size: 18).bold())
                                                .frame(width: 280, alignment: .leading)
                                                .padding(.trailing, -30)
                                                .padding(.bottom, 3)
                                            
                                            // eventMemo
                                             Text(eventMemo)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14))
                                                .frame(width: 280, alignment: .leading)
                                                .padding(.trailing, -32)
                                        }
                                        .padding(.leading, 6)
                                    }
                                    .padding(.leading, -45.5)
                                }
                                .padding(.top, 2)
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: 355, height: 66)
                                
                                Capsule()
                                    .fill(Color("Burgundy"))
                                    .frame(width: 38, height: 8)
                                    .rotationEffect(Angle(degrees: 90))
                                    .offset(x: -173, y: 0)

                                // emoji
                                Text(emoji)
                                    .font(.system(size: 28))
                                    .offset(x: -135, y: -8)
                                
                                //  eventDate
                                Text(DateToStringEvent(_:eventbaseDate))
                                    .font(.system(size: 13))
                                    .foregroundColor(Color("Burgundy"))
                                    .offset(x: -135, y: 20)
                                
                                //  eventTitle
                                TextField("Comment", text: $eventTitle, prompt: Text("칵테일 마시는 날"))
                                    .limitInputLength(value: $eventTitle, length: 20)
                                    .multilineTextAlignment(TextAlignment.leading)
                                    .foregroundColor(Color("Burgundy"))
                                    .font(.system(size: 18).bold())
                                    .frame(width: 250, height: 20)
                                    .offset(x: 22, y: -14)
                                
                                // eventMemo
                                TextField("Comment", text: $eventMemo, prompt: Text("분위기 좋은 바에 가서 칵테일 마시는 날"))
                                    .limitInputLength(value: $eventMemo, length: 20)
                                    .multilineTextAlignment(TextAlignment.leading)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                                    .frame(width: 250, height: 20)
                                    .offset(x: 22, y: 15)
                            }
                            .padding(.top, 2)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .frame(width: 355, height: 66)
                                
                                Capsule()
                                    .fill(Color("Burgundy"))
                                    .frame(width: 38, height: 8)
                                    .rotationEffect(Angle(degrees: 90))
                                    .offset(x: -173, y: 0)
                               
                                // emoji
                                Text("🌉")
                                    .font(.system(size: 28))
                                    .offset(x: -135, y: -8)
                                
                                //  eventDate
                                Text("06/16")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color("Burgundy"))
                                    .offset(x: -135, y: 20)
                                
                                //  eventTitle
                                Text("부산 놀러가는 날")
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(Color("Burgundy"))
                                    .offset(x: -42, y: -14)
                                
                                // eventMemo
                                Text("서로의 휴식을 위해 부산 놀러가는 날")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.gray)
                                    .offset(x: 0, y: 15)
                            }
                            .padding(.top, 2)
                        }
                        .padding()
                    }

                    // MoveDatePickerView와 CalendarMain 사이에 블러 효과
                    .opacity(isClicked ? 0.2 : 1 )
                    
                    // updating Month...
                    .onChange(of: currentMonth) { _ in
                        currentDate =  getCurrentMonth()
                    }
                    // PopUpView 띄우는 코드
                    if showDatePicker {
                        MoveDatePicker(autoDate: self.currentDate,
                                       currentDate: $currentDate,
                                       showDatePicker: $showDatePicker,

                                       popUpBoolean: $showDatePicker,
                                       isClicked: $isClicked)

                    }
                }
            }
            .padding(.vertical)
            .background(ivoryColor)
            .navigationToBack(dismiss)
            .navigationTitle("달력")
        }
        .background(ivoryColor)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View {
        
        VStack {
            
            if value.day != -1 {
                
                Text("\(value.day)")
                    .font(.callout)
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?
                        .white : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 40)
                    .padding(.leading, -26)
                
                Spacer()
            }
        }
        .padding(.vertical, 6)
        .frame(height: 80)
        .border(Color(uiColor: .systemGray3), width: 0.16)
    }
    
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year and Month for display
    func extraDate(currentDate: Date) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MM"
        
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

struct CalendarMain_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMain()
    }
}
