import SwiftUI

// MARK: - ContactUsView (Tersinkronisasi)
struct ContactUsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detail contact")) {
                    ContactRow(iconName: "person.circle.fill", title: "Manager", value: "Brian")
                    ContactRow(iconName: "phone.fill", title: "Phone number", value: "08123456789")
                    
                    ContactRow(iconName: "envelope.fill", title: "Email", value: "info@seacatering.com")
                }
                
                Section(header: Text("Head Office address")) {
                    ContactRow(iconName: "mappin.and.ellipse", title: "Location", value: "SEA Tower, Jl. Katering Sehat No. 1, Jakarta, Indonesia")
                }

                Section(header: Text("Customer service")) {
                    if let url = URL(string: "tel:08123456789") {
                        Link(destination: url) {
                            Label("Phone Call", systemImage: "phone.circle.fill")
                        }
                    }
                    if let url = URL(string: "https://wa.me/628123456789") {
                        Link(destination: url) {
                            Label("WhatsApp Chat", systemImage: "bubble.left.and.bubble.right.fill")
                        }
                    }
                }
                .foregroundColor(.green)

                // FIX: Menambahkan seksi baru dengan tombol ke dashboard
                Section(header: Text("Dashboard")) {
                    NavigationLink(destination: MainDashboardView()) {
                        Label("Go to My Dashboard", systemImage: "person.crop.rectangle.stack.fill")
                    }
                }
            }
            .navigationTitle("Information")
        }
    }
}

struct ContactRow: View {
    let iconName: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: iconName)
                .frame(width: 25, alignment: .center)
                .foregroundColor(.green)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(value)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}


// MARK: - Previews
struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
