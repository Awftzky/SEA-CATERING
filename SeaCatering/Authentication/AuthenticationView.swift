import SwiftUI

// MARK: - AuthenticationView (Gerbang Utama)
struct AuthenticationView: View {
    @Binding var isLoggedIn: Bool
    
    @State private var showLogin = true

    var body: some View {
        VStack {
            if showLogin {
                LoginView(isLoggedIn: $isLoggedIn)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            } else {
              
                RegistrationView(isLoggedIn: $isLoggedIn)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }
            
            Button {
                withAnimation {
                    showLogin.toggle()
                }
            } label: {
                Text(showLogin ? "Haven't any account? , Sign Up" : "Already have an account? , Sign In")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.vertical)
            }
        }
    }
}

