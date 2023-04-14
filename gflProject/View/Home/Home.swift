//
//  Home.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    private var environment = TdollListViewModel()
    
    //Funcs
    func setAppTheme(){
        //MARK: use saved device theme from Toolbar
//        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
//        changeDarkMode(state: isDarkModeOn)
        
        //MARK: or use device theme
        if (colorScheme == .dark)
         {
             isDarkModeOn = true
         }
         else{
             isDarkModeOn = false
         }
        changeDarkMode(state: isDarkModeOn)
    }

    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                TopBar().environmentObject(environment)
                TdollList().environmentObject(environment)
            }
            .navigationTitle("Tdolls")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.BackgroundColor)
            .toolbar {
                //MARK: Change Theme
                ToolbarItem {
                    Button {
                        isDarkModeOn.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color.Accent)
                    }
                }
                //MARK: New/Edit Tdoll
                ToolbarItem {
                    NavigationLink {
                        TdollForm(tdoll: nil, isEditing: false)
                    } label: {
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(Color.Accent)

                    }
                }
            }
        }
        .navigationBarColor(
            backgroundColor: Color.BackgroundColor,
            titleColor: UIColor(Color.Accent),
            blur: UIBlurEffect(style: .dark)
        )
        .onAppear {
            setAppTheme()
        }
        .onChange(of: isDarkModeOn) { state  in
            changeDarkMode(state: state)
        }
        .buttonStyle(PlainButtonStyle())
        .navigationViewStyle(.stack)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
