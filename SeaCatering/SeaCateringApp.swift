//
//  SeaCateringApp.swift
//  SeaCatering
//
//  Created by Arief zaky on 30/06/25.
//

import SwiftUI

@main
struct SeaCateringApp: App {
    // State untuk melacak status login pengguna, awalnya false.
    @State private var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainDashboardView()
            } else {
                AuthenticationView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
