//
//  CalendarMain.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/07.
//

import SwiftUI

struct CalendarMain: View {
    
    // 기념일 추가 Button
    @State var showSheet: Bool = false
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    @State private var datecircleColor = Color("Orange")
    @State private var yearColor = Color("Burgundy")
    @State private var monthColor = Color("Burgundy")
    @State private var dayoftheweekColor = Color.gray
    
    @State private var holidaytitle: String = ""
    @State private var holidaymemo: String = ""
    @State private var emojitxt: String = ""
    @State var holidaydate: String = ""
    
    @Binding var bgColor: Color
    @Binding var currentDate: Date
    
    @Environment(\.presentationMode) var presentationMode: Binding
    
    var btBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .font(.footnote)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }
    }
    
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
                        .foregroundColor(.black)
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
                        .foregroundColor(.black)
                        .font(.title2)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btBack)
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
                            .foregroundColor(.black)
                            .sheet(isPresented: $showSheet, content: {
                                PlusSetting(currentDate: $currentDate,
                                            holidaytitle: $holidaytitle,
                                            holidaymemo: $holidaymemo,
                                            emojitxt: $emojitxt)
                            })
                    }
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
                    
                    TextField("Emoji", text: $emojitxt, prompt: Text("🍫"))
                        .limitInputLength(value: $emojitxt, length: 1)
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 28))
                        .offset(x: -135, y: -8)
                    
                    Text("06/16") // 여기에 holidaydate 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -135, y: 20)
                    
                    Text("초콜릿 먹는 날") // 여기에 holidaytitle 들어가면 될 듯
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -50, y: -12)
                    
                    Text("서로를 위해 허쉬 초콜릿 사오는 날") // 여기에 holidaymemo 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .offset(x: -7, y: 16)
                }
                .padding(.top, 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 355, height: 66)
                    
                    Capsule()
                        .fill(Color("Burgundy"))
                        .frame(width: 38, height: 8)
                        .rotationEffect(Angle(degrees: 90))
                        .offset(x: -173, y: 0)
                    
                    TextField("Emoji", text: $emojitxt, prompt: Text("🥂"))
                        .limitInputLength(value: $emojitxt, length: 1)
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 28))
                        .offset(x: -135, y: -8)
                    
                    Text("06/20") // 여기에 holidaydate 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -135, y: 20)
                    
                    Text("칵테일 마시는 날") // 여기에 holidaytitle 들어가면 될 듯
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -42, y: -12)
                    
                    Text("분위기 있는 바 가서 칵테일 마시는 날") // 여기에 holidaymemo 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .offset(x: 2, y: 16)
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
                    
                    TextField("Emoji", text: $emojitxt, prompt: Text("🌉"))
                        .limitInputLength(value: $emojitxt, length: 1)
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 28))
                        .offset(x: -135, y: -8)
                    
                    Text("06/24") // 여기에 holidaydate 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -135, y: 20)
                    
                    Text("부산 놀러가는 날") // 여기에 holidaytitle 들어가면 될 듯
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color("Burgundy"))
                        .offset(x: -42, y: -12)
                    
                    Text("서로의 휴식을 위해 부산 놀러가는 날") // 여기에 holidaymemo 들어가면 될 듯
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .offset(x: 0, y: 16)
                }
                .padding(.top, 2)
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
                
                Text("\(value.day)")
                    .font(.callout)
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ?
                        .white : .gray)
                    .padding(.leading, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
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

struct CalendarMain_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBack()
    }
}
