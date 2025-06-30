import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home
        case menu
        case subscription
        case contactUs
    }

    var body: some View {
        VStack {
           
            TabView(selection: $selectedTab) {
               
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(Tab.home)

                MealPlansView()
                    .tabItem {
                        Label("Menu", systemImage: "fork.knife")
                    }
                    .tag(Tab.menu)

                SubscriptionView()
                    .tabItem {
                        Label("Subscription", systemImage: "dollarsign.circle.fill")
                    }
                    .tag(Tab.subscription)

                ContactUsView()
                    .tabItem {
                        Label("Information", systemImage: "phone.fill")
                    }
                    .tag(Tab.contactUs)
            }
            .accentColor(.green) // Customize tab bar color
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
