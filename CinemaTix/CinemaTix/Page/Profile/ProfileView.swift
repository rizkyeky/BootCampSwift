//
//  ProfilePage.swift
//  CinemaTix
//
//  Created by Eky on 23/11/23.
//

import SwiftUI

struct ProfileView: View {
    
    let authViewModel = ContainerDI.shared.resolve(AuthViewModel.self)!
    
    @State var isDarkMode = false
    
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
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Username")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text(authViewModel.activeUser?.username ?? "Null")
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Birth Date")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text((authViewModel.activeUser?.birthDate)?.formatted() ?? "Null")
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Gender")
                            .font(.headline)
                            .bold()
                        Spacer()
                        Text((authViewModel.activeUser?.gender)?.formatted() ?? "Null")
                    }
                    .padding(.bottom, 4)
                }
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)

                
                ForEach(0..<5) { i in
                    Section {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                            .onChange(of: isDarkMode) { val in
                                
                            }
                        
                        Text("Item 2")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .background(.clear)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(Text("Profile"))
            
        }
        .background(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
