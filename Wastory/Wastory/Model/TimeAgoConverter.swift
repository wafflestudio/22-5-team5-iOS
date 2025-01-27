//
//  TimeAgoConverter.swift
//  Wastory
//
//  Created by 중워니 on 1/23/25.
//

import Foundation

func timeAgo(from date: Date) -> String {
    let secondsAgo = Int(Date().timeIntervalSince(date))// - (60 * 60 * 9)
    
    switch secondsAgo {
    case 0..<60:
        return "\(secondsAgo)초 전"
    case 60..<(60 * 60):
        let minutes = secondsAgo / 60
        return "\(minutes)분 전"
    case (60 * 60)..<(60 * 60 * 24):
        let hours = secondsAgo / (60 * 60)
        return "\(hours)시간 전"
    case (60 * 60 * 24)..<(60 * 60 * 24 * 7):
        let days = secondsAgo / (60 * 60 * 24)
        return "\(days)일 전"
    default:
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        return formatter.string(from: date)
    }
}

func timeFormatter(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy. MM. dd. HH:mm"
    return formatter.string(from: date)
}
