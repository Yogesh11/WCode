//
//  PlanetEndPoint.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum PlanetApi {
    case aPOD
}

extension PlanetApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.nasa.gov/planetary/apod?"
        case .qa: return "https://api.nasa.gov/planetary/apod?"
        case .staging: return "https://api.nasa.gov/planetary/apod?"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .aPOD:
            return  "" //"\(id)/recommendations"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .aPOD :
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["date":"2022-03-19",
                                                      "api_key":NetworkManager.apiKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


