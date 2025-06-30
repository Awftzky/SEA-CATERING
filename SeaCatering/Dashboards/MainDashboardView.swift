import SwiftUI

struct MainDashboardView: View {
    @State private var isAdmin: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Select Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 10) {
                    Toggle(isOn: $isAdmin.animation()) {
                        Text("Log in as Admin")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(isAdmin ? Color.blue.opacity(0.1) : Color.green.opacity(0.1))
                    .cornerRadius(15)

                    Text(isAdmin ? "You're viewing the Admin Dashboard options." : "You're viewing the User Dashboard options.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                // Navigation links berdasarkan peran
                if isAdmin {
                    NavigationLink(destination: AdminDashboardView()) {
                        Label("View Admin Dashboard", systemImage: "chart.bar.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .shadow(color: .blue.opacity(0.3), radius: 5, y: 3)
                    }
                } else {
                    NavigationLink(destination: UserDashboardView()) {
                        Label("View User Dashboard", systemImage: "person.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(15)
                            .shadow(color: .green.opacity(0.3), radius: 5, y: 3)
                    }
                }

                // FIX: Menambahkan tombol baru untuk navigasi ke ContentView
                NavigationLink(destination: ContentView()) {
                    Label("Go to Main Page", systemImage: "house.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Dashboard Selection")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Previews
struct MainDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        MainDashboardView()
    }
}
