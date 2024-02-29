//
//  CourseStatsView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/28/24.
//

import SwiftUI

struct CourseStatsView: View {
    @EnvironmentObject var viewModel:GradesViewModel
    @Binding var courseStats: CourseStats
    
    var body: some View {
        List {
            Text("Mean: \(courseStats.mean)")
            Spacer()
            Text("Median: \(courseStats.median)")
            Spacer()
            
            ForEach(Array(courseStats.letterGrade.keys), id: \.self) { key in
                Text("\(key.rawValue) : \(courseStats.letterGrade[key] ?? 0)")
            }
            
            Spacer()
            
            // LOOP LOGIC CITED FROM https://stackoverflow.com/questions/56675532/swiftui-iterating-through-dictionary-with-foreach
            ForEach(Array(courseStats.groupStats.keys), id: \.self) { key in
                Text("\(viewModel.courseResults.assignmentGroups[key]?.name ?? "") mean : \(courseStats.groupStats[key]?.first ?? 0)")
                Text("\(viewModel.courseResults.assignmentGroups[key]?.name ?? "") median : \(courseStats.groupStats[key]?.last ?? 0)")
                ForEach(Array(courseStats.assignmentStats.keys), id: \.self) { assignKey in
                    if viewModel.courseResults.assignmentGroups[key]?.assignments[assignKey] != nil {
                        Text("\(viewModel.courseResults.assignmentGroups[key]?.assignments[assignKey]?.name ?? "") mean : \(courseStats.assignmentStats[assignKey]?.first ?? 0)")
                        Text("\(viewModel.courseResults.assignmentGroups[key]?.assignments[assignKey]?.name ?? "") median : \(courseStats.assignmentStats[assignKey]?.last ?? 0)")
                    }
                }
                Spacer()
            }
            
            
            
        }
    }
}

