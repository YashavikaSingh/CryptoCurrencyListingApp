//
//  CryptoCurrencyListingAppApp.swift
//  CryptoCurrencyListingApp
//
//  Created by Yashavika Singh on 25.05.24.
//

import SwiftUI

@main
struct CryptoCurrencyListingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
