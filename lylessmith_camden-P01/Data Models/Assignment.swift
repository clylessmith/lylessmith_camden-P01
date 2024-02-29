//
//  Assignment.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/9/24.
//

import Foundation

class Assignment {
    
    let id = Assignment.ID()
    
    let name: String
    
    var maxScore: Double
    
    let assignmentGroup: AssignmentGroup
    
    var scores: [Student.ID : AssignmentScore] = [:]
    
    init(name: String, maxScore: Double, assignmentGroup: AssignmentGroup) {
        self.name = name
        self.maxScore = maxScore
        self.assignmentGroup = assignmentGroup
    }
    
    struct ID: Identifiable, Hashable {
        var id = UUID()
    }
}
