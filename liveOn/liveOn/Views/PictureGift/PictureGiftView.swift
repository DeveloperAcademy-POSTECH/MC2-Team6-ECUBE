import SwiftUI

struct PictureGiftView: View {
    @EnvironmentObject var imageViewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var comment: String = ""
    
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
                            .foregroundColor(.black)
                            .background(.gray)
                    }
                }
                TextField("Comment", text: $comment, prompt: Text("한 줄 편지를 써주세요!"))
                    .frame(width: 300, height: 20, alignment: .leading)
                HStack {
                    Text(comment.count <= 20 ? "\(comment.count)/20" : "20/20")
                        .frame(width: 300, height: 20, alignment: .trailing)
                }
            }
            .padding()
            .background(Color.white
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            // 상단바 커스텀
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
                    NavigationLink(destination: Text("선물하기")) {
                        Text("선물하기")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("선물 종류 선택")
                        .foregroundColor(.black)
                }
            }
            // 앨범 접근 및 사진선택
            .sheet(isPresented: $imageViewModel.showPicker) {
                ImagePicker(sourceType: imageViewModel.source == .library ? .photoLibrary : .camera, selectedImage: $imageViewModel.image)
                    .ignoresSafeArea()
            }
        } // 화면 내 다른 곳 터치시 키보드 숨기기
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PictureGiftView()
            .environmentObject(ViewModel())
    }
}
