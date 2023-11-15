//
//  CinemaTixSwiftUIApp.swift
//  CinemaTixSwiftUI
//
//  Created by Eky on 15/11/23.
//

import SwiftUI

@main
struct CinemaTixSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
