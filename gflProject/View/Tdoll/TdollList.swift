//
//  TdollList.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct TdollList: View {
    @EnvironmentObject var tdollsListVM: TdollListViewModel
    @EnvironmentObject var tdollDetailsVM: TdollDetailsViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @State var isLoading = true
    
    var collumnsIphone: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    var collumnsIpad: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack{
            if !tdollsListVM.tdollsList.isEmpty{
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: horizontalSizeClass == .regular ? collumnsIpad: collumnsIphone, spacing: 20) {
                        ForEach(tdollsListVM.tdollsList, id: \.id){ doll in
                            NavigationLink(
                                destination: TdollDetails(tdoll: doll).environmentObject(TdollDetailsViewModel())) {
                                TdollCard(tdolls: doll)
                            }
                        }
                    }
                    .padding()
                    .background(Color.BackgroundColorList)
                    .foregroundColor(Color.TextPrimary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
            }else if isLoading{
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }else{
                NotFound(message: "Desculpa, não encontramos essa Tdoll")
            }
        }
        .task {
            isLoading = true
            try? await tdollsListVM.getData()
            isLoading = false
        }
    }
}

struct TdollList_Previews: PreviewProvider {
    static var previews: some View {
        TdollList()
            .environmentObject(TdollListViewModel())
            .environmentObject(TdollDetailsViewModel())
    }
}
