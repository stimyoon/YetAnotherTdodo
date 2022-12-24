//
//  Category+Extensions.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/22/22.
//

import Foundation

extension Category: CategoryValuesProtocol {
    var name: String {
        get{ name_ ?? "" }
        set{ name_ = newValue}
    }
    var imageName: String {
        get{ imageName_ ?? "" }
        set{ imageName_ = newValue }
    }
    func setValues(name: String, imageName: String, dueDate: Date, isDone: Bool){
        self.name = name
        self.imageName = imageName
    }
    func setValue(values: any CategoryValuesProtocol) {
        self.name = values.name
        self.imageName = values.imageName
    }
}
