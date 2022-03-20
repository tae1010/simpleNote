//
//  ContentViewController.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/17.
//

import UIKit

class ContentViewController: UIViewController {
    
    var index: Int?
    var titleText: String?
    var contentText: String?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.text = titleText
        self.contentTextField.text = contentText
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        if let title = self.titleTextField.text {
            note[index!].title = title
        } else {
            note[index!].title = ""
        }
        
        if let content = self.contentTextField.text {
            note[index!].content = content
        } else {
            note[index!].content = ""
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
