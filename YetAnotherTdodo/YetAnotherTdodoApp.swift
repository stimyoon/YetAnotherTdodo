//
//  YetAnotherTdodoApp.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/22/22.
//

import SwiftUI

@main
struct YetAnotherTdodoApp: App {
    @StateObject var categoryListVM = CategoryListVM()
    
    var body: some Scene {
        WindowGroup {
            CategoryListView(categoryListVM: categoryListVM)
        }
    }
}
