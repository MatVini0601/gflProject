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
        NavigationView{
            Home()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
