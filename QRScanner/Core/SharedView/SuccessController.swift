//
//  SuccessController.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 09/08/23.
//

import UIKit

class SuccessController: UIViewController {
    @IBOutlet weak var lbl_ammount: UILabel!
    
    @IBOutlet weak var lbl_idtrans: UILabel!
    @IBOutlet weak var lbl_merchant: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_finish(_ sender: Any) {
        
        dismiss(animated: true){
            NotificationCenter.default.post(name: Notification.Name("dismissScreen"), object: nil, userInfo: ["dismissScreen":true])
            NotificationCenter.default.post(name: Notification.Name("isReload"), object: nil, userInfo: ["isReload":true])
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
