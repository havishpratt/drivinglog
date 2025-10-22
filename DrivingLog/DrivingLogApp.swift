//
//  DrivingLogApp.swift
//  DrivingLog
//
//  Created by HAVISH PRATTIPATI on 5/21/23.
//

import SwiftUI


@main

struct DrivingLogApp: App {
    @StateObject var session = SessionClass()
    var body: some Scene {
        WindowGroup {
            
            MainContentView()
                .environmentObject(session)
        }
    }
}
