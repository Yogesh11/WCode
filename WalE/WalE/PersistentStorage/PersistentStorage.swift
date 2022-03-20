//
//  PersistentStorage.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 20/03/22.
//

import Foundation

struct PersistentStorage {
    func saveValue(planet : Planet?){
        if let obj = planet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(obj) {
                UserDefaults.standard.set(data, forKey: planet?.date ?? Date().getCurrentDate())
            }
        }
    }
    
    func getValueForKey(_ key : String) -> Planet?  {
        if let dta =  UserDefaults.standard.data(forKey: key), dta.isEmpty == false {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(Planet.self, from: dta) {
                return data
            }
        }
        return nil
    }
}
