//
//  CreateGiftListView.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/04.
//

import SwiftUI

struct CreateGiftListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var storedLetter: LetterStore
    
    var body: some View {
        VStack {
            Text("선물은 하루에 한개만 보낼 수 있어요.\n 오늘은 어떤 선물을 해볼까요?")
                .foregroundColor(.bodyTextColor)
                .multilineTextAlignment(.center)
                .padding(12)
            
            VStack(alignment: .leading, spacing: 18) {
                MakingGift(item: letterItem, destination: AnyView(CreateLetterView().environmentObject(storedLetter)))
                MakingGift(item: photoItem, destination: AnyView(PhotoGiftView(imageModel: ImageViewModel())))
                MakingGift(item: voiceItem, destination: AnyView(VoicemailView()))
                MakingGift(item: pillItem, destination: AnyView(PillView()))
                MakingGift(item: flowerItem, destination: AnyView(FlowerView()))
            }
        }
        .navigationToBack(dismiss)
        .navigationTitle("선물 만들기")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

struct MakingGift: View {
    var item: Item
    var destination: AnyView
    var body: some View {
        NavigationLink(destination: destination) {
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
                        .opacity(0.8)
                }
                .foregroundColor(.bodyTextColor)
            }
            .padding()
            .frame(height: 110)
            .background(Color(uiColor: .systemBackground))
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

struct Item {
    let itemImage: String
    let itemName: String
    let itemDescription: String
}

let letterItem = Item(itemImage: "letters", itemName: "쪽지", itemDescription: "감성 꾹꾹 담은 메세지")
let photoItem = Item(itemImage: "picture", itemName: "폴라로이드", itemDescription: "폴라로이드 형태의 사진과 짧은 메세지")
let voiceItem = Item(itemImage: "cassettes", itemName: "음성메세지", itemDescription: "짧은 음성메세지를 담은 카세트테이프")
let pillItem = Item(itemImage: "medicine", itemName: "약", itemDescription: "직접 이름을 지은 영양제와 짧은 메세지")
let flowerItem = Item(itemImage: "flower", itemName: "꽃", itemDescription: "따뜻한 꽃말과 함께 짧은 메세지")

struct CreateGiftListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGiftListView()
            .environmentObject(LetterStore())
    }
}
