import SwiftUI

// .foregroundStyle(
// LinearGradient(
// colors: [.green, .teal],
//    startPoint: .leading,
//   endPoint: .trailing
// )
//  )

struct SubscriptionView: View {
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedPlan: MealPlanOption = .dietPlan
    @State private var selectedMealTypes: Set<MealType> = []
    @State private var selectedDeliveryDays: Set<DeliveryDay> = []
    @State private var allergies: String = ""
    @State private var calculatedPrice: Double = 0.0

    // Enum untuk pilihan paket makanan
    enum MealPlanOption: String, CaseIterable, Identifiable {
        case dietPlan = "Diet Plan"
        case proteinPlan = "Protein Plan"
        case royalPlan = "Royal Plan"

        var id: String { self.rawValue }

        var price: Int {
            switch self {
            case .dietPlan: return 30000
            case .proteinPlan: return 40000
            case .royalPlan: return 60000
            }
        }
    }

    enum MealType: String, CaseIterable, Identifiable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"

        var id: String { self.rawValue }
    }

    // Enum untuk hari pengiriman
    enum DeliveryDay: String, CaseIterable, Identifiable {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"

        var id: String { self.rawValue }
    }

    // Kalkulasi Harga
    private func calculateTotalPrice() {
        let planPrice = Double(selectedPlan.price)
        let numberOfMealTypes = Double(selectedMealTypes.count)
        let numberOfDeliveryDays = Double(selectedDeliveryDays.count)

        if numberOfMealTypes == 0 || numberOfDeliveryDays == 0 {
            calculatedPrice = 0.0
            return
        }

        calculatedPrice = planPrice * numberOfMealTypes * numberOfDeliveryDays * 4.3
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Costumer Information")) {
                    TextField("Full Name ", text: $fullName)
                        .autocapitalization(.words)
                    TextField("Phone Number ", text: $phoneNumber)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Meal package option")) {
                    Picker("Choose package", selection: $selectedPlan) {
                        ForEach(MealPlanOption.allCases) { plan in
                            Text("\(plan.rawValue) (Rp \(plan.price),00)").tag(plan)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section(header: Text("Delivery Time")) {
                    VStack(alignment: .leading) {
                        ForEach(MealType.allCases) { mealType in
                            Toggle(mealType.rawValue, isOn: Binding(
                                get: { self.selectedMealTypes.contains(mealType) },
                                set: { isOn in
                                    if isOn {
                                        self.selectedMealTypes.insert(mealType)
                                    } else {
                                        self.selectedMealTypes.remove(mealType)
                                    }
                                    calculateTotalPrice()
                                }
                            ))
                        }
                    }
                }

                Section(header: Text("Delivery day")) {
                    VStack(alignment: .leading) {
                        ForEach(DeliveryDay.allCases) { day in
                            Toggle(day.rawValue, isOn: Binding(
                                get: { self.selectedDeliveryDays.contains(day) },
                                set: { isOn in
                                    if isOn {
                                        self.selectedDeliveryDays.insert(day)
                                    } else {
                                        self.selectedDeliveryDays.remove(day)
                                    }
                                    calculateTotalPrice()
                                }
                            ))
                        }
                    }
                }

                Section(header: Text("Allergies / Dietary Restrictions (Optional)")) {
                    TextEditor(text: $allergies)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                Section {
                    HStack {
                        Text("Total price:")
                            .font(.headline)
                        Spacer()
                        Text("Rp \(Int(calculatedPrice)),00")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.green, .teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                }

                Button("Purchase now") {

                    if fullName.isEmpty || phoneNumber.isEmpty || selectedMealTypes.isEmpty || selectedDeliveryDays.isEmpty {
                        print("Error , All data must submitted")
                    } else {
                        // Lakukan proses pendaftaran
                        print("Pendaftaran berhasil untuk \(fullName) dengan harga Rp \(Int(calculatedPrice)),00")
                        // TODO: Kirim data ke backend (Level 3 - Bagian 2)
                        // Reset form setelah berhasil
                        resetForm()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.green, .teal],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(30)
                .disabled(fullName.isEmpty || phoneNumber.isEmpty || selectedMealTypes.isEmpty || selectedDeliveryDays.isEmpty) // Disable button if required fields are empty
            }
            .navigationTitle("Subscription List")
            .onAppear {
                calculateTotalPrice()
            }
            .onChange(of: selectedPlan) { _ in calculateTotalPrice() }
        }
    }

    private func resetForm() {
        fullName = ""
        phoneNumber = ""
        selectedPlan = .dietPlan
        selectedMealTypes = []
        selectedDeliveryDays = []
        allergies = ""
        calculatedPrice = 0.0
    }
}

// MARK: - Previews
struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
