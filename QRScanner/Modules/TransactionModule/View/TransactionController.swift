//
//  TransactionController.swift
//  QRScanner
//
//  Created by Rizky Haris Risaldi on 08/08/23.
//

import UIKit

class TransactionController: UIViewController {
    
    
    var presenter  : TransactionViewToPresenterProtocol?
    
    @IBOutlet weak var tbl_cell: UITableView!
    var dataTransaction = [TransactionHistory]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TransactionRouter.createModule(ref: self)
        
        tbl_cell.dataSource = self
        tbl_cell.delegate = self
        tbl_cell.register(TransactionItemLable.self, forCellReuseIdentifier: "cell")
        
        Task {
            await presenter?.loadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_back(_ sender: Any) {
        
        dismiss(animated: true)
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

extension TransactionController : TransactionPresenterToViewProtocol {
    func getDataTransaction(dataTransaction: Array<TransactionHistory>) {
        DispatchQueue.main.async {
            self.dataTransaction = [TransactionHistory]()
            
            dataTransaction.forEach { TransactionHistory in
                self.dataTransaction.append(TransactionHistory)
            }
            self.tbl_cell.reloadData()
            self.view.layoutIfNeeded()
        }
        
    }
    
    
}

extension TransactionController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TransactionController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell : TransactionItemLable
        //        if let dequeuedcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TransactionItemLable {
        //                    cell = dequeuedcell
        //                } else {
        //                    cell = TransactionItemLable()
        //                }
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionItemLable
            cell.textLabel?.text = "\(self.dataTransaction[indexPath.row].id ?? "")/ \(self.dataTransaction[indexPath.row].merchant ?? "")/\(String(self.dataTransaction[indexPath.row].value ?? 0))"
            cell.textLabel?.font = .systemFont(ofSize: 12)
            
            //            cell.detailTextLabel?.text = self.dataTransaction[indexPath.row].merchant
            //            cell.lbl_id?.text = self.dataTransaction[indexPath.row].id
            //            cell.lbl_merchant?.text = self.dataTransaction[indexPath.row].merchant
            //            cell.labelAmmount?.text = String(self.dataTransaction[indexPath.row].value ?? 0)
            
            return cell
        }
        else
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as UITableViewCell
            return cell
        }
        else
        if (indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as UITableViewCell
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    
}
