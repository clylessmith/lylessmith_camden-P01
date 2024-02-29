//
//  AssignmentGroup.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/9/24.
//

import Foundation

class AssignmentGroup: Identifiable, ObservableObject {
    
    let id = AssignmentGroup.ID()
    
    @Published var name: String
    
    @Published var weight: Double
    
    var assignments: [Assignment.ID : Assignment] = [:]
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
}
