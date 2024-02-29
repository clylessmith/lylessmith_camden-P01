//
//  FileParser.swift
//  App1-Data
//
//  Created by Camden Lyles-Smith on 1/24/24.
//

import Foundation


struct FileParser {
    
   
    static func parseData(atURL url: URL?, withSeparators separators: CharacterSet = CharacterSet(charactersIn: ",")) throws -> ([AssignmentGroup.ID : AssignmentGroup], [Student.ID : Student]) {
        var localData: ([AssignmentGroup.ID : AssignmentGroup], [Student.ID : Student]) = ([:],[:])
        
        guard let unwrappedURL = url else {
            throw FileParserError.nilURL
        }
        
        guard let content = try getContentFrom(unwrappedURL) else {
            return localData
        }
        
        localData = try parseString(content, withSeparators: separators)
        
        return localData
    }
    
   
    private static func getContentFrom(_ url: URL) throws -> String? {
        let filepath = url.path
        guard let contentData = FileManager.default.contents(atPath: filepath) else {
            throw FileParserError.noDataAtURL(url)
        }
        
        guard let contentString = String(data: contentData, encoding: .ascii) else {
            throw FileParserError.stringCouldNotBeFormedFromDataAtURL(url)
        }
        return contentString
    }
    
    
    private static func parseString(_ contentString: String, withSeparators separatorsIn: CharacterSet) throws -> ([AssignmentGroup.ID : AssignmentGroup], [Student.ID : Student]) {
        var localData: ([AssignmentGroup.ID : AssignmentGroup], [Student.ID : Student]) = ([:],[:])
        var localGroups: [AssignmentGroup] = []
        var localStudents: [Student] = []
        var numAssignPerGroup: [Int] = []
        var parsedStudents: [String] = []
        var assignmentIds: [Assignment.ID] = []
        var studentIds: [Student.ID] = []
        
        var numGroups = 0
        var lastGroup = ""
        var currentGroupIdx = 0
        var currentNumAssignments = 0
        var currentNumStudents = 0
        var groupIdx = 0
        var assignNum = 0
        
        let lines = contentString.components(separatedBy: .newlines)
        
        guard let firstLine = lines.first else {
            throw FileParserError.stringIsEmpty
        }
        
        _ = firstLine.components(separatedBy: separatorsIn)
        
        for (row, nextLine) in lines.enumerated() {
            if nextLine == "" {continue}
            lastGroup = ""
            currentGroupIdx = 0
            currentNumAssignments = 0;
 
            let columnData = nextLine.components(separatedBy: separatorsIn)
            
            for (column, nextString) in columnData.enumerated() {
                switch row {
                case 0:
                    if nextString == "" {
                        continue
                    }
                    if column >= 2 && lastGroup != nextString {
                        // create new group with default value
                        let newGroup = AssignmentGroup(name: nextString, weight: 0.0)
                        localGroups.append(newGroup)
                        // this is current group
                        lastGroup = nextString
                        numAssignPerGroup.append(1)
                        numGroups += 1
                    }
                    else if column >= 2 && lastGroup == nextString {
                        // one more assignment in this group
                        numAssignPerGroup[numGroups - 1] += 1
                    }
                case 2:
                    if nextString == "" {
                        continue
                    }
                    if column >= 2 {
                        // set weight of group
                        localGroups[currentGroupIdx].weight = Double(nextString) ?? 0.0
                        currentNumAssignments += 1
                        // if next assignment will be new group, increase group index
                        if currentNumAssignments == numAssignPerGroup[currentGroupIdx] {
                            currentGroupIdx += 1
                            currentNumAssignments = 0
                        }
                    }
                case 4:
                    if nextString == "" {
                        continue
                    }
                    if column >= 2 {
                        let newAssignment = Assignment(name: nextString, maxScore: 0.0, assignmentGroup: localGroups[currentGroupIdx])
                        //track assignment IDs based on order in input file
                        assignmentIds.append(newAssignment.id)
                        
                        localGroups[currentGroupIdx].assignments.updateValue(newAssignment, forKey: newAssignment.id)
                        currentNumAssignments += 1
                        // if next assignment will be part of a different group, update group index
                        if currentNumAssignments == numAssignPerGroup[currentGroupIdx] {
                            currentGroupIdx += 1
                            currentNumAssignments = 0
                        }
                    }
                case 6:
                    if nextString == "" {
                        continue
                    }
                    if column >= 2 {

                        localGroups[groupIdx].assignments[assignmentIds[currentNumAssignments]]?.maxScore = Double(nextString) ?? 0.0
                        assignNum += 1
                        currentNumAssignments += 1
                        if assignNum == numAssignPerGroup[groupIdx] {
                            groupIdx += 1
                            assignNum = 0
                        }
                    }
                default:
                    switch column {
                    case 0:
                        parsedStudents.append(nextString)
                    case 1:
                        let newStudent = Student(name: parsedStudents[row / 2 - 4], studentID: nextString)
                        studentIds.append(newStudent.id)
                        localStudents.append(newStudent)
                        currentNumStudents += 1
                    default:
                        if nextString == "" && currentNumAssignments >= assignmentIds.count {
                            continue
                        }
                        let newScore = AssignmentScore(studentID: studentIds[currentNumStudents - 1], assignmentID: assignmentIds[currentNumAssignments], score: Double(nextString) ?? 0.0)
                        
                        localGroups[currentGroupIdx].assignments[assignmentIds[currentNumAssignments]]?.scores[studentIds[currentNumStudents - 1]] = newScore
                        
                        assignNum += 1
                        currentNumAssignments += 1
                        
                        if assignNum == numAssignPerGroup[currentGroupIdx] {
                            currentGroupIdx += 1
                            assignNum = 0
                        }
                        
                    }
                    
                }
            }
        }
        
        
        for group in localGroups {
            localData.0.updateValue(group, forKey: group.id)
        }
        for student in localStudents {
            localData.1.updateValue(student, forKey: student.id)
        }
        return localData
    }
}

extension FileParser {
    enum FileParserError: Error {
        case nilURL
        case noDataAtURL(URL)
        case stringCouldNotBeFormedFromDataAtURL(URL)
        case stringIsEmpty
        case noColumnsCreated
        case numberOfColumnsShouldBeStatic
    }
}
