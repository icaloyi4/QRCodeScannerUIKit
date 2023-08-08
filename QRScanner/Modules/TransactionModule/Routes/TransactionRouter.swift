//
//  TransactionRouter.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 09/08/23.
//

import Foundation

class TransactionRouter : TransactionPresenterToRouterProtocol {
    static func createModule(ref: TransactionController) {
        let presenter = TransactionPresenter()
        
        ref.presenter = presenter
        
        ref.presenter?.interactor = TransactionInteractor()
        ref.presenter?.view = ref
        
        ref.presenter?.interactor?.presenter = presenter
    
    }

}
