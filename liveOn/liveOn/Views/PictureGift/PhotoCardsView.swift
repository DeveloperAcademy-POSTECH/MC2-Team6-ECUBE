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
    
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
            ZStack {
            ScrollView {
                VStack(spacing: 12) {
                    
                    // 샘플 데이터들이 반복문으로 그려지는 곳
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(temporaryData, id: \.self) { data in
                            
                            Button(action: {
                                withAnimation(.easeIn){
                                    isTapped.toggle()
                                }
                            }) {
                                PhotoCard(PhotoCardDetail: data, isTapped: $isTapped)
                                    .padding(4)
                            }
                            
                            
                        } // ForEach
                        
                        // 전달 받은 사진이 표시되는 곳
                        // LoadedPhotoCard(imageURL: loadedImage.giftPolaroidImage)
                        
                    } // LazyVGrid
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
                .padding()
                }
            .blur(radius: isTapped ? 6 : 0)
            }
        .background(Color.background)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea( edges: .bottom)
        
        .overlay {
            if isTapped {
                PhotoCardSheet(PhotoCardDetail: temporaryData[1])
                    .onTapGesture {
                        withAnimation(.easeIn){
                            isTapped.toggle()
                        }
                    }
            }
        }
       Circle()
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
    @Binding var isTapped : Bool
    var body: some View {

        
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading) {
                Image(PhotoCardDetail.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width*0.85, height: proxy.size.width, alignment: .center)
                    .clipped()
                    .border(Color.gray, width: 1.0)
                Text(PhotoCardDetail.photoText)
                    .setHandWritten()
                    .padding(.horizontal, 4)
                    .multilineTextAlignment(.leading)
                    .frame(width: proxy.size.width*0.8, alignment: .center)
                }
                .foregroundColor(.bodyTextColor)
                .padding(12)
              
            }
            .padding(.bottom, 12)
            .background(RoundedRectangle(cornerRadius: 6).fill(.thickMaterial)  .border(Color.shadowColor, width: 1.0).shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 0))


        }
        .frame(height: 240)
        .onTapGesture {
            isTapped.toggle()
        }
    } // body
}

struct LoadedPhotoCard: View {
    
    var imageURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            AsyncImage(url: URL(string: imageURL), scale: 2) { image in
                image
                    .resizable()
                  //  .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.36, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
                    .clipped()
                
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
