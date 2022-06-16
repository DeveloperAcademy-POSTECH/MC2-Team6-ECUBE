//
//  photoCardsView.swift
//  liveOn
//
//  Created by Jisu Jang on 2022/06/08.
//

import SwiftUI

struct PhotoCardsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var imageModel: ImageViewModel
    @State var loadedImage = ImageGetResponse(createdAt: "", giftPolaroidId: 0, giftPolaroidImage: "", userNickName: "")
    @State private var PhotoGiftDataList: [PhotoGiftData] = []
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var temporaryData: [PhotoCardInformation] = [testData1, testData2, testData3, testData4]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(temporaryData, id: \.self) { data in
                    PhotoCard(PhotoCardDetail: data)
                        .background(Color.white
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
                        .padding(5)
                    
                    ForEach(PhotoGiftDataList, id: \.self) { imageData in
                        LoadedPhotoCard(PhotoCardDetail: imageData)
                    }
                    
                    AsyncImage(url: URL(string: loadedImage.giftPolaroidImage))
                        .frame(width: 300, height: 300, alignment: .center)
                }
            }
            .frame(maxWidth: .infinity)
        }
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

let testData1 = PhotoCardInformation(imageName: "exampleImage1", photoText: "테스트1")
let testData2 = PhotoCardInformation(imageName: "exampleImage2", photoText: "테스트2")
let testData3 = PhotoCardInformation(imageName: "flower", photoText: "테스트3")
let testData4 = PhotoCardInformation(imageName: "heart", photoText: "테스트4")

struct PhotoCard: View {
    var PhotoCardDetail: PhotoCardInformation
    var body: some View {
        VStack {
            Image(PhotoCardDetail.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            
            Text(PhotoCardDetail.photoText)
                .foregroundColor(.bodyTextColor)
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25, alignment: .center)
        .padding()
    }
}

struct LoadedPhotoCard: View {
    var PhotoCardDetail: PhotoGiftData
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: PhotoCardDetail.photoURL))
                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            
            Text(PhotoCardDetail.photoComment)
                .foregroundColor(.bodyTextColor)
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25, alignment: .center)
        .padding()
    }
}

struct CalendarBaws: PreviewProvider {
    static var previews: some View {
        PhotoCardsView(imageModel: ImageViewModel())
    }
}
