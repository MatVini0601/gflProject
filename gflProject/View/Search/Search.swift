//
//  Search.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 13/06/22.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var tdollsListVM: TdollListViewModel
    @State var search: String = ""
    let LightGray = Color("LightGray")
    let lightYellow = Color("LightYellow")
    
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
                .background(lightYellow)
                .foregroundColor(.black)
                .cornerRadius(16)
            }
            .background(LightGray)
            .cornerRadius(16)
        }
        .padding(.horizontal)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(TdollListViewModel())
    }
}
