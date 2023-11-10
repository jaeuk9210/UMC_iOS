//
//  Data.swift
//  Week5
//
//  Created by 정재욱 on 10/28/23.
//

import Foundation

struct Store {
    let storeName: String
    let minPriceForDelivery: Int
    let menus: [Menu]
}

struct Menu {
    let menuTitle: String
    let discription: String?
    let imageURL: String?
    var optionGroups: [OptionGroup]
}

struct OptionGroup {
    let groupTitle: String
    let isRequired: Bool
    let maxChoice: Int
    var options: [Option]
}

struct Option {
    let optionTitle: String
    let price: Int
}

let data: Store = Store(
    storeName: "청년치킨 상록수점",
    minPriceForDelivery: 12000,
    menus: [
        Menu(
            menuTitle: "매운양념(반)",
            discription: nil,
            imageURL: "https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cm9hc3QlMjBjaGlja2VufGVufDB8fDB8fHww",
            optionGroups: [
                OptionGroup(
                    groupTitle: "가격",
                    isRequired: true,
                    maxChoice: 1,
                    options: [
                        Option(
                            optionTitle: "뼈,콜라X",
                            price: 11500
                        ),
                        Option(
                            optionTitle: "순살,콜라X",
                            price: 12500
                        )
                    ]
                ),
                OptionGroup(
                    groupTitle: "음료 추가",
                    isRequired: false,
                    maxChoice: 2,
                    options: [
                        Option(
                            optionTitle: "(추가)코카롤라 500ml",
                            price: 1500
                        ),
                        Option(
                            optionTitle: "(추가)코카콜라 1.25L",
                            price: 2500
                        ),
                        Option(
                            optionTitle: "(추가)코카콜라 제로 1.25L",
                            price: 3000
                        ),
                        Option(
                            optionTitle: "얼음컵",
                            price: 500
                        )
                    ]
                ),
                OptionGroup(
                    groupTitle: "치킨무, 소스 추가",
                    isRequired: false,
                    maxChoice: 4,
                    options: [
                        Option(
                            optionTitle: "치자무 추가",
                            price: 500
                        ),
                        Option(
                            optionTitle: "디핑소스 추가",
                            price: 500
                        ),
                        Option(
                            optionTitle: "양념소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "매운양념소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "마늘간장소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "매운간장소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "청양크림소스 추가",
                            price: 1500
                        ),
                        Option(
                            optionTitle: "와사비마요 소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "치즈할라피뇨 소스 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "화이트 소스(요거트 맛) 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "치블링 소스(매콤함을 더할때 강추) 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "치즈시즈닝(가루) 추가",
                            price: 1000
                        ),
                        Option(
                            optionTitle: "시그니처 3종소스(와사비마오,치즈할라피뇨,화이트) 추가",
                            price: 2000
                        )
                    ]
                )
            ]
        )
    ]
)
