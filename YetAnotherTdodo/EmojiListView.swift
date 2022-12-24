//
//  EmojiListView.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/23/22.
//

import SwiftUI
class EmojiListVM: ObservableObject {
    @Published private(set) var emojis: [String] = []
    init(){
        for i in 0x1F601...0x1F64F {
            let c = String(UnicodeScalar(i) ?? "-")
            emojis.append(c)
        }
    }
}
struct EmojiListView: View {
    @StateObject var vm = EmojiListVM()
    @State private var emoji = ""
    
    var body: some View {
        TextField("Emoji", text: $emoji)
            .onChange(of: emoji) { newValue in
                emoji = String(newValue.prefix(1))
            }
    }
}

struct EmojiListView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiListView()
    }
}
