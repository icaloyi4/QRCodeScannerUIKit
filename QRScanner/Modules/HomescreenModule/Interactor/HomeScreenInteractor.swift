//
//  HomeScreenInteractor.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 05/08/23.
//

import Foundation

class HomeScreenInteractor : HomecreenPresenterToInteractorProtocol {
    
    var presenter: HomescreenInteractorToPresenterProtocol?
    let preff = SharedPrefference()
    let model : HomeScreenEntity = HomeScreenEntity()
    
    func loadSaldo(){
        do {
            let saldoAwal = preff.getDataString(key: "SALDOAWAL")
            if ( saldoAwal ?? "").isEmpty {
                
                model.saldoAwal = 1000000000
                let saldoModel = AmmountModel(userAmmount: model.saldoAwal)
                let encodedData = try JSONEncoder().encode(saldoModel)
                let jsonString : String? = String(data: encodedData,
                                        encoding: .utf8)
                preff.writeDataString(key: "SALDOAWAL", data: (jsonString ?? ""))
                
            } else {
                
                if let dataFromJsonString = saldoAwal?.data(using: .utf8) {
                    let ammountModel = try JSONDecoder().decode(AmmountModel.self,
                                                                from: dataFromJsonString)
                    model.saldoAwal = (ammountModel.userAmmount ?? 0)
                }
            }
            
            presenter?.getSaldo(saldo: String(model.saldoAwal))
        } catch {
            //handle error
            presenter?.getSaldo(saldo: String(model.saldoAwal))
            print(error)
        }
        
    }
}
