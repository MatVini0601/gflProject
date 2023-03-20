//
//  Home.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct Home: View {
    private var environment = TdollListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                TopBar().environmentObject(environment)
                TdollList().environmentObject(environment)
            }
            .navigationTitle("Tdolls")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarColor(
            backgroundColor: Color.white.opacity(1),
            titleColor: UIColor(Color.lightYellow),
            blur: UIBlurEffect(style: .dark)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
