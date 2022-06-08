//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/08.
//

import SwiftUI

struct PhotoCardsView: View {
    @EnvironmentObject var imageModel: imageViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                PhotoCard(imageName: "exampleImage1", text: "테스트1")
                PhotoCard(imageName: "exampleImage2", text: "테스트2")
            }
            .frame(maxWidth: .infinity)

        }
        .background(Color.background)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    imageModel.backToFirst = false
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("사진 선물함")
                    .foregroundColor(.black)
            }
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

    var imageName: String
    var text: String
    var body: some View {
        
        VStack {

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 400)
            
            Text(text)
                .foregroundColor(.bodyTextColor)
                .frame(width: 300, height: 20, alignment: .leading)
        }
        .padding()
        .background(Color.white
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}
