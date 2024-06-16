//
//  SignInView.swift
//  SupabaseAuth
//
//  Created by Rangga Biner on 16/06/24.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    let signInApple = SignInApple()

    func signInWithApple() async throws -> AppUser {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
}

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack  {
            Button {
                Task {
                    do {
                       let appUser = try await viewModel.signInWithApple()
                        self.appUser = appUser
                    } catch {
                        print("error signing in")
                    }
                }
            } label: {
                Text("Sign in with Apple")
                    .foregroundStyle(Color(.black))
            }
        }
        .padding()
    }
}

#Preview {
    SignInView(appUser: .constant(.init(uid: "1234", email: "Jajang@gmail.com")))
}
