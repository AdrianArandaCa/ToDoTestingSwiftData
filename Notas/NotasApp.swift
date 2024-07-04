//
//  NotasApp.swift
//  Notas
//
//  Created by Adrian Aranda Campanario on 2/7/24.
//

import SwiftUI
import SwiftData

@main
struct NotasApp: App {

    //Para el preview del contentview
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Note.self)
        } catch {
            fatalError()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
