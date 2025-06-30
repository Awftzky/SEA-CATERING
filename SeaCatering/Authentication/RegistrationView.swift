import SwiftUI

struct RegistrationView: View {
    
    @Binding var isLoggedIn: Bool

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var passwordError: String? = nil // State untuk pesan error kata sandi

    // Properti untuk memeriksa apakah form valid
    private var isFormValid: Bool {
        !fullName.isEmpty && !email.isEmpty && !password.isEmpty && password == confirmPassword
    }

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Logo
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

            Text("Sign In")
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

            // Menampilkan pesan error jika kata sandi tidak cocok
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
                    .background(isFormValid ? Color.green : Color.gray) // Warna tombol dinamis
                    .cornerRadius(10)
            }
            .disabled(!isFormValid) // Nonaktifkan tombol jika form tidak valid
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("Registrasi")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Fungsi untuk validasi dan registrasi
    private func validateAndRegister() {
        if password != confirmPassword {
            passwordError = "Kata sandi tidak cocok."
            return
        }
        
        passwordError = nil
        
        print("Mencoba mendaftar dengan email: \(email)")
       
        self.isLoggedIn = true
    }
}

// MARK: - Previews
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(isLoggedIn: .constant(false))
    }
}
