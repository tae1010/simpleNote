//
//  ViewController.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var note = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tableViewNib = UINib(nibName: "notecell", bundle: nil)
        
        self.tableView.register(tableViewNib, forCellReuseIdentifier: "notecell")
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTapButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "메모", message: nil, preferredStyle: .alert)
        
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            
            guard let title = alert.textFields?[0].text else { return }
            
            let note = Note(title: title, content: "내용없음", important: false)
            self?.note.append(note)
            self?.tableView.reloadData()
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        
        alert.addTextField(configurationHandler: { textfield in
            textfield.placeholder = "제목을 입력해주세요."
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! TableViewCell
        let note = self.note[indexPath.row]
        
        cell.titleLabel?.text = note.title

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.note.count
    }
}
