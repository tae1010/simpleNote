//
//  noteManagement.swift
//  simpleNote
//
//  Created by 김정태 on 2022/03/20.
//

import Foundation

func saveTasks() {
    let data = note.map {
        [
            "title": $0.title,
            "content": $0.content,
            "important": $0.important,
            "currentDate": $0.currentDate
        ]
    }
    userDefaults.set(data, forKey: "note")
}

func loadTasks() {
    let userDefaults = UserDefaults.standard
    guard let data = userDefaults.object(forKey: "note") as? [[String: Any]] else {return}
    
    note = data.compactMap {
        guard let title = $0["title"] as? String else { return nil }
        guard let content = $0["content"] as? String else { return nil }
        guard let important = $0["important"] as? Bool else { return nil }
        guard let currentDate = $0["currentDate"] as? String else { return nil }
        return Note(title: title, content: content, important: important, currentDate: currentDate)
    }
    
}
