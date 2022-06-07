//
//  LetterListView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/06.
//

import SwiftUI

struct LetterListView: View {
    
    @EnvironmentObject var store: LetterStore
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24) {
                ForEach(store.list) { letter in
                        // TODO: 작성자 연결하기
                    LetterView(letter: letter)
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
        let letter: Letter
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text(letter.content)
                    .padding()
                Spacer()
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
            .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.width*0.8, alignment: .topLeading)
                .background(Image("letter_01").resizable().shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 1, y: 3))
            
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
