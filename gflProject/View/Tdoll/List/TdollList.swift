//
//  TdollList.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct TdollList: View {
    @EnvironmentObject var tdollsListVM: TdollListViewModel
    @EnvironmentObject var tdollActionVM: TdollActionsViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var collumnsIphone: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    var collumnsIpad: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            Search()
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: horizontalSizeClass! == .regular ? collumnsIpad: collumnsIphone, spacing: 20) {
                    ForEach(tdollsListVM.tdollsList, id: \.id){ item in
                        NavigationLink(
                            destination: TdollDetails(id: item.id, tdoll: item).environmentObject(TdollActionsViewModel())) {
                            TdollCard(tdolls: item)
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                try? await tdollsListVM.getData()
            }
        }
    }
}

struct TdollList_Previews: PreviewProvider {
    static var previews: some View {
        TdollList()
            .environmentObject(TdollListViewModel())
            .environmentObject(TdollActionsViewModel())
    }
}
