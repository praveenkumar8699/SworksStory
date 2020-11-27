//
//  ViewController.swift
//  SworksStory
//
//  Created by Praveen Kumar on 27/11/20.
//

import UIKit

class ClientsListVC : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        getClients()
        
        
    }
    
    private func setUpUI() {
        
        tableView.register(UINib(nibName: String(describing: ClientTVCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ClientTVCell.self))
        tableView.tableFooterView = UIView()
        
    }
    
    
    private func getClients() {
        
        guard let url = URL(string: API.GET_CLIENTS) else { return }
        
        ApiCallManager.GET(url: url) { [weak self] (data, response, error) in
            
            if let err = error {
                print(err.localizedDescription)
            } else if data != nil {
                do {
                    let model = try JSONDecoder().decode(Clients.self, from: data!)
                    self?.processModel(clients: model)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    private func processModel(clients : Clients) {
        
        guard let loc_orders = clients.orders else { return }
        
        orders = loc_orders
        
        if Thread.current.isMainThread {
            tableView.reloadData()
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        
    }
    
    private func onDeliveryReturn(index : Int) {
        
    }
    
    private func onMaps(index : Int) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MapsVC.self)) as! MapsVC
        let order = orders[index]
        vc.order = order
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func onCall(index : Int) {
        
        guard let number = orders[index].phone, let numberURL = URL(string: "tel://\(number)") else { return }
        
        if UIApplication.shared.canOpenURL(numberURL) {
            UIApplication.shared.open(numberURL)
        } else { print("cannot open") }
        
        
        
    }
    

}


//MARK:- UITableViewDelegate
extension ClientsListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ClientTVCell.self), for: indexPath) as! ClientTVCell
        
        let order = orders[indexPath.row]
        
        cell.addValues(order: order)
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension ClientsListVC : ClientTVCellDelegate {
    
    func onDeliveryReturnTap(index: Int) {
        onDeliveryReturn(index: index)
    }
    
    func onMapsTap(index: Int) {
        onMaps(index: index)
    }
    
    func onCallTap(index: Int) {
        onCall(index: index)
    }
    
}


