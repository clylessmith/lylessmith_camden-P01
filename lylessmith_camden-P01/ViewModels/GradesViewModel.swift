//
//  GradesViewModel.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/9/24.
//

import Foundation
import SwiftUI

class GradesViewModel: ObservableObject {
    var studentsArray:[Student] = []

    @Published var courseResults = CourseResults()
    
    init(courseResults: CourseResults) {
        self.courseResults = courseResults
        self.totalWeight = 0.0
        
        for group in courseResults.assignmentGroups {
            self.totalWeight += group.value.weight
        }
    }
    
    @Published var url: URL? = nil {
        didSet {
            print("New URL: \(String(describing: url))")
            do {
                let newData = try FileParser.parseData(atURL: url)
                
                self.courseResults.students = newData.1
                self.courseResults.assignmentGroups = newData.0
                
                self.courseResults.calcOverallScore()
                self.courseResults.calculateStats()
                
                for group in courseResults.assignmentGroups {
                    totalWeight += group.value.weight
                }
                
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
    
    @Published var totalWeight = 0.0
    
    init() {
        setNotifications()
        updateState()
    }
    
    func updateState() {
        self.studentsArray = Array(courseResults.students.values).sorted(using: sortOrder)
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

