import SwiftUI

struct HomePageView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("SEACatering")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                    .padding(.bottom, 5)

                Text("SEA Catering")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .teal]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .white , radius: 2)


                Text("“Healthy Meals, Anytime, Anywhere”")
                    .font(.title2)
                    .italic()
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Welcome to SEA Catering!")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("SEA Catering provides customizable healthy meal services delivered across cities in Indonesia. We are committed to making healthy eating more accessible for everyone.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                Divider()

                // Key Features Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Our main Feature & Service :")
                        .font(.headline)
                        .padding(.bottom, 5)

                    FeatureRow(icon: "fork.knife", text: "Flexible Meal Customization")
                    FeatureRow(icon: "map.fill", text: "Delivery to All Major Cities in Indonesia")
                    FeatureRow(icon: "info.circle.fill", text: "Detailed Nutritional Information")
                    FeatureRow(icon: "calendar.badge.plus", text: "User-Friendly Subscription System")
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Beranda")
        .navigationBarHidden(true)
    }
}


struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.green)
                .frame(width: 30)
            Text(text)
                .font(.body)
        }
    }
}


