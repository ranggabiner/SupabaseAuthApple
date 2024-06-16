//
//  AuthManager.swift
//  SupabaseAuth
//
//  Created by Rangga Biner on 16/06/24.
//

import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?
}

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://jewngwcrwmlopwjeaxxn.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impld25nd2Nyd21sb3B3amVheHhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg1MTQwMzcsImV4cCI6MjAzNDA5MDAzN30.lfOmqEGGYWFzR7hUBOS5QFPARNwCutqGgVJUQkRWRTs")

    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}
