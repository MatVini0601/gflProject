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
//        HStack(spacing: 20){
//            Text("Search")
//                .task {
//                    let res = try? await TdollModel().getTdollByType(type: .AR)
//                    print(res)
//                }
//
//            Text("Get")
//                .task {
//                    let tdolls = try? await TdollModel().getTdolls()
//                    print(tdolls!)
//                }
//        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
