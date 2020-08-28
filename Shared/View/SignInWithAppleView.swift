//
//  SignInWithAppleView.swift
//  TodoList
//
//  Created by Piotr Suwara on 27/8/20.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator = SignInWithAppleCoordinator()
    var body: some View {
        VStack {
            Text("Please sign in here")
            SignInWithAppleButton()
                .frame(width: 200, height: 45)
                .onTapGesture{
                    coordinator.startSignInWithAppleFlow {
                        print ("Signed in with Apple!")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
        }
        
    }
}

struct SignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleView()
    }
}
