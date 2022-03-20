//
//  PlanetViewModel.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 20/03/22.
//

import UIKit

class PlanetViewModel: NSObject {
    var planet :  Planet?
    private var networkManager    : NetworkManager?
    private var persistentStorage : PersistentStorage?
    
    init(networkManager : NetworkManager    = NetworkManager() ,
         storageManager : PersistentStorage = PersistentStorage()) {
        super.init()
        self.networkManager    = networkManager
        self.persistentStorage = storageManager
    }
    
    func getPlanetData(_ closure :@escaping (ApiError?)->Void){
        networkManager?.getPlanetDetail(completion: { [weak self] planet, error in
            if let err = error {
                if err.code == -1009{
                    self?.restoreFromCache()
                    if self?.planet == nil {
                        self?.restoreLastSyncData()
                        if self?.planet != nil {
                            var errObj = err
                            errObj.updateErrorMsg(msg: NetworkResponse.lastSyncMessage.rawValue)
                            closure(err)
                            return
                        }
                    }
                }
                 closure(err)
            } else{
                self?.planet = planet
                self?.saveValue()
                closure(nil)
            }
        })
    }
    
    func saveValue() {
        persistentStorage?.saveValue(planet: planet)
    }
    
    func restoreFromCache(){
        planet = persistentStorage?.getValueForKey(Date().getCurrentDate())
    }
    
    func restoreLastSyncData(){
        if let date =  persistentStorage?.getLastSyncDate() , date.isEmpty == false {
            planet = persistentStorage?.getValueForKey(date)
        }
    }
}
    
