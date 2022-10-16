//
//  Home.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct Home: View {    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBar()
            TdollList()
                .environmentObject(TdollListViewModel())
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
