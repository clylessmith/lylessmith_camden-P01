//
//  ContentView.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gradesViewModel:GradesViewModel
    @State var isHoveredOver = false
    
    var body: some View {
        VStack {
            HStack {
                DropFileView(url: $gradesViewModel.url)
                    .frame(maxWidth: 100.0, minHeight: 50.0)
                    .padding(.horizontal)
                StudentTableView(viewModel: gradesViewModel, sortOrder: $gradesViewModel.sortOrder)
                    .frame(minWidth: 450.0, minHeight: 150.0)
                    .padding()
                AssignmentGroupView()
                    .frame(maxWidth: 300.0)
                    .padding(.horizontal)
            }
            Divider()
            CourseStatsView(courseStats: $gradesViewModel.courseResults.courseStats)
                .frame(minWidth: 100.0, minHeight: 50.0)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
