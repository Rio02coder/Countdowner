//
//  AuthModel.swift
//  Countdowner
//
//  Created by shmeelok chakraborty on 12/21/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

@MainActor
class AuthenticationViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmPassword: String = ""
  @Published var authenticationState: AuthenticationState = .unauthenticated
  @Published var flow: AuthenticationFlow = .login
  @Published var user: FirebaseAuth.User?
  @Published var isValid: Bool  = false
  @Published var errorMessage: String = ""
  @Published var displayName: String = ""
  
  init() {
    registerAuthStateHandler()
  }

  private var authStateHandler: AuthStateDidChangeListenerHandle?
  
  /**
      Method to initialize the user on a successful login
   */
  func onSuccessfulSignIn(user: FirebaseAuth.User?) {
      self.user = user
      self.authenticationState = user == nil ? .unauthenticated : .authenticated
      self.displayName = self.user?.email ?? ""
      
  }

  func registerAuthStateHandler() {
    if authStateHandler == nil {
      authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
          self.user = user
          self.authenticationState = user == nil ? .unauthenticated : .authenticated
          self.displayName = user?.email ?? ""
      }
    }
  }

  private func wait() async {
    do {
      print("Wait")
      try await Task.sleep(nanoseconds: 1_000_000_000)
      print("Done")
    }
    catch { }
  }

  func reset() {
    flow = .login
    email = ""
    password = ""
    confirmPassword = ""
  }
}

extension AuthenticationViewModel {
  func signOut() {
    do {
      try Auth.auth().signOut()
        
    }
    catch {
      print(error)
      errorMessage = error.localizedDescription
    }
  }
    
    func deleteAccount() async -> Bool {
        do {
          try await user?.delete()
          return true
        }
        catch {
          errorMessage = error.localizedDescription
          return false
        }
      }
}



enum AuthenticationError: Error {
  case tokenError(message: String)
}

extension AuthenticationViewModel {
  func signInWithGoogle() async -> Bool {
    guard let clientID = FirebaseApp.app()?.options.clientID else {
      fatalError("No client ID found in Firebase configuration")
    }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config

    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first,
          let rootViewController = window.rootViewController else {
      print("There is no root view controller!")
      return false
    }

      do {
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        let user = userAuthentication.user
        guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
        let accessToken = user.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                       accessToken: accessToken.tokenString)
        let firebaseUser = try await Auth.auth().signIn(with: credential)
        return await createUserIfNotExists(uid: firebaseUser.user.uid, email: firebaseUser.user.email)
      }
      catch {
        print(error.localizedDescription)
        self.errorMessage = error.localizedDescription
        return false
      }
  }
}
