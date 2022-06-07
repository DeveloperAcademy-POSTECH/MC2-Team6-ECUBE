//
//  FlowerView.swift
//  Memorize
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

struct FlowerView: View {
    var body: some View {
        
        FlowerHeaderView()
        
    }
}

struct FlowerHeaderView: View {
    var body: some View {
        
        HStack {
            Text("<")
            
            Text("꽃")
                .fontWeight(.semibold)
            
            Button("선물하기") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                // Submit 기능
            }
            
        }
        
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
