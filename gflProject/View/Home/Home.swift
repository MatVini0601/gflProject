//
//  Home.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        Text("Post")
            .onTapGesture {
                let tdoll = TdollModel.Tdoll(id: 55, image: "Some Image", name: "M4A1", manufacturer: "16LAB", type: .AR)
                TdollModel().post(tdoll) { isSuccess in
                    if !isSuccess{
                        print("deu errado")
                    }
                }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
