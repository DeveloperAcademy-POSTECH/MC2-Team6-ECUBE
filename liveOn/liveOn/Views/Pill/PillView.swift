//
//  PillView.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/07.
//

import SwiftUI

struct PillView: View {
    var body: some View {
        
        VStack {
            
            PillHeaderView()
            PillBodyView()
            
        }
    }
}


struct PillHeaderView: View {
    var body: some View {
        
        Text("I'm the header")
        
    }
}

struct PillBodyView: View {
    var body: some View {
        
        Text("I'm the body")
        

    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        
        PillView()
        
    }
}
