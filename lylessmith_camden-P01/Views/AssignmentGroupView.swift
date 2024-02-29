//
//  AssignmentGroupView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/28/24.
//

import SwiftUI

struct AssignmentGroupView: View {
    @ObservedObject var viewModel: GradesViewModel

    var body: some View {
        List(Array(viewModel.courseResults.assignmentGroups.values)) { $nextGroup in
            HStack {
                Text(nextGroup.name)
                Spacer()
                TextField("Weight: ", value: $nextGroup.weight, format: FloatingPointFormatStyle())
                    .textFieldStyle(.squareBorder)
            }
            
        }
    }
}

