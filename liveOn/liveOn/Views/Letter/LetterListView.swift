//
//  LetterListView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/06.
//

import SwiftUI

struct LetterListView: View {
    @EnvironmentObject var store: LetterStore
    @State var doshowDetail: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(.flexible(), spacing: 1, alignment: .center), count: 2)
                
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(store.list) { letter in
                        // TODO: 작성자 연결하기
                        LetterView(doshowDetail: $doshowDetail, letter: letter)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 1)) {
                                    doshowDetail.toggle()
                                }
                            }
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .blur(radius: doshowDetail ? 5 : 0)
            Color(uiColor: .systemBackground).opacity(doshowDetail ? 0.5 : 0)
            if doshowDetail {
                LetterDetail()
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            doshowDetail.toggle()
                        }
                    }
            }
           
        }
        
        .navigationToBack(dismiss)
        .navigationBarTitle("쪽지", displayMode: .inline)
        .background(Color.background)
    }
}
extension LetterListView {
    struct LetterView: View {

        @Binding var doshowDetail: Bool
        @State var letterStyle: String?
        let letter: Letter
        var body: some View {
           itemPreview
                .onTapGesture {
                    withAnimation(.easeOut) {
                    doshowDetail = true
                    }
                }
               
        }
        
        func showDetail() -> some View {
            VStack {
                    LetterDetail()
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            .background(Image(""))
            .ignoresSafeArea()
            .transition(.opacity)
            .onTapGesture {
                doshowDetail.toggle()
            }
            
        }
        
        var itemPreview: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(letter.content)
                    .setHandWritten()
                .lineLimit(1)
             
                Text("from \(letter.writer)")
                    .setHandWritten()
                    .font(.caption)
                    .opacity(0.8)
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.width*0.45, alignment: .center)
            .foregroundColor(.bodyTextColor)
            .background(Image(letter.letterStyle).resizable().scaledToFit().shadow(color: .shadowColor, radius: 2, x: 1, y: 1))

        }
            
}
    
}

struct LetterDetail: View {
    @EnvironmentObject var store: LetterStore
    @State var letterTemp: Letter = Letter(content: "안녕 유진아 반가워 오랜만이야", createdDate: Date(), writer: "재헌")
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Text(letterTemp.content)
                    .setHandWritten()
                    .lineSpacing(4)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                Spacer()
                VStack {
                    Text(letterTemp.createdDate)
                        .setHandWritten()
                        .font(.callout)
                    Text("from.\(letterTemp.writer)")
                        .setHandWritten()
                }
                .padding(.bottom, 4)
                .opacity(0.8)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            .frame(width: UIScreen.main.bounds.width*0.65, height: UIScreen.main.bounds.width*0.55, alignment: .leading)
        
        }
        .foregroundColor(.bodyTextColor)
        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.9, alignment: .center)
        .background(Image(letterTemp.letterStyle).resizable().scaledToFit().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
    
        .onAppear {
            letterTemp = store.list[Int.random(in: 0 ..< store.list.count)]
        }
    }
    
}
struct LetterListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LetterListView()
                .environmentObject(LetterStore())
        }
    }
}

struct BackgroundClearView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))

        view.alpha = 0.6 // < --- here
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
