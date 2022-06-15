//
//  EquipmentList.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct EquipmentList: View {
    @EnvironmentObject var equipmentListVM: EquipmentListViewModel
    
    let collumns = [GridItem(.flexible(minimum: 0, maximum: .infinity)),
                    GridItem(.flexible(minimum: 0, maximum: .infinity))]
    
    var body: some View {
        VStack{
            Search(type: "Equipment")
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: collumns, spacing: 20) {
                    ForEach(equipmentListVM.equipmentList, id: \.id){ item in
                        EquipmentCard(equipment: item)
                    }
                    .animation(.ripple())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .task {
                try! await equipmentListVM.getData()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct EquipmentList_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentList()
            .environmentObject(EquipmentListViewModel())
    }
}
