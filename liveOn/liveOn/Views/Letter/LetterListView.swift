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
    
    @State var selectedLetter = Letter(content: "", createdDate: Date(), writer: "")
    //    @State var index: Int = 0
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                let columns = Array(repeating: GridItem(.flexible(), spacing: 1, alignment: .center), count: 2)
                
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(store.list) { letter in
                        // TODO: 작성자 연결하기
                        LetterView(letter: letter)
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    doshowDetail.toggle()
                                }
                                selectedLetter = letter
                            }
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .blur(radius: doshowDetail ? 5 : 0)
            .onTapGesture {
                withAnimation(.easeOut) {
                    doshowDetail = false
                }
            }
//            Color(uiColor: .systemBackground).opacity(doshowDetail ? 0.5 : 0)
            
            if doshowDetail {
                LetterDetail(letter: selectedLetter)
                    .padding()
//                    .onTapGesture {
//                        withAnimation {
//                            selectedLetter.toggle()
//                        }
//                    }
            }
            
        }
        
        .navigationToBack(dismiss)
        .navigationBarTitle("쪽지", displayMode: .inline)
        .background(Color.background)
    }
}
extension LetterListView {
    struct LetterView: View {
        
        @State var letterStyle: String?
        
        let letter: Letter
        
        var body: some View {
            ZStack {
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
        
//        var itemPreview: some View {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(letter.content)
//                    .setHandWritten()
//                    .lineLimit(1)
//
//                Text("from \(letter.writer)")
//                    .setHandWritten()
//                    .font(.caption)
//                    .opacity(0.8)
//
//            }
//            .padding()
//            .frame(width: UIScreen.main.bounds.width*0.45, height: UIScreen.main.bounds.width*0.45, alignment: .center)
//            .foregroundColor(.bodyTextColor)
//            .background(Image(letter.letterStyle).resizable().scaledToFit().shadow(color: .shadowColor, radius: 2, x: 1, y: 1))
//
//        }
        
    }
    
}

struct LetterDetail: View {
    
    var letter: Letter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Text(letter.content)
                    .setHandWritten()
                    .lineSpacing(4)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                VStack {
                    Text(letter.createdDate)
                        .setHandWritten()
                        .font(.callout)
                    Text("from.\(letter.writer)")
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
        .background(Image(letter.letterStyle).resizable().scaledToFit().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
        //
        //        .onAppear {
        //            letterTemp = store.list[Int.random(in: 0 ..< store.list.count)]
        //        }
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
