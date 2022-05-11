//
//  noteViewController.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/20.
//

import UIKit

class NoteViewController: UIViewController {

    var index: Int?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var titleL: String?
    var contentL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame:UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "paper")
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at: 0)
        
        self.titleLabel.text = titleL
        self.contentLabel.text = contentL
    }

    @IBAction func changeButton(_ sender: UIButton) {
        let contentView = ContentViewController(nibName: "ContentView", bundle: nil)
        
        contentView.index = self.index
        contentView.titleText = note[index!].title
        contentView.contentText = note[index!].content
        
        self.navigationController?.pushViewController(contentView, animated: true)
    }
    
}
