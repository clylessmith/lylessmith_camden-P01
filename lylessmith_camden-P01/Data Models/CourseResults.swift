//
//  CourseResults.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/9/24.
//

import Foundation
import SwiftUI

class CourseResults: ObservableObject {
    
    var students: [Student.ID : Student] = [:] {
        didSet {
            NotificationCenter.default.post(name: .studentsDidChange, object: self)
        }
    }
    
    var assignmentGroups: [AssignmentGroup.ID : AssignmentGroup] = [:]
    
    func calcOverallScore() {
        for assignmentGroup in assignmentGroups {
            var totalPointsPossible = 0.0
            
            var localScores: [Student.ID: Double] = [:]
            
            for currentAssign in assignmentGroup.value.assignments {
                totalPointsPossible += currentAssign.value.maxScore
                for aScore in currentAssign.value.scores {
                    localScores.updateValue(aScore.value.score + (localScores[aScore.key] ?? 0.0), forKey: aScore.key)
                }
            }
            for stu in localScores {
                students[stu.key]?.overAllScore += assignmentGroup.value.weight * ( stu.value / totalPointsPossible )
            }
        }
    }
}
