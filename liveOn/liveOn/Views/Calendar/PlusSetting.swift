//
 //  PlusSetting.swift
 //  liveOn
 //
 //  Created by Keum MinSeok on 2022/06/07.
 //

import SwiftUI

struct PlusSetting: View {
    
    @State private var showani = false
    @State var show = false

    @Binding var eventDate: Date
    @Binding var eventbaseDate: Date
    @Binding var eventTitle: String
    @Binding var eventMemo: String
    @Binding var emoji: String
    @Binding var burgundyColor: Color
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: EventStore
    
    var body: some View {
        
        // 이모지 키보드를 위한 요소
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                Button("취소") {
                    eventbaseDate = Date.now
                    dismiss()
                }
                .font(.system(size: 16))
                .foregroundColor(burgundyColor)
                
                Spacer()
                
                Text("기념일 추가")
                    .font(.title2.bold())
                    .foregroundColor(Color("Burgundy"))
                
                Spacer()
                
                Button("확인") {
                    eventDate = self.eventbaseDate
                    store.insert(eventDate: eventDate, eventTitle: eventTitle, eventMemo: eventMemo, emoji: emoji)
                    eventbaseDate = Date.now
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 16))
                .foregroundColor(burgundyColor)
            }
            .padding([.trailing, .leading], 15)
            .padding(.top, -255)
            
            VStack {
                
                DatePicker("기념일 추가", selection: $eventbaseDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(.black)
                    .applyTextColor(burgundyColor)
                    .frame(height: 370)
            }
            .padding(.top, -50)
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray).opacity(0.3)
                    .frame(width: 85, height: 85)
                    .offset(x: -137, y: 296)
                
                HStack {
                    TextField("Emoji", text: $emoji, prompt: Text("☺︎"))
                        .limitInputLength(value: $emoji, length: 1)
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 60))
                        .frame(width: 80, height: 100)
                        .offset(x: -136, y: 196)
                }
                
                Button(action: {
                    window?.rootViewController?.view.endEditing(true)
                    self.show.toggle()
                }) {
                    Text("아이콘 변경")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .offset(x: -135, y: 186)
            }
            
            VStack {
                TextField("Comment", text: $eventTitle, prompt: Text("어떤 기념일인가요?"))
                    .limitInputLength(value: $eventTitle, length: 15)
                    .multilineTextAlignment(TextAlignment.leading)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 250, height: 20)
                    .font(.system(size: 18))
                    .offset(x: 46, y: 245)
                
                VStack {
                    Text("(\(eventTitle.count)/15)")
                        .frame(width: 300, height: 20, alignment: .trailing)
                        .foregroundColor(.bodyTextColor).opacity(0.5)
                        .offset(x: 38, y: 232)
                }
                
                TextField("Comment", text: $eventMemo, prompt: Text("메모를 입력해주세요."))
                    .limitInputLength(value: $eventMemo, length: 20)
                    .multilineTextAlignment(TextAlignment.leading)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 250, height: 20)
                    .font(.system(size: 18))
                    .offset(x: 46, y: 230)
                
                VStack {
                    Text("(\(eventMemo.count)/20)")
                        .frame(width: 300, height: 20, alignment: .trailing)
                        .foregroundColor(.bodyTextColor).opacity(0.5)
                        .offset(x: 38, y: 217)
                }
            }
        }
        .padding(.bottom, 20)
//        .background(Color.background)
        EmojiView(show: self.$show, txt: self.$emoji).offset(y: self.show ?  (window?.safeAreaInsets.bottom)! : UIScreen.main.bounds.height)
            .padding(.bottom, -65)
    }
}

// 이모지 키보드 뷰
struct EmojiView: View {
    
    @Binding var show: Bool
    @Binding var txt: String
    
    var body : some View {
        
        ZStack(alignment: .topLeading) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    
                    ForEach(self.getEmojiList(), id: \.self) {i in
                        
                        HStack(spacing: 25) {
                            
                            ForEach(i, id: \.self) {j in
                                
                                Button(action: {
                                    self.txt += String(UnicodeScalar(j)!)
                                }) {
                                    if (UnicodeScalar(j)?.properties.isEmoji)! {
                                        Text(String(UnicodeScalar(j)!)).font(.system(size: 55))
                                    } else {
                                        Text("")
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
            .background(Color("Ivory"))
            .cornerRadius(25)
            
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "xmark").foregroundColor(.black)
            }
            .padding()
        }
        .padding(.bottom, -60)
    }
    
    // 이모지 키보드에 뜨는 이모지 종류 리스트
    func getEmojiList() -> [[Int]] {
        
        var emojis: [[Int]] = []
        
        // 이모지 유니코드 리스트
        for i in stride(from: 0x1f36A, through: 0x1F379, by: 4) {
            
            var temp: [Int] = []
            
            for j in i...i+3 {
                
                temp.append(j)
            }
            
            emojis.append(temp)
        }
        
        return emojis
    }
}

// 다가오는 기념일 화면에 있는 DatePicker의 색상 변경
extension View {
    
    @ViewBuilder func applyTextColor(_ color: Color) -> some View {
        
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(color)
        } else {
            self.colorMultiply(color)
        }
    }
}

struct PlusSetting_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMain().environmentObject(EventStore())
    }
}
