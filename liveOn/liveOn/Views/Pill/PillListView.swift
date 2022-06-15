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

            ScrollView {
                ZStack {
                    VStack(alignment: .center) {
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 12) {
                            
                            ForEach(0..<pillList.count, id: \.self) { index in
                                
                                PillCardView(content: pillList[index])
                                    .onTapGesture {withAnimation(.linear(duration: 0.4)) {
                                        showPillPopUp = true
                                        clickedPillIndex = index
                                        
                                    }
                                    }
                                /*
                                 클릭이 가능한 것들은 스크롤뷰 안에 들어갈 수 없습니까???
                                 버튼으로도 시도해보고 온탭제스쳐로도 해봤는데 둘 다 스크롤 뷰를 똥으로 만들어버림
                                 */
                                
                            } // ForEach
                        } // LazyVGrid
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                    
                    Color.white.opacity(showPillPopUp ? 0.6 : 0).edgesIgnoringSafeArea(.all)
                    
                    if showPillPopUp {
                        // show Pill effect PopUp
                        
                        PillPopUpView(showPillPopUp: $showPillPopUp, indexOfCard: $clickedPillIndex)
                        
                    }
                } // ZStack
                
            }// ScrollView
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .navigationTitle("약")
            .navigationBarTitleDisplayMode(.inline)
        
    }// body
}

struct PillCardView: View {
    
    var content: Pill
    
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
                        Image("medicine")
                            .scaledToFit()
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.6)
                        
                    } // ZStack
                    
                    VStack(alignment: .center) {
                        
                        ZStack(alignment: .center) {
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: CGFloat(content.name.count) * 16 + 8, height: 24, alignment: .center)
                                .foregroundColor(.green)
                            
                            Text("\(content.name)")
                                .foregroundColor(.white)
                            
                        } // ZStack
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 72, height: 24, alignment: .center)
                                .foregroundColor(.white)
                                .opacity(0.7)
                            
                            Text("\(content.prescribedDate)")
                                .foregroundColor(.green)
                                .font(.system(size: 14))
                            
                        } // ZStack
                    } // VStack
                } // ZStack
                
                Divider()
                
                Text("\(content.sender)약국")
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
                    .font(.system(size: 16))
                
            } // VStack
            .padding(.bottom, 12)
            
        } // ZStack
        .padding(.horizontal)
        
    } // body
}

// MARK: Preview
struct PillListView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillListView()
        
    }
}
