//
//  SFSymbolListView.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/23/22.
//

import SwiftUI
import Combine

final class SFSymbolManager: ObservableObject {
    @Published private(set) var symbolNames: [String] = []
    @Published private(set) var filteredNames: [String] = []
    @Published var filterText = ""
    
    let textLimit = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        if let fileURL = Bundle.main.url(forResource: "sf symbol list", withExtension: "csv") {
            // we found the file in our bundle!
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
                symbolNames = fileContents.components(separatedBy: "\n")
                    .map({ name in
                        name.trimmingCharacters(in: .whitespacesAndNewlines)
                    })

            }
        }
        $symbolNames
            .combineLatest($filterText, { (names, filterText)-> [String] in
                if filterText.isEmpty {
                    return names
                }else{
                    return names.filter { name in
                        name.localizedCaseInsensitiveContains(filterText)
                    }
                }
            })
            .sink(receiveCompletion: { error in
                fatalError("\(error)")
            }, receiveValue: { names in
                self.filteredNames = names
            })
            .store(in: &cancellables)
    }
}

struct SFSymbolListView: View {
    @StateObject var vm = SFSymbolManager()
    var body: some View {
        NavigationStack{
            List{
                ForEach(vm.filteredNames, id: \.self){ name in
                    HStack(alignment: .center){
                        Image(systemName: name)
                            .frame(minWidth: 20)
                            .padding(.trailing)
                        Text("\(name)")
                    }
                }
            }
            .searchable(text: $vm.filterText)
            .navigationTitle("SF Symbols")
        }
    }
}

struct SFSymbolListView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolListView()
    }
}
