//
//  CustomPatterns+DateFormatter.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 07/12/2022.
//

import Foundation

extension DateFormatter {
    
    private static var dateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return formatter
    }()
    
    enum CustomPattern {
        case dateAndTime
        
        var formatter: DateFormatter {
            switch self {
            case .dateAndTime:
                return .dateAndTimeFormatter
            }
        }
    }
    
    static func format(date: Date, to customPattern: CustomPattern) -> String {
        return customPattern.formatter.string(from: date).uppercased()
    }
    
}
