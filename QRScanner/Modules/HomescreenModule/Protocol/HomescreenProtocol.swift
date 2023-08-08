//
//  HomescreenProtocol.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation

protocol HomescreenInteractorToPresenterProtocol {
    func getSaldo(saldo : String?)}

protocol HomecreenPresenterToViewProtocol {
    func getSaldo(saldo : String?)
}

protocol HomecreenViewToPresenterProtocol {
    var view: HomecreenPresenterToViewProtocol? { get set }
    var interactor: HomecreenPresenterToInteractorProtocol? { get set }
    
    func loadSaldo()
    
}

protocol HomecreenPresenterToInteractorProtocol {
    var presenter: HomescreenInteractorToPresenterProtocol? { get set}
    
    func loadSaldo()
}

protocol HomecreenPresenterToRouterProtocol {
    static func createModule(ref: HomeScreenController)
}
