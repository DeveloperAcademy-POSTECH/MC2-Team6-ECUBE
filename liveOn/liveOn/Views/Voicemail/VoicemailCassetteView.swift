import SwiftUI

struct VoicemailCassetteView: View {

    @Binding var title: String
    @FocusState private var isFocused: Bool

    let nowDate = Date.now

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 140)

            // 제목을 voiceMailVM 클래스에도 추가해야 하지 않을까?
            // TODO: on tap outside keyboard hide
            TextField("제목을 입력하세요", text: $title)
                .multilineTextAlignment(.center)
                .frame(width: 300, height: 20)
                .focused($isFocused)

            Text(DateToString(_:nowDate))
                .foregroundColor(Color.bodyTextColor)

            Image("cassette_horizontal")
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                .padding()

            Spacer()
        }
    }
}

// struct VoicemailMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoicemailMainView(title: $title)
//    }
// }
