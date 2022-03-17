//
//  CurrentDate.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/17.
//

import Foundation

//현재시간을 한국시간으로 표시해줌
func koreanDate() -> String{
    let current = Date()
    
    let formatter = DateFormatter()
    //한국 시간으로 표시
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    //형태 변환
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return formatter.string(from: current)
}
