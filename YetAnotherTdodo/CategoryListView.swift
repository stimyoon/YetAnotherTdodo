//
//  CategoryListView.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/22/22.
//

import SwiftUI

struct CategoryEditView: View {
    @State var category: CategoryValues
    var save: (CategoryValues) -> ()
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Category Name"){
                    TextField("name", text: $category.name)
                }
                Section("Icon name") {
                    TextField("imageName", text: $category.imageName)
                }
                Button {
                    save(category)
                    dismiss()
                } label: {
                    Text("Save").centerHorizontally()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Category Edit")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }

            }
        }
    }
}

struct CategoryRowView: View {
    @ObservedObject var category: Category
    var body: some View {
        HStack {
            Image(systemName: category.imageName.lowercased())
                .foregroundColor(.red)
                .padding(.trailing, 10)
            Text("\(category.name)")
            Spacer()
        }
    }
}
struct CategoryListView: View {
    @ObservedObject var categoryListVM: CategoryListVM
    @State private var isShowingCategoryEditSheet = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(categoryListVM.categories){ category in
                    NavigationLink {
                        CategoryEditView(category: CategoryValues(category: category)) { values in
                            category.setValue(values: values)
                            categoryListVM.update(category)
                        }
                    } label: {
                        CategoryRowView(category: category)
                    }
                }
                .onDelete(perform: categoryListVM.delete)
                .onMove(perform: categoryListVM.move)
            }
            .navigationTitle("Category List")
            .toolbar {
                toolbarItems
            }
        }
    }
    private func create(values: CategoryValues) {
        categoryListVM.createCategory(with: values)
    }

    var toolbarItems: some ToolbarContent {
        Group{
            ToolbarItem(placement: .status) {
                EditButton()
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingCategoryEditSheet = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingCategoryEditSheet) {
                    CategoryEditView(category: CategoryValues(), save: create)
                }
            }

        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(categoryListVM: CategoryListVM())
    }
}
