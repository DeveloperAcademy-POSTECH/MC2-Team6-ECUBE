//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/08.
//

import SwiftUI

struct PhotoCardsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isTapped: Bool = false
    @State private var loadedImage = ImageGetResponse(createdAt: "", giftPolaroidId: 0, giftPolaroidImage: "", userNickName: "")
    @State private var PhotoGiftDataList: [PhotoGiftData] = [PhotoGiftData(photoURL: "", photoComment: "")]
    var columns: [GridItem] = Array(repeating: GridItem(GridItem.Size.fixed(160)), count: 2)
    var temporaryData: [PhotoCardInformation] = [testData1, testData2, testData3]
    
    var body: some View {
        ZStack {
            ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(temporaryData, id: \.self) { data in
                            Button(action: {
                                isTapped.toggle()
                            }){
                                PhotoCard(PhotoCardDetail: data)
                            }
                        }
                        LoadedPhotoCard(imageURL: loadedImage.giftPolaroidImage)
                    }
                    .opacity(isTapped ? 0.2 : 1)
                    .onTapGesture {
                        isTapped.toggle()
                    }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                imageGet()
                print("이미지 로딩이 수행되었습니다.")
                PhotoGiftDataList.append(PhotoGiftData(photoURL: loadedImage.giftPolaroidImage, photoComment: loadedImage.userNickName))
            }
            .padding()
            .background(Color.background)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
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
            if isTapped == true {
                Button(action: {
                    isTapped.toggle()
                }){
            PhotoCardSheet(PhotoCardDetail: PhotoCardInformation(imageName: "exampleImage2", photoText: "김치찌개가 존맛입니다!!"))
                }
            }
        }
    }
    
    
    func imageGet() {
        moyaService.request(.imageGet) { response in
            switch response {
            case .success(let result):
                do {
                    loadedImage = try result.map(ImageGetResponse.self)
                } catch let err {
                    print(err.localizedDescription)
                    print("이미지를 디코딩하는데 실패했습니다")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct PhotoCardInformation: Hashable {
    var imageName: String
    var photoText: String
}

struct PhotoGiftData: Hashable {
    var photoURL: String
    var photoComment: String
}

let testData1 = PhotoCardInformation(imageName: "exampleImage1", photoText: "WWDC 오프닝!")
let testData2 = PhotoCardInformation(imageName: "exampleImage2", photoText: "김치 찌개 맛집")
let testData3 = PhotoCardInformation(imageName: "picture", photoText: "추억의 00 사진")

struct PhotoCard: View {
    var PhotoCardDetail: PhotoCardInformation
    var body: some View {
        VStack (alignment: .leading, spacing: 7){
            Image(PhotoCardDetail.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            
            Rectangle()
                .foregroundColor(.placeHolderColor)
                .frame(width: 80, height: 5)
                .cornerRadius(15)
                .padding(.leading, 15)
            
            Rectangle()
                .foregroundColor(.placeHolderColor)
                .frame(width: 60, height: 5)
                .cornerRadius(15)
                .padding(.leading, 15)
        }
        .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.height * 0.25, alignment: .center)
        .padding(2)
        .background(Color.white
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}

struct LoadedPhotoCard: View {
    var imageURL: String
    var body: some View {
        VStack (alignment: .leading, spacing: 7) {
            AsyncImage(url: URL(string: imageURL), scale: 2) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            Rectangle()
                .foregroundColor(.placeHolderColor)
                .frame(width: 80, height: 5)
                .cornerRadius(15)
                .padding(.leading, 15)
            
            Rectangle()
                .foregroundColor(.placeHolderColor)
                .frame(width: 60, height: 5)
                .cornerRadius(15)
                .padding(.leading, 15)
        }
        .frame(width: UIScreen.main.bounds.width * 0.38, height: UIScreen.main.bounds.height * 0.25, alignment: .center)
        .padding(2)
        .background(Color.white
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}

struct PhotoCardSheet: View {
    var PhotoCardDetail: PhotoCardInformation
    var body: some View {
        VStack (alignment: .leading){
            Image(PhotoCardDetail.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
            
            Text(PhotoCardDetail.photoText)
                .foregroundColor(.bodyTextColor)
                .bold()
                .padding(.leading, 12)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.45, alignment: .center)
        .padding(10)
        .background(Color.white
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}

struct CalendarBaws: PreviewProvider {
    static var previews: some View {
        PhotoCardsView()
    }
}
