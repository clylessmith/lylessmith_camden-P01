//
//  CSVURLDropDelegate.swift
//  App2_Grades
//
//  Created by Camden Lyles-Smith on 2/14/24.
//

import Foundation
import SwiftUI

struct CSVURLDropDelegate: DropDelegate {
    @Binding var url: URL?
    @Binding var isHoveredOver: Bool
    
    
    func validateDrop(info: DropInfo) -> Bool {
        let state = info.hasItemsConforming(to: [.fileURL])
        
        return state
    }
    
    func dropEntered(info: DropInfo) {
        if info.hasItemsConforming(to: [.fileURL]) {
            isHoveredOver = true
        }
    }
    
    func dropExited(info: DropInfo) {
        isHoveredOver = false
    }
    
    func performDrop(info: DropInfo) -> Bool {
        Task {
            let localURL = await urlFrom(info)
            
            self.url = localURL
            
            isHoveredOver = false
            
        }
        return true
    }
    
    private func urlFrom(_ info: DropInfo) async -> URL? {
        guard let item = info.itemProviders(for: [.fileURL]).first
        else {
            return nil
        }
        
        return await withCheckedContinuation { continuation in
            item.loadItem(forTypeIdentifier: "public.file-url", options: nil) { (urlData, error) in
                
                if let localURLData = urlData as? Data {
                    let localURL = URL(dataRepresentation: localURLData, relativeTo: nil)
                    if localURL?.pathExtension != "csv" {
                        continuation.resume(returning: nil)
                    }
                    else {
                        continuation.resume(returning: localURL)
                    }
                }
                else {
                    continuation.resume(returning: nil)
                }
            }
            
        }
        
    }
}


