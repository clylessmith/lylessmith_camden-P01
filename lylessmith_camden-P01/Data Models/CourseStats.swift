//
//  CourseStats.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/28/24.
//

import Foundation

class CourseStats {
    var mean:Double = 0.0
    var median:Double = 0.0
    var letterGrade: [LetterGrade : Int] = [:]
    var groupStats: [AssignmentGroup.ID : [Double]] = [:]
    var assignmentStats: [Assignment.ID : [Double]] = [:]
}
