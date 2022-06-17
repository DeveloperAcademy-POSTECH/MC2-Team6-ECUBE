//
//  Test.swift
//  liveOn
//
//  Created by Keum MinSeok on 2022/06/16.
//

// import SwiftUI
//
// struct DataInfo: Hashable {
//    var emoji: String
//    var Date: String
//    var eventTitle: String
//    var eventMemo: String
// }
//
// struct expero: View {
//    @State var testList: [DataInfo] = [
//        DataInfo(emoji: "🎲", Date: "06/20", eventTitle: "발표하는 날", eventMemo: "이큐브 팀 화이팅!")]
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                testList.append(DataInfo(emoji: "🎲", Date: "", eventTitle: "", eventMemo: ""))
//            }) {
//                Text("기념일을 추가해보자!")
//            }
//            
//            ForEach(testList, id: \.self) { event in
//                testArray(testData: event)
//            }
//        }
//    }
// }
//
// struct testArray: View {
//    var testData: DataInfo
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.cyan)
//                .frame(width: 355, height: 66)
//            
//            HStack {
//                Capsule()
//                    .fill(Color("Burgundy"))
//                    .frame(width: 38, height: 8)
//                    .rotationEffect(Angle(degrees: 90))
//                    .padding(.trailing, 14)
//                
//                VStack {
//                    // emoji
//                    Text(testData.emoji)
//                        .font(.system(size: 28))
//                        .padding(.bottom, -5)
//                    
//                    //  eventDate
//                    Text(testData.Date)
//                        .font(.system(size: 13))
//                        .foregroundColor(Color("Burgundy"))
//                }
//                .padding(.leading, -21)
//                
//                VStack {
//                    //  eventTitle
//                    Text(testData.eventTitle)
//                        .foregroundColor(Color("Burgundy"))
//                        .font(.system(size: 18).bold())
//                        .frame(width: 280, alignment: .leading)
//                        .padding(.trailing, -30)
//                        .padding(.bottom, 3)
//                    
//                    // eventMemo
//                    Text(testData.eventMemo)
//                        .foregroundColor(.gray)
//                        .font(.system(size: 14))
//                        .frame(width: 280, alignment: .leading)
//                        .padding(.trailing, -32)
//                }
//                .padding(.leading, 6)
//            }
//            .padding(.leading, -45.5)
//        }
//        .padding(.top, 2)
//    }
// }
//
// struct expero_Previews: PreviewProvider {
//    static var previews: some View {
//        expero()
//    }
// }
