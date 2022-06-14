import SwiftUI

struct PhotoGiftView: View {
    @EnvironmentObject var imageModeling: imageViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject var imageModel = imageViewModel()
    @State private var comment: String = ""
    @State private var showAlertforSend: Bool = false
    @State private var isTapped: Bool = false
    var commentLimit: Int = 20
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.white)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    imageViewModel.source = .library
                    imageViewModel.showPhotoPicker()
                } label: {
                    if let image = imageViewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 400)
                    } else {
                        Text("사진을 선택해주세요!")
                            .frame(width: 300, height: 400, alignment: .center)
                            .background(.gray)
                            .foregroundColor(.bodyTextColor).opacity(0.5)
                    }
                }
                TextField("Comment", text: $comment, prompt: Text("한 줄 편지를 써주세요!"))
                    .limitInputLength(value: $comment, length: 20)
                    .foregroundColor(.bodyTextColor)
                    .frame(width: 300, height: 20, alignment: .leading)
                HStack {
                    
                    Text("\(comment.count)/20")
                        .frame(width: 300, height: 20, alignment: .trailing)
                        .foregroundColor(.bodyTextColor).opacity(0.5)
                }
                
                NavigationLink("", destination: PhotoCardsView(), isActive: $isTapped)
            }
            .padding()
            .background(Color.white
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlertforSend = true
                    }) {
                        Text("선물하기")
                            .foregroundColor(.black)
                    }
                    .alert(isPresented: $showAlertforSend) {
                        Alert(title: Text("선물 보내기"), message: Text("선물은 하루에 하나만 보낼 수 있어요. 사진을 보낼까요?"),
                              primaryButton: .cancel(Text("취소")),
                              secondaryButton: .default(Text("보내기")) {
                            isTapped.toggle()
                            imagePost()
                        })
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("선물 종류 선택")
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $imageModel.showPicker) {
                ImagePicker(sourceType: imageModel.source == .library ? .photoLibrary : .camera, selectedImage: $imageModel.image)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func imagePost() {
        moyaService.request( .imagePost(content: "ddd", image: imageModel.image!)) { response in
//            print(imageModel.image)
            switch response {
                // 응답이 성공한다면
            case .success(let result):
                do{
                    print("전송되는 이미지 데이터는 다음과 같습니다 : \(imageModel.image!)")
                    testImageData = try result.map(ImageTestResponse.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

struct PictureGiftView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGiftView()
            .environmentObject(imageViewModel())
    }
}
 
