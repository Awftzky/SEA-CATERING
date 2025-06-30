import SwiftUI

// MARK: - Main View for Meal Plans
struct MealPlansView: View {
    
    let mealPlans = [
        MealPlan(
            name: "Diet Plan",
            price: 30000,
            description: "Focus on calorie reduction and balanced nutrition for weight loss.",
            details: "More details about the diet plan: A varied daily menu, controlled portions, high in fiber, and low in saturated fat to effectively support your diet program."
        ),
        MealPlan(
            name: "Protein Plan",
            price: 40000,
            description: "Designed to support muscle growth and recovery, high in lean protein.",
            details: "More details about the Protein Plan: Premium protein sources such as chicken breast, salmon, and eggs. Low in carbohydrates, ideal for those who are physically active and aiming to build muscle mass."
        ),
        MealPlan(
            name: "Royal Plan",
            price: 60000,
            description: "A premium selection with the finest ingredients and exclusive menu for a luxurious dining experience.",
            details: "More details about the Royal Plan: Featuring gourmet dishes crafted by professional chefs, using selected organic and imported ingredients for an unforgettable taste experience"
        )
    ]

    @State private var showingDetail = false
    @State private var selectedPlan: MealPlan?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Our meal package options")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)

                    ForEach(mealPlans) { plan in
                        MealPlanCard(plan: plan) {
                            selectedPlan = plan
                            showingDetail = true
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
        }
     
        .sheet(isPresented: $showingDetail) {
            if let selectedPlan = selectedPlan {
                MealPlanDetailView(plan: selectedPlan)
            }
        }
    }
}

// Data Model
struct MealPlan: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let description: String
    let details: String
}

struct MealPlanCard: View {
    let plan: MealPlan
    let onSeeMoreDetails: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(plan.name)
                .font(.title2) // Dibuat lebih besar
                .fontWeight(.bold)
                .foregroundColor(.green)

            Text("Rp \(plan.price) per meal")
                .font(.headline)
                .fontWeight(.semibold)

            Text(plan.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            Spacer()

            Button(action: onSeeMoreDetails) {
                Text("See Details")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.green, .teal],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .white, radius: 0.50)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
    
struct MealPlanDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let plan: MealPlan

    var body: some View {
        
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(plan.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)

                    Text("Price: Rp \(plan.price) per meal")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Divider()

                    Text("Short description")
                        .font(.headline)
                    Text(plan.description)
                        .font(.body)

                    Divider()

                    Text("Full detail")
                        .font(.headline)
                    Text(plan.details)
                        .font(.body)
                    
                    Spacer(minLength: 30)
                    
                    // IMPROVEMENT: Menambahkan tombol aksi
                    Button(action: {
                        print("Memesan paket: \(plan.name)")
                        // Tambahkan aksi lain di sini, lalu tutup sheet
                        dismiss()
                    }) {
                        Text("Purchase now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.green, .teal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("package options detail")
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Close") {
                    dismiss()
                }
            }
        }
       
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Previews
struct MealPlansView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlansView()
    }
}
