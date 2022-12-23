//
//  Dataservice.swift
//  TrayTracker5
//
//  Created by Tim Yoon on 9/4/22.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    associatedtype ItemType: Identifiable
    func get()->AnyPublisher<[ItemType], Error>
    func delete(_ item: ItemType)
    func delete(indexSet: IndexSet)
    func create()->ItemType
    func getObject(by id: ItemType.ID)->ItemType?
    func saveAll()
}
