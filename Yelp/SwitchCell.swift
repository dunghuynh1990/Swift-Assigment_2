//
//  SwitchCell.swift
//  Yelp
//
//  Created by Huynh Tri Dung on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell:SwitchCell, didChangedValue value:Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!

    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func switchValueChanged () {
        // ??
        delegate?.switchCell?(self, didChangedValue: onSwitch.on)
    }

}
