//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/08.
//

import SwiftUI

struct PhotoCardsView: View {
    @EnvironmentObject var imageModel : imageViewModel
    var body: some View {
        GeometryReader { geo in
        ScrollView{
            VStack{
                PhotoCard(imageName: "exampleImage1", text: "테스트1")
                PhotoCard(imageName: "exampleImage2", text: "테스트2")
                NavigationLink(destination: GiftBoxView(), isActive: $imageModel.backToFirst) {
                    Text("")
                }
            }
        }
        .frame(width: geo.size.width, height: geo.size.height * 0.95, alignment: .center)
    }
    }
}

struct photoCardsView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardsView()
            .environmentObject(imageViewModel())
    }
}

struct PhotoCard: View {
    var imageName : String
    var text: String
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400)
            
            Text(text)
                .foregroundColor(.bodyTextColor)
                .frame(width: 300, height: 20, alignment: .leading)
        }
        .padding()
        .background(Color.white
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}
