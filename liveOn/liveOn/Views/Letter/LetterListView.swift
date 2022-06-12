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
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24) {
                ForEach(store.list) { letter in
                    // TODO: 작성자 연결하기
                    LetterView(doshowDetail: $doshowDetail, letter: letter)
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .navigationBarTitle("쪽지", displayMode: .inline)
        .background(.background)
    }
}
extension LetterListView {
    struct LetterView: View {

        @Binding var doshowDetail: Bool
        
        let letter: Letter
        var body: some View {
           itemPreview
                .onTapGesture {
                    withAnimation(.easeOut(duration: 5)) {
                    doshowDetail = true
                    }
                }
               
        }
        
        func showDetail() -> some View {
            VStack {
             
                    itemDetail
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            .background(BackgroundClearView())
            .ignoresSafeArea()
            .transition(.opacity)
            .onTapGesture {
                doshowDetail.toggle()
            }
            
        }
        
        var itemPreview: some View {
            Text("안녕")
                .frame(width: 280, height: 120, alignment: .center)
                .background(Color(uiColor: .systemBackground).shadow(color: .gray, radius: 1, x: 1, y: 1))
                .fullScreenCover(isPresented: $doshowDetail, content: showDetail)
                .transition(.opacity)

        }
        var itemDetail: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(letter.content)
                    .padding()
                VStack {
                    Text(letter.createdDate)
                        .font(.callout)
                    Text("by.\(letter.writer)")
                }
                .opacity(0.8)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .foregroundColor(.bodyTextColor)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground).shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
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
