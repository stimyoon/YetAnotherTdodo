//
//  Category+Extensions.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/22/22.
//

import Foundation

extension Category {
    var name: String {
        get{ name_ ?? "" }
        set{ name_ = newValue}
    }
    var imageName: String {
        get{ imageName_ ?? "" }
        set{ imageName_ = newValue }
    }
    var dueDate: Date {
        get{ dueDate_ ?? Date() }
        set{ dueDate_ = newValue}
    }
    func setValues(name: String, imageName: String, dueDate: Date, isDone: Bool){
        self.name = name
        self.imageName = imageName
        self.dueDate = dueDate
        self.isDone = isDone
    }
    func setValue(values: CategoryValues) {
        self.name = values.name
        self.imageName = values.imageName
        self.dueDate = values.dueDate
        self.isDone = values.isDone
    }
}
