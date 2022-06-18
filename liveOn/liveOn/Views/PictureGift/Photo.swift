//
//  Photo.swift
//  liveOn
//
//  Created by 김보영 on 2022/06/17.
//

import Foundation

struct PhotoCardInformation: Hashable {
    
    var imageName: String
    var photoText: String
    
}

struct PhotoGiftData: Hashable {
    
    var photoURL: String
    var photoComment: String
    
}

// Sample data
var temporaryData: [PhotoCardInformation] = [
    
    PhotoCardInformation(
        imageName: "exampleImage1",
        photoText: "WWDC 오프닝!"),
    
    PhotoCardInformation(
        imageName: "photo_picnic",
        photoText: "날씨 좋다고 즉흥으로 소풍갔던 날"),
    // 사진 출처 : https://unsplash.com/photos/NdcH-WxzWgo
    
    PhotoCardInformation(
        imageName: "photo_wedding",
        photoText: "추억의 웨딩 사진"),
    // 사진 출처 : https://unsplash.com/photos/w5hhoYM_JsU
    
    PhotoCardInformation(
        imageName: "photo_sky",
        photoText: "별 보러 갔던 날"),
    // 사진 출처 : https://unsplash.com/photos/5LOhydOtTKU
    
    PhotoCardInformation(
        imageName: "photo_aquarium",
        photoText: "아쿠아리움에서 해파리만 보다가 온 사진")
    // 사진 출처 : https://unsplash.com/photos/5LOhydOtTKU

]
