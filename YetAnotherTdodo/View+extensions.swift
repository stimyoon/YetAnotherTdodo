//
//  View+extensions.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/23/22.
//

import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack{
            Spacer()
            self
            Spacer()
        }
    }
}
