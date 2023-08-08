//
//  PaymentInteractor.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation

class PaymentInteractor : PaymentPresenterToInteractorProtocol {
   
    
    let preff = SharedPrefference()
    
    func doingPayment(code: TransactionHistory) async {
        await cutSaldo(transaction: code)
    }
    
    private func cutSaldo(transaction :  TransactionHistory) async {
        do {
            let saldoAwal = preff.getDataString(key: "SALDOAWAL")
            if ( saldoAwal ?? "").isEmpty {
                
                let saldoAwal = 1000000000 - (transaction.value ?? 0)
                let saldoModel = AmmountModel(userAmmount: saldoAwal)
                let encodedData = try JSONEncoder().encode(saldoModel)
                let jsonString : String? = String(data: encodedData,
                                        encoding: .utf8)
                preff.writeDataString(key: "SALDOAWAL", data: (jsonString ?? ""))
                
            } else {
                
                if let dataFromJsonString = saldoAwal?.data(using: .utf8) {
                    let ammountModel = try JSONDecoder().decode(AmmountModel.self,
                                                                from: dataFromJsonString)
                    
                    let saldoAwal = (ammountModel.userAmmount ?? 1000000000) - (transaction.value ?? 0)
                    let saldoModel = AmmountModel(userAmmount: saldoAwal)
                    let encodedData = try JSONEncoder().encode(saldoModel)
                    let jsonString : String? = String(data: encodedData,
                                            encoding: .utf8)
                    preff.writeDataString(key: "SALDOAWAL", data: (jsonString ?? ""))
                }
            }
            await storeTransactionHistory(transaction: transaction)
        } catch {
            //handle error
            print(error)
        }
    }
    
    private func storeTransactionHistory(transaction :  TransactionHistory) async {
        do {
            let listTransactionString = preff.getDataString(key: "TRANSACTIONHISTORY")
            if !(listTransactionString ?? "").isEmpty {
                
                if let dataFromJsonString = listTransactionString?.data(using: .utf8) {
                    var transactionModel = try JSONDecoder().decode(TransactionModel.self,
                                                                from: dataFromJsonString)
                    if transactionModel.transactionHistory != nil {
                        transactionModel.transactionHistory?.append(transaction)
                    }
                    let encodedData = try JSONEncoder().encode(transactionModel)
                    let jsonString : String? = String(data: encodedData,
                                            encoding: .utf8)
                    preff.writeDataString(key: "TRANSACTIONHISTORY", data: (jsonString ?? ""))
                }
                
            } else {
                var transactionHistoryList = [TransactionHistory]()
                transactionHistoryList.append(transaction)
                let encodedData = try JSONEncoder().encode(TransactionModel(transactionHistory: transactionHistoryList))
                let jsonString : String? = String(data: encodedData,
                                        encoding: .utf8)
                preff.writeDataString(key: "TRANSACTIONHISTORY", data: (jsonString ?? ""))
            }
        } catch {
            //handle error
            print(error)
        }
    }
    
    var presenter: PaymentInteractorToPresenterProtocol?
}
