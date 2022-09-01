//
//  TabBar.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI
struct TabBar: View {
    
    init(){
        UITabBar().barTintColor = UIColor(Color.red)
    }
    
    var body: some View {
        TabView{
            NavigationView{
                Home()
            }
                .tabItem{
                    Label("Tdolls", systemImage: "magnifyingglass")
                }
            EquipmentsHome()
                .tabItem {
                    Label("Equipamentos", systemImage: "magnifyingglass")
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleTextColor(.Extra)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
