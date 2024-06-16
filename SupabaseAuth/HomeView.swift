//
//  HomeView.swift
//  SupabaseAuth
//
//  Created by Rangga Biner on 16/06/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var appUser: AppUser?
    
    var body: some View {
        VStack {
            Text(appUser?.uid ?? "No User ID")
            Text(appUser?.email ?? "No Email")
            
            Button(action: {
                Task {
                    do {
                        try await AuthManager.shared.signOut()
                        self.appUser = nil
                    } catch {
                        print("Error logging out: \(error)")
                    }
                }
            }) {
                Text("Logout")
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
}

#Preview {
    HomeView(appUser: .constant(.init(uid: "1234", email: "jajang@gmail.com")))
}
