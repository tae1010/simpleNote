//
//  TableViewCell.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/12.
//

import UIKit

protocol ImportantCheckDelegate: AnyObject {
    func imporantButtonTap(cell: UITableViewCell)
}

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var importantButton: UIButton!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    var note = [Note]()
    
    var cellDelegate: ImportantCheckDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func tapImportantButton(_ sender: UIButton) {
        self.cellDelegate?.imporantButtonTap(cell: self)
    }
}
