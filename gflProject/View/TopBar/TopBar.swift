//
//  TopBar.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Tdoll Index")
                    .font(.custom("Roboto", size: 32))
                Spacer()
                NavigationLink(destination: TdollPost().environmentObject(TdollPostViewModel())) {
                    Text("+")
                        .font(.custom("Roboto", size: 32))
                }
            }
            .padding()
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
