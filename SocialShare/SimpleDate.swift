//
//  SimpleDate.swift
//  SocialShare
//
//  Created by Joseph Kim on 2/20/17.
//  Copyright © 2017 Joseph Kim. All rights reserved.
//

import Foundation

/// This singleton class deals with Date related operations
class SimpleDate {
    
    private static let _instance = SimpleDate()
    
    static var instance: SimpleDate {
        return _instance
    }
    
    enum StringType {
        case date
        case time
    }
    
    func toString(date: Date, type: StringType) -> String {
        let dateFormatter = DateFormatter()
        switch type {
        case .date: dateFormatter.dateFormat = "MMMM dd, yyyy"
        case .time: dateFormatter.dateFormat = "hh:mm a zzz"
        }
        return dateFormatter.string(from: date)
    }
    
    func timeAgoSinceDate(date: Date) -> String {
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let today = Date()
        let components = calendar.dateComponents(unitFlags, from: date,  to: today)
        
        // Below matches calculated time components above from year to seconds
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            return "Last year"
        }
        
        if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            return "Last month"
        }
        
        if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            return "Last week"
        }
        
        if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            return "Yesterday"
        }
        
        if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            return "An hour ago"
        }
        
        if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            return "A minute ago"
        }
        
        if (components.second! >= 5) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
}
