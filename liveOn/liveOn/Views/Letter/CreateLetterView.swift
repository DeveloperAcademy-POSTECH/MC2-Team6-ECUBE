//
//  CreateLetterView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/06.
//

import SwiftUI

    func getRandomLetterStyle() -> String {
        let letterStyle = ["blue", "green", "orange", "pink", "purple", "yellow", "white"]
        return "letter_"+letterStyle[Int.random(in: 0 ..< letterStyle.count)]
    }

struct CreateLetterView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: LetterStore
    @State var isitEntered: Bool = false
    @State var showAlertforSend: Bool = false
    @State var letterStyle: String?
    @ObservedObject var input =  TextLimiter(limit: 140, placeholder: "오늘은 어떤 이야기를 해볼까요?")
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                TextEditor(text: $input.value)
                    .setHandWritten()
                    .foregroundColor(isitEntered ? .black : .gray)
                // MARK: placeholder 사라지게
                    .onTapGesture {
                        if input.value == input.placeholder {
                            input.value = ""
                            isitEntered = true
                        }
                    }
                    .alert("쪽지는 \(input.limit)글자까지만 쓸 수 있어요.", isPresented: $input.hasReachedLimit) {
                        Button("확인", role: .cancel) {}
                    }

                    Text("(\(isitEntered ? input.value.count : 0)/\(input.limit))")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.bodyTextColor)
                    .opacity(0.6)
                    .padding(.vertical)
                
            }
            // MARK: 쪽지 크기&배경 설정
            .frame(maxWidth: UIScreen.main.bounds.width*0.8, maxHeight: UIScreen.main.bounds.width*0.7)
            .padding(24)
            .background(Image(letterStyle ?? "letter_green").resizable().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
            
            .navigationBarItems(
                leading:
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
               ,
                trailing: Button {
                    showAlertforSend = true
                } label: {
                    Text("보내기")
                    .fontWeight(.bold)}
                    .disabled(!isitEntered)
                // MARK: 보내기 전 alert창
                // TODO: 오늘의선물함(달력상세)뷰로 이동시키기, 1개 제한 두기, 작성자 연결하기
                    .alert(isPresented: $showAlertforSend) {
                        Alert(title: Text("쪽지 보내기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 쪽지를 보낼까요?"), primaryButton: .cancel(Text("취소")), secondaryButton: Alert.Button.default(Text("보내기")) {
                            store.insert(letter: input.value, writer: "재헌")
                            dismiss()
                        })
                        
                    })
            .preferredColorScheme(.light)
            .navigationBarTitle("쪽지 쓰기", displayMode: .inline)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)

        }
        .onAppear {
            letterStyle = getRandomLetterStyle()
        }
        .background(Color.background)
    }
    
    struct CreateLetterView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                CreateLetterView()
                    .environmentObject(LetterStore())
            }
        }
    }
}
