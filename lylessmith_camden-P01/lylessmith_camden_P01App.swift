//
//  lylessmith_camden_P01App.swift
//  lylessmith_camden-P01
//
//  Created by Camden Lyles-Smith on 2/27/24.
//

import SwiftUI

@main
struct lylessmith_camden_P01App: App {
    @StateObject var gradesViewModel = GradesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gradesViewModel)
        }.commands {
            CommandGroup(after: CommandGroupPlacement.newItem) {
                Button("Import") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    
                    panel.canChooseDirectories = false
                    
                    if panel.runModal() == .OK {
                        gradesViewModel.url = panel.url
                    }
                }
                .keyboardShortcut("O", modifiers: [.command])
            }
        }
    }
}
