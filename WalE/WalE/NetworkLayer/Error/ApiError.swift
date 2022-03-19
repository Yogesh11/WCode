//
//  ApiError.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//

import Foundation

struct ApiError : Codable {
    var code              : Int?
    var msg               : String?
    var service_version   : String?
    
    mutating func makeDefault(){
        
    }
    static func defaultSetup(code : Int? = 1000 , msg: String? = NetworkResponse.failed.rawValue , service_version : String? = "V1") ->ApiError {
        ApiError(code: code, msg: msg, service_version: service_version)
    }
}

