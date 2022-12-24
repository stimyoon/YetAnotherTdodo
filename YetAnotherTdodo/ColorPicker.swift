//
//  ColorPicker.swift
//  YetAnotherTdodo
//
//  Created by Tim Yoon on 12/23/22.
//

import SwiftUI


struct ColorPicker: View {
    @State var colors: [Color] = [
        .red, .green, .gray, .purple, .teal, .blue, .white, .black, .orange, .yellow
    ]
    @State var colorIndex = 0
    @Binding var selectedColor: Color
    var body: some View {
        VStack{
            Rectangle()
                .fill(colors[colorIndex])
            Menu("Color") {
                ForEach(colors, id: \.self){ color in
                    Text("Color").foregroundColor(color).tag(color)
                }
            }
        }
        .navigationTitle("Picker")
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ColorPicker(selectedColor: .constant(.red))
        }
    }
}
