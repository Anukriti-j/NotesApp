//
//  NotesApp.swift
//  Notes
//
//  Created by coditas on 04/12/25.
//

import SwiftUI
import CoreData

@main
struct NotesApp: App {
    let persistence = CorePersistence().container
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistence.viewContext)
        }
    }
}

// UI views for login, listing posts, create new task, update, delete
// api client setup- fetch data from api
// core data setup - login
// core data model for note
// add note apppend to list
// search
// update
//delete


//- auto save while editing
//-last updated timestamp
// sorting - latest first
//search title + description
// update last modifier
