//
//  liveOnApp.swift
//  liveOn
//
//  Created by 이성민 on 2022/06/03.
//

import SwiftUI

@main
struct LiveOnApp: App {
<<<<<<< HEAD:liveOn/liveOn/LiveOnApp.swift
    
=======
    @StateObject var ImageModel = ImageViewModel()
>>>>>>> dev:liveOn/liveOn/System/liveOnApp.swift
    var body: some Scene {
        WindowGroup {
            PictureGiftView()
                .environmentObject(ImageModel)
        }
    }
}
