//
//  PembayaranProtocol.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation



protocol PaymentPresenterToRouterProtocol {
    static func createModule(ref: PaymentController)
}

protocol PaymentViewToPresenterProtocol {
    var view: PaymentPresenterToViewProtocol? { get set }
    var interactor: PaymentPresenterToInteractorProtocol? { get set }
    
    func doingPayment(code : String?) async ->Bool
    
    
}

protocol PaymentPresenterToInteractorProtocol {
    var presenter: PaymentInteractorToPresenterProtocol? { get set}
    
    func doingPayment(code : TransactionHistory) async
}

protocol PaymentInteractorToPresenterProtocol {
}

protocol PaymentPresenterToViewProtocol {
    
    func hideQR(isHidden : Bool)
    
    func setFooterMessage(message : String)
}


