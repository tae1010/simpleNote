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
    var note = [Note]() {
        didSet {
            self.saveTasks()

        }
    }//셀을 구성하는 note구조체 배열
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tableViewNib = UINib(nibName: "notecell", bundle: nil)
        
        self.tableView.register(tableViewNib, forCellReuseIdentifier: "notecell")
        
        self.loadTasks()
    
        // Do any additional setup after loading the view.
    }
    
    //addbutton 클릭시 alert버튼을 통해서 셀을 생성
    @IBAction func addTapButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "메모", message: nil, preferredStyle: .alert)
        
        //alert 등록버튼
        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            
            guard let title = alert.textFields?[0].text else { return }
            
            let note = Note(title: title, content: "내용을 입력해주세요.", important: false, currentDate: koreanDate())
            self?.note.append(note)
            self?.tableView.reloadData()
        })
        
        //alert 취소버튼
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        
        alert.addTextField(configurationHandler: { textfield in
            textfield.placeholder = "제목을 입력해주세요."
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveTasks() {
        print("saveTasks")
        let data = self.note.map {
            [
                "title": $0.title,
                "content": $0.content,
                "important": $0.important,
                "currentDate": $0.currentDate
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "note")
    }
    
    func loadTasks() {
        print("loadTasks1")
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "note") as? [[String: Any]] else {return}
        print("loadTasks2")
        self.note = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let content = $0["content"] as? String else { return nil }
            guard let important = $0["important"] as? Bool else { return nil }
            guard let currentDate = $0["currentDate"] as? String else { return nil }
            print("123123")
            return Note(title: title, content: content, important: important, currentDate: currentDate)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    //자동으로 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
    }
    
    //셀 클릭시 발생하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contentViewController = self.storyboard?.instantiateViewController(identifier: "ContentViewController") as? ContentViewController else {return}
        
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.present(contentViewController, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource {
    
    //cell을 구성하고 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! TableViewCell
        let note = self.note[indexPath.row]
        
        cell.titleLabel?.text = note.title
        cell.cellDelegate = self
        cell.currentDateLabel.text = note.currentDate
        
        //처음에 cell을 불러올때 important값 확인후 버튼 이미지 불러오기
        if note.important {
            cell.importantButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.importantButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.note.count
    }
    
}

extension ViewController: ImportantCheckDelegate {
    func imporantButtonTap(cell: UITableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        var note = self.note[indexPath.row]
        
        note.important = !note.important //버튼클릭시 bool값 변경
        self.note[indexPath.row] = note // 변경된값을 note배열에 저장
        self.tableView.reloadRows(at: [indexPath], with: .automatic) //셀안에 버튼클릭시 셀을 reload
    }
    
}
