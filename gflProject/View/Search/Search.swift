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
    @State private var isHidden = true
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Spacer()
            HStack{
                if !isHidden{
                    TextField("Search", text: $search)
                        .onChange(of: self.search, perform: { _ in
                            Task{
                                if search.isEmpty { try! await tdollsListVM.getData() }
                                else{ try! await tdollsListVM.getSearch(search) }
                            }
                        })
                        .onChange(of: isFocused, perform: { _ in
                            if !isFocused {
                                isHidden.toggle()
                                search = ""
                            }
                        })
                        .focused($isFocused)
                        .padding(.horizontal)
                }
                
                Button {
                    isHidden.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 12, height: 12)
                }
                .padding(12)
                .background(Color.lightYellow)
                .foregroundColor(.black)
                .cornerRadius(6)
            }
            .background(Color.LightGray)
            .frame(maxHeight: 36)
            .cornerRadius(16)
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(TdollListViewModel())
            .environmentObject(EquipmentListViewModel())
    }
}
