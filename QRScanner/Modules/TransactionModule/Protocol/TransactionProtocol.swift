//
//  TransactionProtocol.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 09/08/23.
//

import Foundation

protocol TransactionPresenterToRouterProtocol {
    static func createModule(ref: TransactionController)
}

protocol TransactionViewToPresenterProtocol {
    var view: TransactionPresenterToViewProtocol? { get set }
    var interactor: TransactionPresenterToInteractorProtocol? { get set }
    
    func loadData() async
    
}

protocol TransactionPresenterToInteractorProtocol {
    var presenter: TransactionInteractorToPresenterProtocol? { get set}
    
    func loadData() async -> [TransactionHistory]
    
}

protocol TransactionInteractorToPresenterProtocol {
}

protocol TransactionPresenterToViewProtocol {
    func getDataTransaction(dataTransaction : Array<TransactionHistory>)
}
