//
//  PaymentRoutes.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation

class PaymentRoute : PaymentPresenterToRouterProtocol {
    static func createModule(ref: PaymentController) {
        let presenter = PaymentPresenter()
        
        ref.presenter = presenter
        
        ref.presenter?.interactor = PaymentInteractor()
        ref.presenter?.view = ref
        
        ref.presenter?.interactor?.presenter = presenter
    }
}
