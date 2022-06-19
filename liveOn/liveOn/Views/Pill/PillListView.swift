//
//  PillListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct PillListView: View {
    @Environment(\.dismiss) private var dismiss
    @State var showPillPopUp = false
    @State var clickedPill: Pill = Pill(name: "", color: "", effect: "", prescribedDate: "", sender: "", imageName: "")
    
    var body: some View {
        
        ZStack {
            VStack {
                ScrollView {
                    VStack(alignment: .center) {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 24) {
                            
                            ForEach(pillList, id: \.id) { pill in
                                
                                PillCardView(content: pill)
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.5)) {
                                            showPillPopUp = true
                                            clickedPill = pill
                                        }
                                    }
                            } // ForEach
                        } // LazyVGrid
                        .padding(.vertical, 32)
                    }
                    .padding(.horizontal, 16)
                    .edgesIgnoringSafeArea(.all)
                    
                }// ScrollView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            }
            .blur(radius: showPillPopUp ? 5 : 0)
            Color(uiColor: .systemBackground).opacity(showPillPopUp ? 0.5 : 0)
            
            if showPillPopUp {
                // show Pill effect PopUp
                PillPopUpView(clickedPill: clickedPill)
                // PillPopUpView()
            }
            
        }
        .background(Color.background)
        .onTapGesture {
            withAnimation(.easeOut) {
                showPillPopUp = false
            }
        }
        .navigationTitle("약")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea( edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .navigationToBack(dismiss)
        
    }// body
}

//extension PillCardView {
//    func getRandomPillImage() -> String {
//        return "medicine0" + String(Int.random(in: 0 ..< 8))
//    }
//}

struct PillCardView: View {
    
    let content: Pill
    //    @State var medicineImage = "medicine00"
    var body: some View {
        HStack {
            VStack {
         
                    VStack(alignment: .center, spacing: 1) {
                        VStack(alignment: .center, spacing: 4) {
                            Image("medicine0"+String(Int.random(in: 0..<8)))
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .padding()
                            Text(content.name)
                                .font(.title3)
                                .fontWeight(.bold)
                                .setHandWritten()
                            Text(content.prescribedDate)
                                .font(.caption)
                                .setHandWritten()
                        }
                        .setHandWritten()
                        Divider()
                            .padding(.top)
                        HStack(spacing: 4) {
                            Image(systemName: "cross.fill")
                            Text("\(content.sender)약국")
                                .fontWeight(.heavy)
                        }
                        .font(.system(size: 14))
                        .padding()
                        .foregroundColor(getPointColor(whoMade: content.sender))
                        .frame(maxWidth: .infinity, alignment: .center)
                    } // VStack
                 // ZStack
                .foregroundColor(Color.bodyTextColor)
                .frame(maxWidth: .infinity, maxHeight: 200)
                .border(Color.shadowColor, width: 4)
                .overlay(LinearGradient(colors: [.white, .clear], startPoint: .leading, endPoint: .bottomTrailing).blendMode(.hardLight).opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(RoundedRectangle(cornerRadius: 10).fill(.thickMaterial).shadow(color: Color(uiColor: .systemGray5), radius: 5, x: 0, y: 2))
            }
        }
        .padding(.horizontal, 8)
        //        .onAppear {
        //            medicineImage = getRandomPillImage()
        //        }
        
    } // body
    
    func getPointColor(whoMade: String) -> Color {
        switch whoMade {
        case "유진" :
            return Color.coralPink
        default :
            return Color.deepGreen
        }
    }
}

// MARK: Preview
//struct PillListView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        PillListView()
//
//    }
//}
