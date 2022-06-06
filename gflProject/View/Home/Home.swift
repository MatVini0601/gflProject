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
            TdollList()
                .environmentObject(TdollListViewModel())
        }
//        HStack(spacing: 20){
//            Text("Post")
//                .onTapGesture {
//                    let tdoll = TdollModel.Tdoll(id: 56, image: "Some Image", name: "RO635", manufacturer: "16LAB", type: .AR)
//                    TdollModel().post(tdoll) { isSuccess in
//                        if !isSuccess{
//                            print("deu errado")
//                        }
//                    }
//                }
//
//            Text("Get")
//                .task {
//                    let tdolls = try? await TdollModel().getTdolls { isSuccess in
//                        if isSuccess{
//                            print("Funcionou")
//                        }
//                        else{
//                            print("deu erro")
//                        }
//                    }
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
