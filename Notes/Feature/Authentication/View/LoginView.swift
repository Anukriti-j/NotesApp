import SwiftUI
import CoreData

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            
            Text("LOGIN")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.primary)
            
            TextField("Email",text: $viewModel.email)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            
            ZStack(alignment: .trailing) {
                
                Group {
                    if viewModel.showPassword {
                        TextField("Password", text: $viewModel.password)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                
                Button(action: {
                    viewModel.showPassword.toggle()
                }) {
                    Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 32)
            }
            
            Button {
                if viewModel.isFormValid() {
                    viewModel.login()
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Login")
                }
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .foregroundStyle(.white)
        }
        .alert(viewModel.errorMessage ?? StringConstants.alertTitle.rawValue, isPresented: $viewModel.showAlert) {
                   Button("OK", role: .cancel, action: {}) }
        
    }
}

#Preview {
    LoginView()
}
