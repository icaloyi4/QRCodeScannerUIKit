//
//  TransactionInteractor.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 09/08/23.
//

import Foundation

class TransactionInteractor : TransactionPresenterToInteractorProtocol {
    func loadData() async -> [TransactionHistory] {
        do {
            let listTransactionString = preff.getDataString(key: "TRANSACTIONHISTORY")
            if !(listTransactionString ?? "").isEmpty {
                
                if let dataFromJsonString = listTransactionString?.data(using: .utf8) {
                    let transactionModel = try JSONDecoder().decode(TransactionModel.self,
                                                                    from: dataFromJsonString)
                    model.transactionHistory.removeAll()
                    
                    model.transactionHistory.append(contentsOf: (transactionModel.transactionHistory ?? [TransactionHistory]()))
                }
                
            }
        } catch {
            //handle error
            print(error)
        }
        
        return model.transactionHistory
    }
    
    var presenter: TransactionInteractorToPresenterProtocol?
    let preff = SharedPrefference()
    let model = TransactionEntity()
    
}
