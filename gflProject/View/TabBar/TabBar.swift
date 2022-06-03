//
//  TabBar.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            Home()
                .tabItem{
                    Label("Tdolls", systemImage: "magnifyingglass")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
