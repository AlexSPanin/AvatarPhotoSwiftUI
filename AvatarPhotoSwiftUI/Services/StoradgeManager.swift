//
//  StoradgeManager.swift
//  TaskManagerPaninUIKit
//
//  Created by Александр Панин on 24.02.2022.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let tasksKey = "AvatarPhoto"
    
    private init() {}
    
    func save(at data: Data) {
        userDefaults.set(data, forKey: tasksKey)
    }

    func fetchData() -> Data {
        guard let data = userDefaults.object(forKey: tasksKey) as? Data else { return Data()}
        return data
    }
}
