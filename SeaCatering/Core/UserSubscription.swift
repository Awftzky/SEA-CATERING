import Foundation

struct UserSubscription: Identifiable {
    let id = UUID()
    var planName: String
    var mealTypes: [String]
    var deliveryDays: [String]
    var totalPrice: Int
    var status: String 
    var startDate: Date
    var endDate: Date?
    var pauseStartDate: Date?
    var pauseEndDate: Date?
}

import SwiftUI

struct DashboardInfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon).frame(width: 20)
            Text(text)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
