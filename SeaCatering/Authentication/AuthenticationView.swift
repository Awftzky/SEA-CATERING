import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var Authentication : AuthData
    @State private var showLogin = true

    var body: some View {
        VStack {
            if showLogin {
                LoginView()
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
            } else {
                RegistrationView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            }

            Button {
                withAnimation {
                    showLogin.toggle()
                }
            } label: {
                Text(showLogin ? "Don't have an account? Sign Up" : "Already have an account? Sign In")
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.vertical)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    @EnvironmentObject var Authentication : AuthData
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AuthData())
    }
}
