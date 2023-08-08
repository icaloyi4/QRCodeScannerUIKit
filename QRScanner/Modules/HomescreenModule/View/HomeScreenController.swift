//
//  ViewController.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 07/08/23.
//

import UIKit

class HomeScreenController: UIViewController {
    var presenter: HomecreenViewToPresenterProtocol?

    @IBOutlet weak var txt_saldo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Load Home")
        HomescreenRouter.createModule(ref: self)
        presenter?.loadSaldo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable(notification:)), name: Notification.Name("isReload"), object: nil)
    }
    

    @objc func reloadTable(notification: Notification){


    let isReload : NSNumber = notification.userInfo!["isReload"] as! NSNumber

        if (isReload.boolValue) {
            self.presenter?.loadSaldo()
        }
    }


    @IBAction func pay_btn(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondController = storyBoard.instantiateViewController(withIdentifier: "payment_controller")
        secondController.modalPresentationStyle = .fullScreen
        self.present(secondController, animated: true) {
            print("Balik")
        }
    }
    @IBAction func trans_btn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondController = storyBoard.instantiateViewController(withIdentifier: "transaction_controller")
        secondController.modalPresentationStyle = .fullScreen
        self.present(secondController, animated: true) {
            print("Balik")
        }
    }
}

extension HomeScreenController : HomecreenPresenterToViewProtocol {
    func getSaldo(saldo: String?) {
        txt_saldo.text = "Rp. \((saldo ?? "0"))"
    }
    

    
    
}

