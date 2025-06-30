import SwiftUI

// File: UserDashboardView.swift
// Deskripsi: Menampilkan daftar langganan aktif milik pengguna.

struct UserDashboardView: View {
    @State private var activeSubscriptions: [UserSubscription] = [
        UserSubscription(planName: "Protein Plan", mealTypes: ["Lunch", "Dinner"], deliveryDays: ["Mon", "Tue", "Wed", "Thu", "Fri"], totalPrice: 1720000, status: "Active", startDate: Date().addingTimeInterval(-86400 * 30), endDate: Date().addingTimeInterval(86400 * 60)),
        UserSubscription(planName: "Diet Plan", mealTypes: ["Breakfast"], deliveryDays: ["Sat", "Sun"], totalPrice: 258000, status: "Paused", startDate: Date().addingTimeInterval(-86400 * 10), endDate: Date().addingTimeInterval(86400 * 20), pauseStartDate: Date().addingTimeInterval(-86400 * 5), pauseEndDate: Date().addingTimeInterval(86400 * 5))
    ]

    @State private var showingPauseSheet = false
    @State private var showingCancelAlert = false
    @State private var selectedSubscriptionToManage: UserSubscription?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if activeSubscriptions.isEmpty {
                    Text("You don't have any active subscriptions.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(activeSubscriptions) { subscription in
                        UserSubscriptionCard(subscription: subscription) { action in
                            selectedSubscriptionToManage = subscription
                            switch action {
                            case .pause: showingPauseSheet = true
                            case .cancel: showingCancelAlert = true
                            case .activate: activateSubscription(subscription)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("My Subscriptions")
        .sheet(isPresented: $showingPauseSheet) {
            if let subscription = selectedSubscriptionToManage {
                PauseSubscriptionView(subscription: subscription) { updatedSubscription in
                    if let index = activeSubscriptions.firstIndex(where: { $0.id == updatedSubscription.id }) {
                        activeSubscriptions[index] = updatedSubscription
                    }
                }
            }
        }
        .alert("Cancel Subscription", isPresented: $showingCancelAlert, presenting: selectedSubscriptionToManage) { subscription in
            Button("Confirm Cancel", role: .destructive) {
                cancelSubscription(subscription)
            }
            Button("Back", role: .cancel) { }
        } message: { subscription in
            Text("Are you sure you want to cancel your '\(subscription.planName)' subscription?")
        }
    }

    private func cancelSubscription(_ subscription: UserSubscription) {
        if let index = activeSubscriptions.firstIndex(where: { $0.id == subscription.id }) {
            activeSubscriptions[index].status = "Cancelled"
        }
    }

    private func activateSubscription(_ subscription: UserSubscription) {
        if let index = activeSubscriptions.firstIndex(where: { $0.id == subscription.id }) {
            activeSubscriptions[index].status = "Active"
            activeSubscriptions[index].pauseStartDate = nil
            activeSubscriptions[index].pauseEndDate = nil
        }
    }
}


// MARK: - Reusable UserSubscriptionCard
struct UserSubscriptionCard: View {
    let subscription: UserSubscription
    let onManage: (SubscriptionAction) -> Void
    enum SubscriptionAction { case pause, cancel, activate }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(subscription.planName)
                    .font(.title3.bold())
                    .foregroundColor(.green)
                Spacer()
                Text(subscription.status)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(6)
            }
            VStack(alignment: .leading, spacing: 5) {
                DashboardInfoRow(icon: "fork.knife", text: subscription.mealTypes.joined(separator: ", "))
                DashboardInfoRow(icon: "calendar.day.timeline.leading", text: subscription.deliveryDays.joined(separator: ", "))
                DashboardInfoRow(icon: "dollarsign.circle", text: "Rp \(subscription.totalPrice)")
                Divider().padding(.vertical, 4)
                
                // FIX: Mengubah cara memformat tanggal agar kompatibel
                DashboardInfoRow(icon: "play.circle", text: "Start: \(DateFormatter.shortDate.string(from: subscription.startDate))")
                
                if let endDate = subscription.endDate {
                    DashboardInfoRow(icon: "stop.circle", text: "End: \(DateFormatter.shortDate.string(from: endDate))")
                }
                
                if subscription.status == "Paused", let start = subscription.pauseStartDate, let end = subscription.pauseEndDate {
                     DashboardInfoRow(icon: "pause.circle.fill", text: "Paused: \(DateFormatter.shortDate.string(from: start)) to \(DateFormatter.shortDate.string(from: end))")
                        .foregroundColor(.orange)
                }
            }
            HStack {
                Spacer()
                if subscription.status == "Active" {
                    Button("Pause", systemImage: "pause.fill") { onManage(.pause) }.buttonStyle(.borderedProminent).tint(.orange)
                }
                if subscription.status == "Paused" {
                    Button("Activate", systemImage: "play.fill") { onManage(.activate) }.buttonStyle(.borderedProminent).tint(.blue)
                }
                if subscription.status != "Cancelled" {
                    Button("Cancel", systemImage: "xmark.circle") { onManage(.cancel) }.buttonStyle(.borderedProminent).tint(.red)
                }
            }
            .font(.caption)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private var statusColor: Color {
        switch subscription.status {
        case "Active": return .green
        case "Paused": return .orange
        case "Cancelled": return .red
        default: return .gray
        }
    }
}
