//
//  ListVM.swift
//  CRM
//
//  Created by Tim Yoon on 12/20/22.
//

import Foundation
import Combine
import CoreData

protocol ListOrderProtocol {
    var listOrder: Int { set get }
}
class ListVM<T: NSManagedObject & Identifiable & ListOrderProtocol>: ObservableObject {
    @Published private(set) var items: [T] = []
    
    private let ds : CoreDataService<T>
    private var cancellables = Set<AnyCancellable>()
    
    init(entityName: String){
        let sortDescriptor = NSSortDescriptor(key: "listOrder_", ascending: true)
        
        ds = CoreDataService<T>(manager: PersistenceController.shared, entityName: entityName, sortDescriptors: [sortDescriptor])
        
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { [weak self] items in
                self?.items = items
            }
            .store(in: &cancellables)
    }
    
    func move(from offsets: IndexSet, to index: Int) {
        items.move(fromOffsets: offsets, toOffset: index)
        for index in 0..<items.count {
            items[index].listOrder = index
        }
        ds.saveAll()
    }
    
    func saveAll(){
        ds.saveAll()
    }
    
    func create()->T {
        var item = ds.create()
        item.listOrder = items.count
        ds.saveAll()
        return item
    }
    func update(_ item: T){
        ds.saveAll()
    }
    func delete(_ item: T) {
        ds.delete(item)
    }
    func delete(indexSet: IndexSet) {
        ds.delete(indexSet: indexSet)
    }
}

extension Category: ListOrderProtocol {
    var listOrder: Int {
        get{ Int(listOrder_)}
        set{ listOrder_ = Int64(newValue)}
    }
}
struct CategoryValues {
    var name: String = ""
    var imageName: String = ""
    var dueDate: Date = Date()
    var isDone: Bool = false
    init(category: Category) {
        self.name = category.name
        self.imageName = category.imageName
        self.dueDate = category.dueDate
        self.isDone = category.isDone
    }
    init(name: String="", imageName: String="", dueDate: Date=Date(), isDone: Bool=false) {
        self.name = name
        self.imageName = imageName
        self.dueDate = dueDate
        self.isDone = isDone
    }
}
class CategoryListVM: ListVM<Category> {
    @Published private(set) var categories: [Category] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func create()->Category {
        let category = super.create()
        category.listOrder = categories.count
        saveAll()
        return category
    }
    func createCategory(with values: CategoryValues) {
        let category = super.create()
        category.listOrder = categories.count
        setValue(of: category, with: values)
        saveAll()
    }
    
    func setValue(of category: Category, with categoryValues: CategoryValues){
        category.name = categoryValues.name
        category.imageName = categoryValues.imageName
        category.dueDate = categoryValues.dueDate
        category.isDone = categoryValues.isDone
    }
    
    
    init(){
        super.init(entityName: "Category")
        $items
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)
    }
}
//
//class CustomerListVM: ListVM<Customer> {
//    @Published private(set) var customers: [Customer] = []
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(){
//        super.init(entityName: "Customer")
//        $items
//            .sink { customers in
//                self.customers = customers
//            }
//            .store(in: &cancellables)
//    }
//    
//}
