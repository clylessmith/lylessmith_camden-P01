//
//  AssignmentGroupView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/28/24.
//

import SwiftUI

struct AssignmentGroupView: View {
    @EnvironmentObject var viewModel:GradesViewModel

    var body: some View {
        
        List(Array(viewModel.courseResults.assignmentGroups.values)) { group in
            HStack {
                Text(group.name)
                Spacer()
                TextField("Weight: ", value: $viewModel.courseResults.assignmentGroups[group.id].weight, format: FloatingPointFormatStyle())
                    .textFieldStyle(.squareBorder)
            }
            
        }
        

        if viewModel.totalWeight > 100.0 {
            Text("WEIGHT IS GREATER THAN 100").foregroundStyle(.red)
        }
        
    }
}

