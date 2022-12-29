//
//  Search.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 13/06/22.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject private var tdollsListVM: TdollListViewModel
    @EnvironmentObject private var equipmentListVM: EquipmentListViewModel
    @State var search: String = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            HStack{
                TextField("Search", text: $search)
                    .onChange(of: self.search, perform: { newValue in
                        Task{
                            if search.isEmpty { try! await tdollsListVM.getData() }
                            else{ try! await tdollsListVM.getSearch(search) }
                        }
                    })
                    .padding()
                
                Button {
                    Task{
                        try! await tdollsListVM.getSearch(search)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .padding()
                .background(Color.lightYellow)
                .foregroundColor(.black)
                .cornerRadius(16)
            }
            .background(Color.LightGray)
            .cornerRadius(16)
        }
        .padding(.horizontal)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(TdollListViewModel())
            .environmentObject(EquipmentListViewModel())
    }
}
