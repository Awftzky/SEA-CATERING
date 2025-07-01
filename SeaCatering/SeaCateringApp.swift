import SwiftUI

@main
struct SeaCateringApp: App {

    @StateObject var Authentication = AuthData()

    var body: some Scene {
        WindowGroup {
            if Authentication.isLoggedIn {
                MainDashboardView()
                    .environmentObject(Authentication)
            } else {
                AuthenticationView()
                    .environmentObject(Authentication)
            }
        }
    }
}
