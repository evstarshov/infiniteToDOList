//
//  TaskProtocol.swift
//  infiniteToDoList
//
//  Created by Евгений Старшов on 22.01.2022.
//

import Foundation


protocol TaskProtocol {
    var name: String { get }
    var description: String { get }
    func add()
}
