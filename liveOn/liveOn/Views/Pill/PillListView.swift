//
//  PillListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct PillListView: View {
    
    @State var showPillPopUp = false
    @State var clickedPillIndex = 0
    
    var body: some View {

        ZStack {
            ScrollView {
                    ZStack {
                        VStack(alignment: .center) {
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                                
                                ForEach(0..<pillList.count, id: \.self) { index in
                                    
                                    PillCardView(content: pillList[index])
                                        .onTapGesture {withAnimation(.linear(duration: 0.5)) {
                                            showPillPopUp = true
                                            clickedPillIndex = index
                                            
                                        }
                                        }
                                } // ForEach
                            } // LazyVGrid
                            .padding(.vertical, 32)
                            
                        }
                        
                        .padding(.horizontal, 16)
                       
                            .edgesIgnoringSafeArea(.all)
                        
                    } // ZStack
                    .blur(radius: showPillPopUp ? 5 : 0)
                    Color(uiColor: .systemBackground).opacity(showPillPopUp ? 0.5 : 0)
                    
                }// ScrollView
          
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
           
            if showPillPopUp {
                // show Pill effect PopUp
                PillPopUpView(showPillPopUp: $showPillPopUp, indexOfCard: $clickedPillIndex)
                
            }
            
        }
        .background(Color.background)
        .navigationTitle("약")
        .navigationBarTitleDisplayMode(.inline)
        
    }// body
}

extension PillCardView {
    func getRandomPillImage() -> String {
        return "medicine0" + String(Int.random(in: 0 ..< 8))
    }
}

struct PillCardView: View {
    
    let content: Pill
    @State var medicineImage = "medicine00"
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.white)
                .frame(width: 168)
                .shadow(color: .gray, radius: 12, x: 1, y: 1)
                .opacity(0.14)
            
            VStack(alignment: .center) {
                
                ZStack {
                    
                    ZStack {
                        Image(medicineImage)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.height*0.2, alignment: .center)
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.6)
                        
                    } // ZStack
                    
                    VStack(alignment: .center) {
                        
                        ZStack(alignment: .center) {
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: CGFloat(content.name.count) * 16 + 8, height: 24, alignment: .center)
                                .foregroundColor(content.sender == "재헌" ? Color.green : Color(hex: "DB5E5E"))
                            
                            Text("\(content.name)")
                                .foregroundColor(.white)
                            
                        } // ZStack
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 72, height: 24, alignment: .center)
                                .foregroundColor(.white)
                                .opacity(0.7)
                            
                            Text("\(content.prescribedDate)")
                                .foregroundColor(content.sender == "재헌" ? Color.green : Color(hex: "DB5E5E"))
                                .font(.system(size: 14))
                            
                        } // ZStack
                    } // VStack
                } // ZStack
                
                Divider()
                
                Text("\(content.sender)약국")
                    .fontWeight(.heavy)
                    .foregroundColor(content.sender == "재헌" ? Color.green : Color(hex: "DB5E5E"))
                    .font(.system(size: 16))
                
            } // VStack
            .padding(.bottom, 12)
            
        } // ZStack
        .padding(.horizontal)
        .onAppear {
            medicineImage = getRandomPillImage()
        }
        
    } // body
}

// MARK: Preview
struct PillListView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillListView()
        
    }
}
