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
let testData1 = PhotoCardInformation(imageName: "exampleImage1", photoText: "WWDC 오프닝!")
let testData2 = PhotoCardInformation(imageName: "exampleImage2", photoText: "김치 찌개 맛집")
let testData3 = PhotoCardInformation(imageName: "picture", photoText: "추억의 00 사진")
