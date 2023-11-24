//
//  ProfilePage.swift
//  CinemaTix
//
//  Created by Eky on 23/11/23.
//

import SwiftUI
import SPAlert

struct ProfileView: View {
    
    var onLogOut: () -> Void
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    let darkMode: DarkMode = ContainerDI.shared.resolve(DarkMode.self)!
    
    @State private var isDarkMode = false
    @State private var isPresentingActionSheet = false
    
    init(onLogOut: @escaping () -> Void) {
        self.onLogOut = onLogOut
        self.isDarkMode = darkMode.isActive
    }
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    Image("joker")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.accent, lineWidth: 8))
                        .padding(.top, 8)
                    
                    Text(authViewModel.activeUser?.displayName ?? "Null")
                        .font(.title)
                        .bold()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Section {
                    HStack {
                        Text("Username")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text(authViewModel.activeUser?.username ?? "Null")
                    }
                    HStack {
                        Text("Birth Date")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text(dateFormatter.string(for: authViewModel.activeUser?.birthDate) ?? "Null")
                    }
                    HStack {
                        Text("Gender")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text((authViewModel.activeUser?.gender)?.toStr() ?? "Null")
                    }
                }
                
                Section {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark mode")
                    }
                    .onChange(of: isDarkMode) { val in
                        self.darkMode.toggle()
                    }
                    NavigationLink {
                        List {
                            LanguageOptionSection()
                        }
                        .navigationTitle("Change Language")
                    } label: {
                        Text("Change Language")
                    }
                    Button(action: {
                        isPresentingActionSheet.toggle()
                    }) {
                        Text("Log out")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .actionSheet(isPresented: $isPresentingActionSheet) {
                        ActionSheet(
                            title: Text("Log out"),
                            message: Text("Are you sure want to log out ?"),
                            buttons: [
                                .destructive(Text("Log out")) {
                                    self.authViewModel.signOut {
                                        AlertKitAPI.present(
                                            title: "Success Sign Out",
                                            icon: AlertIcon.done,
                                            style: .iOS17AppleMusic,
                                            haptic: .success
                                        )
                                    }
                                    onLogOut()
                                },
                                .cancel()
                            ]
                        )
                    }
                }
            }
            .listStyle(.insetGrouped)
            .background(.clear)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
        .background(.yellow)
    }
}

struct LanguageOptionSection: View {
    
    @State private var isSelected = "en"
    
    var body: some View {
        Section {
            HStack {
                Button {
                    isSelected = "id"
                } label: {
                    Text("Indonesia")
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                if isSelected == "id" {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                }
                
            }
            HStack {
                Button {
                    isSelected = "en"
                } label: {
                    Text("Inggris")
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                if isSelected == "en" {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

struct SettingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = SettingViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView() {
            
        }
    }
}
