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
    
    var courseStats: CourseStats = CourseStats()
    
    func calcOverallScore() {
        for stu in students {
            students[stu.key]?.overAllScore = 0.0
        }
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
    
    func calculateStats() {
        
        // overall grade calculations
        var overallGradeMean = 0.0
        var overallGradeMedian = 0.0
        
        
        var studentsArr:[Double] = []
        var numStudents = students.count
        var middleIdx = numStudents / 2
        
        
        var letterGradeDict:[LetterGrade : Int] = [:]
        for letter in LetterGrade.allCases {
            letterGradeDict.updateValue(0, forKey: letter)
        }
        var groupDict: [AssignmentGroup.ID : [Double]] = [:]
        var assignDict: [Assignment.ID : [Double]] = [:]
        
        
        for student in students {
            overallGradeMean += student.value.overAllScore
            studentsArr.append(student.value.overAllScore)
            
            //letter grade calculation
            letterGradeDict.updateValue(1 + (letterGradeDict[student.value.letterGrade] ?? 0), forKey: student.value.letterGrade)
            
        }
        
        overallGradeMean /= Double(numStudents)
        studentsArr = studentsArr.sorted()
        overallGradeMedian = studentsArr[middleIdx]
        
        for group in assignmentGroups {
            var groupMedian = 0.0
            var groupMean = 0.0

            var groupArr:[Double] = []
            
            var groupCount = 0
            var middleIdxGroup = 0
            
            for assign in group.value.assignments {
                var assignMedian = 0.0
                var assignMean = 0.0
                var assignArr:[Double] = []
                
                for score in assign.value.scores {
                    var currentScore = score.value.score
                    
                    assignMean += currentScore
                    assignArr.append(currentScore)
                    
                    groupMean += currentScore
                    groupArr.append(currentScore)
                    groupCount += 1
                }
                
                var assignCount = assignArr.count
                var middleIdxAssign = assignCount / 2
                assignMean /= Double(assignCount)
                assignArr = assignArr.sorted()
                assignMedian = assignArr[middleIdxAssign]
                assignDict.updateValue([assignMean, assignMedian], forKey: assign.key)
            }
            
            groupMean /= Double(groupCount)
            groupArr = groupArr.sorted()
            middleIdxGroup = groupCount / 2
            groupMedian = groupArr[middleIdxGroup]
            
            groupDict.updateValue([groupMean, groupMedian], forKey: group.key)
        }
       
        courseStats.mean = overallGradeMean
        courseStats.median = overallGradeMedian
        courseStats.letterGrade = letterGradeDict
        courseStats.groupStats = groupDict
        courseStats.assignmentStats = assignDict
    }
}
