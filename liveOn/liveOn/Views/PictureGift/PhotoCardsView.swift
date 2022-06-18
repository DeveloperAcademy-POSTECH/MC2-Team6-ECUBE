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
    
    var columns: [GridItem] = Array(repeating: GridItem(GridItem.Size.fixed(174)), count: 2)
    
    var body: some View {
        
        ScrollView {
            HStack(alignment: .center, spacing: 12) {
                
                // 샘플 데이터들이 반복문으로 그려지는 곳
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(temporaryData, id: \.self) { data in
                        
                        Button(action: {
                            isTapped.toggle()
                        }) {
                            PhotoCard(PhotoCardDetail: data)
                        }
                    } // ForEach
                    
                    // 전달 받은 사진이 표시되는 곳
                    // LoadedPhotoCard(imageURL: loadedImage.giftPolaroidImage)
                    
                } // LazyVGrid
                .frame(width: .infinity, alignment: .center)
                .opacity(isTapped ? 0.2 : 1)
                .onTapGesture {
                    isTapped.toggle()
                }
            } // ScrollView
            .edgesIgnoringSafeArea(.horizontal)
            .padding(.top)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                imageGet()
                print("이미지 로딩이 수행되었습니다.")
                PhotoGiftDataList.append(PhotoGiftData(photoURL: loadedImage.giftPolaroidImage, photoComment: loadedImage.userNickName))
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        //                                .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("사진 선물함")
                        .foregroundColor(.black)
                }
                
            }
        }
        .background(Color.background)
        
        if isTapped == true {
            Button(action: {
                isTapped.toggle()
            }) {
                PhotoCardSheet(PhotoCardDetail: temporaryData[1])
            }
        }
        
    } // body
    
    
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

// MARK: PhotoCard
struct PhotoCard: View {
    
    var PhotoCardDetail: PhotoCardInformation
    
    var body: some View {
        
        ZStack {
            // 폴라로이드 연출을 위한 흰 네모
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 6, x: 2, y: 2).opacity(0.8)
            
            VStack(alignment: .leading, spacing: 5) {
                
                // 사진이 들어가는 곳
                ZStack {
                    
                    // TODO: 정해진 네모 프레임 안에 사진 꽉 차게(비율은 그대로 찌그러지지 않게) 할 것
                    Rectangle()
                        .foregroundColor(.black)
                        .opacity(0.88)
                    
                    Rectangle()
                        .foregroundColor(.white.opacity(0.0))
                        .background(                    Image(PhotoCardDetail.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .clipped())
                        .frame(width: 164, height: 192, alignment: .center)
                }
                .padding(.top, 10)
                .padding(.horizontal, 6)
                
                VStack(alignment: .leading, spacing: 6) {
                    Rectangle()
                        .foregroundColor(.placeHolderColor)
                        .frame(width: 88, height: 5)
                        .cornerRadius(15)
                    
                    Rectangle()
                        .foregroundColor(.placeHolderColor)
                        .frame(width: 66, height: 5)
                        .cornerRadius(15)
                        .padding(.bottom, 6)
                    
                } // VStack
                .padding(.vertical, 6)
                .padding(.leading, 8)
                
            } // VStack
        } // ZStack
    } // body
}

struct LoadedPhotoCard: View {
    
    var imageURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            AsyncImage(url: URL(string: imageURL), scale: 2) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.36, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
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
        .background(Color.white
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
    }
}

struct PhotoCardSheet: View {
    
    var PhotoCardDetail: PhotoCardInformation
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(PhotoCardDetail.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.4, alignment: .center)
            
            Text(PhotoCardDetail.photoText)
                .setHandWritten()
                .foregroundColor(.bodyTextColor)
//                .bold()
//                .padding(.leading, 6)
//                .padding(.vertical, 8)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.45, alignment: .center)
        .padding(8)
        .padding(.top, 4)
        .padding(.bottom, 12)
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
