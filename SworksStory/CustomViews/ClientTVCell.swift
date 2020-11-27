//
//  TableViewCell.swift
//  SworksStory
//
//  Created by Praveen Kumar on 27/11/20.
//

import UIKit

protocol ClientTVCellDelegate : class {
    func onDeliveryReturnTap(index : Int)
    func onMapsTap(index : Int)
    func onCallTap(index : Int)
}

class ClientTVCell : UITableViewCell {
    
    @IBOutlet weak var containerView: CustomTVCellCV!
    @IBOutlet weak var clientNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var deliveryReturnBtn: DeliveryReturnBtn!
    var index : Int?
    weak var delegate : ClientTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        
    }
    
    func addValues(order : Order) {
        
        clientNameLbl.text = order.name?.capitalized
        locationLbl.text = order.address?.capitalized
        
        
    }
    
    private func setUpUI() {
        
        containerView.customisze()
        deliveryReturnBtn.customize()
        
    }
    
    
    @IBAction func onDevlieryReturn(_ sender: DeliveryReturnBtn) {
        
        guard let i = index else { return }
        delegate?.onDeliveryReturnTap(index: i)
        
    }
    
    
    @IBAction func onMaps(_ sender: UIButton) {
        
        
        guard let i = index else { return }
        delegate?.onMapsTap(index: i)
        
    }
    
    
    @IBAction func onCall(_ sender: UIButton) {
        
        guard let i = index else { return }
        delegate?.onCallTap(index: i)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
