//
//  TransactionPresenter.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 09/08/23.
//

import Foundation

class TransactionPresenter : TransactionViewToPresenterProtocol {
    func loadData() async {
        let dataTransaction = await interactor?.loadData()
        view?.getDataTransaction(dataTransaction: (dataTransaction ?? [TransactionHistory]()))
    }
    
    var view: TransactionPresenterToViewProtocol?
    
    var interactor: TransactionPresenterToInteractorProtocol?
    
    
}

extension TransactionPresenter : TransactionInteractorToPresenterProtocol {
    
}
