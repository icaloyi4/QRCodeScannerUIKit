//
//  HomescreenRoute.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import Foundation

class HomescreenRouter: HomecreenPresenterToRouterProtocol {
    static func createModule(ref: HomeScreenController) {
        let presenter = HomeScreenPresenter()
        
        ref.presenter = presenter
        
        ref.presenter?.interactor = HomeScreenInteractor()
        ref.presenter?.view = ref
        
        ref.presenter?.interactor?.presenter = presenter
    }
}
