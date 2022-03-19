//
//  NetworkManager.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//


import Foundation

enum NetworkResponse:String {
    case success
    case failed = "Oops Something went wrong."
    case unableToDecode = "We could not decode the response."
    case noData = "Response returned with no data to decode."
    case noNetwork = "Please check your network connection."
}

enum Result<Value>{
    case success
    case failure(ApiError)
}

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let apiKey   = "Yo0Zzu3ciPNSqOsKetedcLjZNDlUcP3aR1NUFY5R"
    let router = Router<PlanetApi>()
    
    func getPlanetDetail(completion: @escaping (_ movie: Planet?,_ error: ApiError?)->()){
        router.request(.aPOD) { data, response, error in
            
            if error != nil, let err = error as? NSError {
                completion(nil, ApiError.defaultSetup(code: err.code, msg: error?.localizedDescription))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response, error: error, data: data)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, ApiError.defaultSetup(msg: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(Planet.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, ApiError.defaultSetup(msg: NetworkResponse.unableToDecode.rawValue))
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse , error : Error? , data : Data?) -> Result<String>{
        switch response.statusCode {
        case 200 : return .success
        default :
            do {
                guard let responseData = data else {
                    return .failure(ApiError.defaultSetup())
                }
                let apiResponse = try JSONDecoder().decode(ApiError.self, from: responseData)
                return .failure(apiResponse)

            } catch {
                return .failure(ApiError.defaultSetup(msg: NetworkResponse.unableToDecode.rawValue))
            }
        }
    }
}
