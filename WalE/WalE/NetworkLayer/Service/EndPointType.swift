//
//  EndPoint.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

