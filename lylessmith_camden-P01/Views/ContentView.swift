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
            
            Divider()
            HStack {
                DropFileView(url: $gradesViewModel.url)
                    .frame(minHeight: 50.0)
                    .padding(.horizontal)
                Divider()
                StudentTableView(viewModel: gradesViewModel)
                    .frame(minHeight: 150.0)
                    .padding(.horizontal)
                Divider()
                AssignmentGroupView(assignmentGroups: $gradesViewModel.courseResults.assignmentGroups)
            }
            Divider()
            Text("Course Stats")
                .frame(minWidth: 100.0, minHeight: 50.0)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
