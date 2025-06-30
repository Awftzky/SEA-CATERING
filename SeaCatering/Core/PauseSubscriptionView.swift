import SwiftUI

struct PauseSubscriptionView: View {
    // Environment value untuk menutup sheet secara otomatis
    @Environment(\.dismiss) var dismiss

    // Data langganan yang akan dijeda
    var subscription: UserSubscription
    
    // Closure untuk mengirim kembali data yang sudah diperbarui
    var onUpdate: (UserSubscription) -> Void

    // State untuk mengelola tanggal yang dipilih
    @State private var selectedPauseStartDate: Date
    @State private var selectedPauseEndDate: Date

    // Initializer kustom untuk mengatur tanggal default
    init(subscription: UserSubscription, onUpdate: @escaping (UserSubscription) -> Void) {
        self.subscription = subscription
        self.onUpdate = onUpdate
        
        // Atur tanggal mulai default ke hari ini atau tanggal jeda yang sudah ada
        let startDate = subscription.pauseStartDate ?? Date()
        
        // Atur tanggal akhir default ke 7 hari dari tanggal mulai, atau tanggal akhir yang sudah ada
        let endDate = subscription.pauseEndDate ?? Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        
        // Inisialisasi state dengan nilai default
        self._selectedPauseStartDate = State(initialValue: startDate)
        // Pastikan tanggal akhir tidak pernah lebih awal dari tanggal mulai
        self._selectedPauseEndDate = State(initialValue: endDate < startDate ? Calendar.current.date(byAdding: .day, value: 7, to: startDate)! : endDate)
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Pause Duration") {
                    DatePicker(
                        "Start Date",
                        selection: $selectedPauseStartDate,
                        in: Date()..., // Pengguna tidak bisa memilih tanggal di masa lalu
                        displayedComponents: .date
                    )
                    
                    DatePicker(
                        "End Date",
                        selection: $selectedPauseEndDate,
                        in: selectedPauseStartDate..., // Tanggal akhir harus setelah tanggal mulai
                        displayedComponents: .date
                    )
                }

                Section {
                    Button("Confirm Pause") {
                        confirmAndDismiss()
                    }
                    // Membuat tombol lebih menonjol
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.orange) // Memberi warna latar pada tombol di dalam Form
                }
            }
            .navigationTitle("Pause Subscription")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Fungsi untuk menangani logika konfirmasi
    private func confirmAndDismiss() {
        var updatedSubscription = subscription
        updatedSubscription.status = "Paused"
        updatedSubscription.pauseStartDate = selectedPauseStartDate
        updatedSubscription.pauseEndDate = selectedPauseEndDate
        
        // Kirim kembali data yang telah diperbarui
        onUpdate(updatedSubscription)
        
        // Tutup sheet
        dismiss()
    }
}

// MARK: - Preview
struct PauseSubscriptionView_Previews: PreviewProvider {
    // Data dummy untuk kebutuhan preview
    static let sampleSubscription = UserSubscription(
        planName: "Protein Plan",
        mealTypes: ["Lunch"],
        deliveryDays: ["Mon"],
        totalPrice: 40000,
        status: "Active",
        startDate: Date()
    )

    static var previews: some View {
        PauseSubscriptionView(subscription: sampleSubscription) { updatedSubscription in
            print("Subscription updated: \(updatedSubscription)")
        }
    }
}
