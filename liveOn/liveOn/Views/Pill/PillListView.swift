//
//  PillListView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/13.
//

import SwiftUI

struct PillListView: View {
    var body: some View {
        
        ScrollView {
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10) {
                
                //  n
                ForEach(0..<pillList.count, id: \.self) { index in
                    
                    PillCardView(content: pillList[index])
                    
                }
            }
        }
        .navigationTitle("약")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
    } // body
}

struct PillListView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillListView()
        
    }
}

struct PillCardView: View {
    
    var content: Pill
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 12, x: 1, y: 1)
                .opacity(0.14)
            
            VStack(alignment: .center) {
                
                Image("medicine")
                
                VStack(alignment: .center) {
                    
                    // MARK: 약 이름
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke()
                            .frame(width: CGFloat(content.name.count) * 16 + 8, height: 24, alignment: .center)
                            .foregroundColor(.green)
                        
                        Text("\(content.name)")
                            .foregroundColor(.green)
                        
                    } // ZStack
                    
                    Text("\(content.prescribedDate)")
                        .foregroundColor(.green)
                        .font(.system(size: 12))
                    
                } // VStack
            } // VStack
            .padding(.bottom, 12)
            
        } // ZStack
        .padding(.horizontal, 2)
        
    }
}
