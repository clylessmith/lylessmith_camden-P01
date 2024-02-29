//
//  DropFileView.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/14/24.
//

import SwiftUI

struct DropFileView: View {
    
    @Binding var url: URL?
    @State var isHoveredOver = false
    
    var body: some View {
        let dropDelegate = CSVURLDropDelegate(url: $url, isHoveredOver: $isHoveredOver)
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.gray, lineWidth: 2)
            Text(fileName())
        }
        .onDrop(of: [.url], delegate: dropDelegate)
    }
    
    func fileName() -> String {
        if let url = url {
            return url.lastPathComponent
        }
        else {
            return "Drop File"
        }
    }
}


