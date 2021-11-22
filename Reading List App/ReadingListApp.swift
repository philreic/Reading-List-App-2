//
//  Reading_List_AppApp.swift
//  Reading List App
//
//  Created by CodeWithChris on 2021-04-26.
//

import SwiftUI
import Firebase

@main
struct Reading_List_App: App {
    init() {
        // Set-up Firebase for the app
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ReadingListModel())
        }
    }
}
