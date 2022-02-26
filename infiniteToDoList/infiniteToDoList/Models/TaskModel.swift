//
//  TaskModel.swift
//  infiniteToDoList
//
//  Created by Евгений Старшов on 22.01.2022.
//

import Foundation

class MainTask: TaskProtocol {

    
    var name: String
    
    var description: String
    
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    func add() {
        
    }
    
}

class SubTask: TaskProtocol {
    
    var name: String
    
    var description: String
    
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        
    }
    
    func add() {
       
    }
}
