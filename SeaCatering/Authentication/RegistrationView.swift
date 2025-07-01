import SwiftUI

struct RegistrationView: View {

    @EnvironmentObject var Authentication : AuthData

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var passwordError: String? = nil

    private var isFormValid: Bool {
        !fullName.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmPassword
    }

    var body: some View {
        VStack(spacing: 20) {
            Image("SEACatering")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.green, lineWidth: 4)
                )
                .shadow(color: .green.opacity(0.2), radius: 10)
                .padding(.horizontal)
                .padding(.top, 30)

            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.green, .teal],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: .white, radius: 2)

            TextField("Nama Lengkap", text: $fullName)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .autocapitalization(.words)
                .textContentType(.name)

            TextField("Email", text: $email)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textContentType(.emailAddress)

            SecureField("Kata Sandi", text: $password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .textContentType(.newPassword)

            SecureField("Konfirmasi Kata Sandi", text: $confirmPassword)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .textContentType(.newPassword)

            if let error = passwordError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            Button {
                validateAndRegister()
            } label: {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.green : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)

            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("Registrasi")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func validateAndRegister() {
        if password != confirmPassword {
            passwordError = "Kata sandi tidak cocok."
            return
        }

        passwordError = nil

        print("Mencoba mendaftar dengan email: \(email)")

        Authentication.isLoggedIn = true
        Authentication.isCorrect = true
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthData())
    }
}
