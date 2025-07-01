import SwiftUI

struct LoginView: View {
    @EnvironmentObject var Authentication : AuthData
    @State private var email: String = ""
    @State private var password: String = ""

    func CheckLogin() {
        if ( email == "user@mail.com" && password == "123") {
            Authentication.isLoggedIn = true
            Authentication.isCorrect = true
        } else {
            Authentication.isLoggedIn = false
            Authentication.isCorrect = false
        }
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

            VStack(spacing: 15) {
                Text("Username/Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Username...", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                if (!Authentication.isCorrect) {
                    Text("Wrong Email or Password").foregroundStyle(Color.red)
                }

                Button("Forgot Password?") {
                    print("Forgot Password tapped")
                }
                .font(.subheadline)
                .foregroundStyle(Color.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 20)

            Button {
                self.CheckLogin()
            } label: {
                Text("Login")
                    .foregroundStyle(Color.white).font(.headline).bold()
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [.green, .teal], startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(20)
            }
            .disabled(email.isEmpty || password.isEmpty)
            .padding(.horizontal, 20)

            HStack {
                Rectangle().frame(height: 1).foregroundStyle(Color.gray.opacity(0.3))
                Text("Or").font(.caption).foregroundStyle(Color.gray)
                Rectangle().frame(height: 1).foregroundStyle(Color.gray.opacity(0.3))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            VStack(spacing: 10) {
                Button(action: {
                    print("Login with Apple")
                    Authentication.isLoggedIn = true
                    Authentication.isCorrect = true
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                        Text("Login with Apple")
                    }
                }
                .buttonStyle(SocialLoginButtonStyle(backgroundColor: .black, foregroundColor: .white))

                Button(action: {
                    print("Login with Google")
                    Authentication.isLoggedIn = true
                    Authentication.isCorrect = true
                }) {
                    HStack {
                        Image("Google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("Login with Google")
                    }
                }
                .buttonStyle(SocialLoginButtonStyle(backgroundColor: .white, foregroundColor: .black, hasBorder: true))
            }
            .padding(.horizontal, 20)

            Spacer()
        }
    }
}

struct SocialLoginButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    var hasBorder: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
            .overlay(
                hasBorder ? RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1) : nil
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthData())
    }
}
