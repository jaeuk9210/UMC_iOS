//
//  Data.swift
//  Week3
//
//  Created by 정재욱 on 10/3/23.
//

import Foundation

struct Post {
    let title: String
    let imageURL: String
    let location: String
    let price: Int?
    let time: String
    let comment: Int?
    let like: Int?
    let rePost: Bool
    let isReservation: Bool
    let isDone: Bool
    let isShare: Bool
}

let data: [Post] = [
    Post(title: "0.7 샤프심(일괄)",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "새솔동",
         price: 0,
         time: "2023-10-03 16:30:30",
         comment: nil,
         like: 1,
         rePost: true,
         isReservation: false,
         isDone: true,
         isShare: true
        ),
    Post(title: "스위치게임팩2개팝니다",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "새솔동", 
         price: 60000,
         time: "2023-10-03 16:35:30",
         comment: 10,
         like: 2,
         rePost: false,
         isReservation: false,
         isDone: false,
         isShare: false
        ),
    Post(title: "(L)스톤아일랜드 정품 맨투맨 !! 상태최강",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "새솔동", 
         price: 125000,
         time: "2023-10-03 19:30:30",
         comment: 5,
         like: 7,
         rePost: false,
         isReservation: true,
         isDone: false,
         isShare: false
        ),
    Post(title: "폴드5 톰브라운에디션 판매",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "사동", 
         price: 4600000,
         time: "2023-10-03 22:30:30",
         comment: 2,
         like: nil,
         rePost: true,
         isReservation: false,
         isDone: true,
         isShare: false
        ),
    Post(title: "beats studio buds",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "해양동", 
         price: 130000,
         time: "2023-10-04 23:03:30",
         comment: nil,
         like: nil,
         rePost: false,
         isReservation: false,
         isDone: false,
         isShare: false
        ),
    Post(title: "닌텐도스위치 스포츠 칩(전구성 일체)",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "해양동", 
         price: 40000,
         time: "2023-10-03 23:03:30",
         comment: nil,
         like: nil,
         rePost: false,
         isReservation: false,
         isDone: false,
         isShare: false
        ),
    Post(title: "아이맥",
         imageURL: "https://source.unsplash.com/random/150x150",
         location: "본오동", 
         price: 200000,
         time: "2023-10-01 23:03:30",
         comment: 1,
         like: 3,
         rePost: false,
         isReservation: false,
         isDone: false,
         isShare: false
        ),
]
