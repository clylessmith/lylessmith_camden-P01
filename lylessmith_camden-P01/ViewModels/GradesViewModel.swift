//
//  GradesViewModel.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/9/24.
//

import Foundation
import SwiftUI

class GradesViewModel: ObservableObject {
    
    var courseResults = CourseResults()
    
    @Published var url: URL? = nil {
        didSet {
            // TODO: Create and call parseFile() to update state
            print("New URL: \(String(describing: url))")
            do {
                let newData = try FileParser.parseData(atURL: url)
                
                self.courseResults.students = newData.1
                self.courseResults.assignmentGroups = newData.0
                
                self.courseResults.calcOverallScore()
                
            } catch  {
                print(error)
            }
        }
    }
    
    
    @Published var sortOrder: [KeyPathComparator<Student>] = [
        .init(\.name, order: SortOrder.forward)] {
            didSet {
                updateState()
            }
        }
    
    init() {
        setNotifications()
        updateState()
    }
    
    func updateState() {
        //self.courseResults.students = Array(courseResults.students.values).sorted(using: sortOrder)
    }
    
    private func setNotifications() {
        NotificationCenter.default.addObserver(forName: .studentsDidChange,
                                               object: nil,
                                               queue: nil,
                                               using: studentStateDidChange)
    }
    
    private func studentStateDidChange(_ notification: Notification) {
        updateState()
    }
}

