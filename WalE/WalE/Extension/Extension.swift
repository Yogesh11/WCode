//
//  Extension.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 20/03/22.
//

import Foundation
extension Date {
    func getCurrentDate(_ format : String = "YYYY-MM-dd") -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = format
        return formatter3.string(from: self)
    }
}
