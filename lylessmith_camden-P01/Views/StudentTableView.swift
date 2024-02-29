//
//  StudentTableView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/27/24.
//

import SwiftUI

struct StudentTableView: View {
    
    @ObservedObject var viewModel: GradesViewModel
        
    var body: some View {
        Table(Array(viewModel.courseResults.students.values)) {
            TableColumn("Student Name", value: \.name)
            TableColumn("Student ID", value: \.studentID)
            TableColumn("Student Score") {
                Text(String(format: "%.2f", $0.overAllScore))
            }
            TableColumn("Letter Grade") {
                Text($0.letterGrade.rawValue)
            }
        }
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

//#Preview {
//    StudentTableView()
//}
