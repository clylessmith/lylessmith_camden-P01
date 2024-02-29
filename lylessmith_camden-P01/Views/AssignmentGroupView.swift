//
//  AssignmentGroupView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/28/24.
//

import SwiftUI

struct AssignmentGroupView: View {
    @Binding var assignmentGroups: [AssignmentGroup.ID : AssignmentGroup]
    @State var totalWeight:Double = 0.0

    var body: some View {
        
        List(Array($assignmentGroups.values)) { $group in
            HStack {
                Text(group.name)
                Spacer()
                TextField("Weight: ", value: $group.weight, format: FloatingPointFormatStyle())
                    .textFieldStyle(.squareBorder)
            }
            
        }
        
//        ForEach(assignmentGroups) { assignmentGroup in
//            totalWeight += assignmentGroup.weight
//        }
//        if totalWeight > 100.0 {
//            Text("WEIGHT IS GREATER THAN 100").foregroundStyle(.red)
//        }
        
    }
}

