import SwiftUI

// File: AdminDashboardView.swift
// Deskripsi: Placeholder untuk dashboard khusus admin.

struct AdminDashboardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wrench.and.screwdriver.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            Text("Admin Dashboard")
                .font(.largeTitle.bold())
            Text("Admin-specific content will be displayed here, such as user management, order tracking, or system settings.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Admin Panel")
    }
}
