//
//  Util.swift
//  Week3
//
//  Created by 정재욱 on 10/3/23.
//

import Foundation

func convertNumberToString(price: Int) -> String {
    let num = (price>1000000) ? (price/10000) : price
    let numberFormatter: NumberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    
    return numberFormatter.string(for: num)! + ((price>1000000) ? "만" : "")
}

func calcTimeDiff(date: String) -> String {
    let nowDate = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let postedDate = dateFormatter.date(from: date)!
    
    let time = Int(nowDate.timeIntervalSince(postedDate))
    if(time/60/60/24 > 0) {
        return String(time/60/60/24) + "일 전"
    }
    else if(time/60/60 > 0) {
        return String(time/60/60) + "시간 전"
    }
    else if(time/60 > 0) {
        return String(time/60) + "분 전"
    }
    else {
        return String(time) + "초 전"
    }
}
