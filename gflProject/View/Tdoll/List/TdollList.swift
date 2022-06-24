//
//  TdollList.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct TdollList: View {
    @EnvironmentObject var tdollsListVM: TdollListViewModel
    
    let collumns = [GridItem(.flexible()),
                    GridItem(.flexible())]
    
    var body: some View {
        VStack{
            Search(type: "Tdoll")
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: collumns, spacing: 20) {
                    ForEach(tdollsListVM.tdollsList, id: \.id){ item in
                        TdollCard(tdolls: item)
                    }
                }
                .padding()
            }
            .task {
                if tdollsListVM.tdollsList.isEmpty{ try! await tdollsListVM.getData() }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TdollList_Previews: PreviewProvider {
    static var previews: some View {
        TdollList()
            .environmentObject(TdollListViewModel())
    }
}
