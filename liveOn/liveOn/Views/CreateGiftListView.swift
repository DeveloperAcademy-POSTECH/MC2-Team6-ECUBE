//
//  CreateGiftListView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/04.
//

import SwiftUI

struct CreateGiftListView: View {

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("선물은 하루에 한개만 보낼 수 있어요. \n 오늘은 어떤 선물을 해볼까요?")
                    .foregroundColor(.bodyTextColor)
                    .multilineTextAlignment(.center)
                GiftItem()
            }
            .navigationTitle("선물 만들기")
            .navigationBarTitleDisplayMode(.inline)        }
        .background(.background)
    }
    
}

extension CreateGiftListView {
    struct GiftItem: View {
        @EnvironmentObject var store: LetterStore
        var body: some View {
            NavigationLink(destination: CreateLetterView() .environmentObject(store)) {
                HStack(alignment: .top, spacing: 08) {
                    Image("letter")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 5).fill(.regularMaterial))
                    VStack(alignment: .leading, spacing: 4) {
                        Text("쪽지")
                            .font(.headline)
                        Text("손글씨가 담긴 편지를 보내요")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                .padding()
                .background(.thickMaterial)
            .padding()
            }
        }
    }
}

struct CreateGiftListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGiftListView()
    }
}
