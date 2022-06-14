//
//  CreateGiftListView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/04.
//

import SwiftUI
struct Item: Identifiable {
    let id = UUID()
    let itemImage: String
    let itemName: String
    let itemDescription: String
    let createItemView: AnyView
}

let items = [
    Item(itemImage: "letters", itemName: "쪽지", itemDescription: "감성 꾹꾹 담은 메세지", createItemView: AnyView(CreateLetterView())),
    
    Item(itemImage: "picture", itemName: "폴라로이드", itemDescription: "폴라로이드 형태의 사진과 짧은 메세지", createItemView: AnyView(PhotoGiftView(imageViewModel: imageViewModel()))),
    
    Item(itemImage: "cassettes", itemName: "음성메세지", itemDescription: "짧은 음성메세지를 담은 카세트테이프", createItemView: AnyView(VoicemailView())),
    
    Item(itemImage: "medicine", itemName: "영양제", itemDescription: "직접 이름을 지은 영양제와 짧은 메세지", createItemView: AnyView(PillView())),
    
    Item(itemImage: "flower", itemName: "꽃", itemDescription: "따뜻한 꽃말과 함께 짧은 메세지.", createItemView: AnyView(FlowerView()))
    // TODO: [teemo] FlowerView가 들어가도 This struct may not be available 이라는 메시지가 뜹니다..
]

struct CreateGiftListView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("선물은 하루에 한개만 보낼 수 있어요. \n 오늘은 어떤 선물을 해볼까요?")
                    .foregroundColor(.bodyTextColor)
                    .multilineTextAlignment(.center)
                    .padding(12)
                VStack(alignment: .leading, spacing: 18) {
                    ForEach(items) { item in
                        GiftItem(item: item)
                    }
                }
                
            }
            .navigationTitle("선물 만들기")
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.background)
    }
    
}

extension CreateGiftListView {
    struct GiftItem: View {
        let item: Item
        @EnvironmentObject var store: LetterStore
        var body: some View {
            NavigationLink(destination: item.createItemView .environmentObject(store)) {
                HStack(alignment: .center, spacing: 16) {
                    Image(item.itemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                        .frame(width: 70, height: 70, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.itemName)
                            .font(.headline)
                        Text(item.itemDescription)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .foregroundColor(.bodyTextColor)
                }
                
                .padding()
                .frame(height: 110)
                .background(Color(uiColor: .systemBackground))
                .padding(.horizontal)
            } // navigationLink
            .buttonStyle(.plain)
        }
    }
}

struct CreateGiftListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGiftListView()
            .environmentObject(LetterStore())
    }
}
