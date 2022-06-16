//
//  VoicemailListView_.swift
//  liveOn
//
//  Created by Jineeee on 2022/06/16.
//

import SwiftUI

struct VoicemailsView: View {
    
    //    private let communication = ServerCommunication()
    @State var loadedVM: [VoicemailListGetResponse] = []
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            if voiceMailDummy.count > 8 {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 16) {
                            ForEach(voiceMailDummy) { vm in
                                VoicemailCassette(voiceMail: vm)
                            }
                            //            }
                            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            //            .background(.blue)
                        }
                        .padding(12)
                        .border(.thinMaterial, width: 1)
                        .background(.regularMaterial)
                        .padding(16)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("카세트테이프")
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Color.background)
                }
            } else {
                VStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 16) {
                        ForEach(voiceMailDummy) { vm in
                            VoicemailCassette(voiceMail: vm)
                        }
                        //            }
                        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //            .background(.blue)
                    }
                    .padding(12)
                    .border(.thinMaterial, width: 1)
                    .background(.regularMaterial)
                    .padding(16)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("카세트테이프")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.background)
            }
            
            Button(action: {
                vmGet()
                print("vm: \(loadedVM)")
            }) {
                Text("click")
            }
        }
        
    }
    
    func vmGet() {
        moyaService.request(.voicemailListGet) { response in
            switch response {
            case .success(let result):
                do {
                    loadedVM = try result.map([VoicemailListGetResponse].self)
                } catch let err {
                    print(err.localizedDescription)
                    print("음성메시지를 디코딩하는데 실패했습니다")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

var voiceMailDummy = [
    Voicemail(title: "재허나뭐해잉", createDate: "220616", whoSent: mailConstants.user1, vmBackgroundColor: mailConstants.green, vmIconImageName: "flower", soundLength: "00:48"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유sdf잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐fsd잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "fdsower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39"),
    Voicemail(title: "유지나뭐해잉", createDate: "220314", whoSent: mailConstants.user2, vmBackgroundColor: mailConstants.orange, vmIconImageName: "flower", soundLength: "00:39")
    
]

struct VoicemailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VoicemailsView()
        }
    }
}

////
////  photoCardsView.swift
////  liveOn
////
////  Created by Jisu Jang on 2022/06/08.
////
//
// import SwiftUI
//
// struct PhotoCardsView: View {
//    @Environment(\.dismiss) private var dismiss
//    @StateObject var imageModel: ImageViewModel
//    @State var loadedImage = ImageGetResponse(createdAt: "", giftPolaroidId: 0, giftPolaroidImage: "", userNickName: "")
//    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//    private let temporaryData: [PhotoCardInformation] = [testData1, testData2, testData3, testData4]
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(temporaryData, id: \.self) { data in
//                    PhotoCard(PhotoCardDetail: data)
//                        .background(Color.white
//                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
//                        .padding(5)
//                }
//
//                AsyncImage(url: URL(string: loadedImage.giftPolaroidImage), scale: 2){ image in
//                    image
//                      .resizable()
//                      .aspectRatio(contentMode: .fill)
//                } placeholder: {
//                    ProgressView()
//                        .progressViewStyle(.circular)
//                }
//                    .frame(height: 240)
//
//            }
//            .frame(maxWidth: .infinity)
//        }
//        .task {
//            imageGet()
//            print("이미지 로딩이 수행되었습니다.")
//        }
//        .padding()
//        .background(Color.background)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                        .font(.system(size: 20))
//                        .foregroundColor(.black)
//                }
//            }
//            ToolbarItem(placement: .principal) {
//                Text("사진 선물함")
//                    .foregroundColor(.black)
//            }
//        }
//    }
//    func imageGet() {
//        moyaService.request(.imageGet) { response in
//            switch response {
//            case .success(let result):
//                do {
//                    loadedImage = try result.map(ImageGetResponse.self)
//                } catch(let err) {
//                    print(err.localizedDescription)
//                    print("이미지를 디코딩하는데 실패했습니다")
//                }
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
//    }
// }
//
// struct PhotoCardInformation: Hashable {
//    var imageName: String
//    var photoText: String
// }
//
// let testData1 = PhotoCardInformation(imageName: "exampleImage1", photoText: "테스트1")
// let testData2 = PhotoCardInformation(imageName: "exampleImage2", photoText: "테스트2")
// let testData3 = PhotoCardInformation(imageName: "flower", photoText: "테스트3")
// let testData4 = PhotoCardInformation(imageName: "heart", photoText: "테스트4")
//
// struct PhotoCard: View {
//    var PhotoCardDetail: PhotoCardInformation
//    var body: some View {
//        VStack {
//            Image(PhotoCardDetail.imageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
//
//            Text(PhotoCardDetail.photoText)
//                .foregroundColor(.bodyTextColor)
//        }
//        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25, alignment: .center)
//        .padding()
//    }
// }
//
// struct CalendarBaws: PreviewProvider {
//    static var previews: some View {
//        PhotoCardsView(imageModel: ImageViewModel())
//    }
// }
//
