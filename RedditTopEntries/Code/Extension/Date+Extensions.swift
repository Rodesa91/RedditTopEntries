//
//  Date+Extensions.swift
//  RedditTopEntries
//
//  Created by Rodrigo De Santiago on 9/11/19.
//  Copyright © 2019 Rodrigo De Santiago. All rights reserved.
//

import Foundation

extension Date {
    
    func dateTimeAgo(sinceDate: Date) -> String {
        let(years, months, days, hours, mins,secs) = getDifference(sinceDate: sinceDate)
        
        guard let year = years,
            let month = months,
            let day = days,
            let hour = hours,
            let min = mins,
            let sec = secs else {
                return ""
        }
        
        if year < 1 {
            if month < 1 {
                if day < 1 {
                    if hour < 1 {
                        if min < 1 {
                            if sec < 1 {
                                return "Just Now"
                            } else {
                                return sec.description + " seconds ago"
                            }
                        } else {
                            return min.description + " minutes ago"
                        }
                    } else {
                        return hour.description + " hours ago"
                    }
                } else {
                    return day.description + " days ago"
                }
            } else {
                return month.description + " months ago"
            }
        } else {
            return year.description + " years ago"
        }
    }
    
    func getDifference(sinceDate: Date) ->  (years:Int?, months:Int?, days:Int?, hours:Int?,mins:Int?,secs:Int?) {
        let years = Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
        let months = Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
        let days = Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
        let hours = Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
        let minutes = Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
        let seconds = Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
        
        return (years,months,days,hours,minutes,seconds)
    }
    
}

