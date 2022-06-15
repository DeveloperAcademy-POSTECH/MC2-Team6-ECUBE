import SwiftUI

struct PlusSetting: View {
    
    @State private var showani = false
    @State var show = false
    var moveDate: Date
    
    @Binding var currentDate: Date
    @Binding var holidaytitle: String
    @Binding var holidaymemo: String
    @Binding var emojitxt: String
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        // 이모지 키보드를 위한 요소
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        ZStack {
            GeometryReader { _ in
                
                HStack(alignment: .center, spacing: 0) {
                    Button("취소") {
                        dismiss()
                    }
                    .font(.title3)
                    .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text("기념일 추가")
                        .font(.title2.bold())
                        .foregroundColor(Color("Burgundy"))
                    
                    Spacer()
                    
                    Button("확인") {
                        self.currentDate = moveDate
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.title3)
                    .foregroundColor(.primary)
                    
                }
                .padding(15)
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    Color.gray.frame(height: CGFloat(1) / UIScreen.main.scale)
                        .padding(.top, 55)
                    
                    DatePicker("기념일 추가", selection: $currentDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .applyTextColor(Color("Burgundy"))
                        .frame(maxHeight: 400)
                        .padding(.top, -15)
                }
                
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray).opacity(0.3)
                        .frame(width: 100, height: 100)
                        .offset(x: 16, y: 470)
                    
                    HStack {
                        TextField("Emoji", text: $emojitxt, prompt: Text("☺︎"))
                            .limitInputLength(value: $emojitxt, length: 1)
                            .multilineTextAlignment(TextAlignment.center)
                            .font(.system(size: 70))
                            .frame(width: 80, height: 100)
                            .offset(x: 17, y: 363)
                        
                    }
                    
                    Button(action: {
                        window?.rootViewController?.view.endEditing(true)
                        self.show.toggle()
                    }) {
                        Text("아이콘 변경")
                            .font(.callout)
                            .foregroundColor(.gray)
                    }
                    .offset(x: 17, y: 360)
                }
                
                VStack {
                    TextField("Comment", text: $holidaytitle, prompt: Text("어떤 기념일인가요?"))
                        .limitInputLength(value: $holidaytitle, length: 20)
                        .multilineTextAlignment(TextAlignment.leading)
                        .foregroundColor(.bodyTextColor)
                        .frame(width: 250, height: 20)
                        .font(.system(size: 18))
                        .padding(.top, 475)
                        .padding(.leading, 130)
                    
                    VStack {
                        Text("(\(holidaytitle.count)/20)")
                            .frame(width: 300, height: 20, alignment: .trailing)
                            .foregroundColor(.bodyTextColor).opacity(0.5)
                            .padding(.trailing, -82)
                            .padding(.top, -8)
                    }
                    
                    TextField("Comment", text: $holidaymemo, prompt: Text("메모를 입력해주세요."))
                        .limitInputLength(value: $holidaymemo, length: 20)
                        .multilineTextAlignment(TextAlignment.leading)
                        .foregroundColor(.bodyTextColor)
                        .frame(width: 250, height: 20)
                        .font(.system(size: 18))
                        .padding(.top, 8)
                        .padding(.leading, 130)
                    
                    VStack {
                        Text("(\(holidaymemo.count)/20)")
                            .frame(width: 300, height: 20, alignment: .trailing)
                            .foregroundColor(.bodyTextColor).opacity(0.5)
                            .padding(.trailing, -82)
                            .padding(.top, -8)
                    }
                }
            }
        }
        EmojiView(show: self.$show, txt: self.$emojitxt).offset(y: self.show ?  (window?.safeAreaInsets.bottom)! : UIScreen.main.bounds.height)
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
    }
    
    // 이모지 키보드에 뜨는 이모지 종류 리스트
    func getEmojiList() -> [[Int]] {
        
        var emojis: [[Int]] = []
        
        // 이모지 유니코드 리스트
        for i in stride(from: 0x1f302, through: 0x1F6F3, by: 4) {
            
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
        CalendarBack()
    }
}
