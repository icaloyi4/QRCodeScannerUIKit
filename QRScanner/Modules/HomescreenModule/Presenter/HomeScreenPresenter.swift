//
//  HomeScreenPresenter.swift
//  qrcodereader
//
//  Created by Rizky Haris Risaldi on 05/08/23.
//

import Foundation
import SwiftUI
import Combine

class HomeScreenPresenter : HomecreenViewToPresenterProtocol {
    var interactor: HomecreenPresenterToInteractorProtocol?
    
    var view: HomecreenPresenterToViewProtocol?
    
    func loadSaldo() {
        print("Load")
        interactor?.loadSaldo()
    }
}

extension HomeScreenPresenter : HomescreenInteractorToPresenterProtocol {
    func getSaldo(saldo: String?) {
        view?.getSaldo(saldo: saldo)
    }
    

}
