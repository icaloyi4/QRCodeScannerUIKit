//
//  PaymentPresenter.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation

class PaymentPresenter : PaymentViewToPresenterProtocol {
    
    func doingPayment(code: String?) async -> Bool  {
        var isValid = false
        view?.setFooterMessage(message: (code ?? ""))
        view?.hideQR(isHidden: false)
        
        if !(code ?? "").isEmpty {

            view?.setFooterMessage(message: "Tunggu sebentar, kami sedang memproses transaksimu")
            
            let codeArray = (code ?? "").components(separatedBy: ".")
            if !codeArray.isEmpty {
                if codeArray.count == 4 {
                    // Store Transaction
                  
                    let transactionHistory = TransactionHistory(id: codeArray[1], bank: codeArray[0], merchant: codeArray[2], value: Int(codeArray[3]))
                    await interactor?.doingPayment(code: transactionHistory)
                    
                    isValid = true
                } else {
                    view?.setFooterMessage(message: "Code Tidak Valid")
                   
                    
                }
            } else {
                view?.setFooterMessage(message: "Code Tidak Valid")
                
            }
        }
        
        return isValid
        
    }
    
    func hideQR(isHidden: Bool) {
        view?.hideQR(isHidden: isHidden)
    }
    
    func setFooterMessage(message: String) {
        view?.setFooterMessage(message: message)
    }
    
    var view: PaymentPresenterToViewProtocol?
    var interactor: PaymentPresenterToInteractorProtocol?
    
}

extension PaymentPresenter : PaymentInteractorToPresenterProtocol{
    
    
    
    
}
