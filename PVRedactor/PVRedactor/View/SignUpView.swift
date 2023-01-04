//
//  SignUpView.swift
//  PVRedactor
//
//  Created by Serhii Kopytchuk on 04.01.2023.
//

import SwiftUI

struct SignUpView: View {

    // MARK: - Variables

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""

    // MARK: - EnvironmentObjects

    // MARK: - body
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .frame(width: 80, height: 80) // logo placeholder
                .padding(.top, 40)

            Text("PVRedactor")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color("white"))
                .padding(.bottom, 50)

            textFields
                .padding(.bottom, 30)



            Button {
                // try to sign up
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color("successButtonColor"))
                            .padding(.horizontal)
                    }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)


            signUpMethods

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(colors: [Color("darkBlue"),
                                    Color("darkBlue"),
                                    Color("lightBlue")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
        }
    }

    // MARK: - ViewBuilders

    @ViewBuilder private var textFields: some View {
        VStack {
            Group {
                HStack {
                    TextField("Email", text: $email)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .textFieldStyle(.plain)

                    Button {
                        email = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }

                HStack {
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .textFieldStyle(.plain)

                    Button {
                        password = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                }

                HStack {
                    SecureField("Password confirmation", text: $passwordConfirmation)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .textFieldStyle(.plain)

                    Button {
                        passwordConfirmation = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }

                }

            }
            .padding(.horizontal)
            .background(content: {
                Color("white")
                    .padding(.horizontal)
            })
            .padding(.vertical, 10)
        }

    }

    @ViewBuilder private var signUpMethods: some View {
        HStack {
            Group {
                Button(action: {
                    //google
                }, label: {
                    Image("googleLogo")
                        .resizable()
                })

                Button(action: {
                    // apple
                }, label: {
                    Image("appleLogo")
                        .resizable()
                })

                Button(action: {
                    // facebook
                }, label: {
                    Image("facebookLogo")
                        .resizable()
                })

                Button(action: {
                    // instagram
                }, label: {
                    Image("instagramLogo")
                        .resizable()
                })
            }
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.horizontal, 15)
        }
    }

    // MARK: - functions

}

#if DEBUG
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
