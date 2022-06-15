//
//  EquipmentsHome.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 13/06/22.
//

import SwiftUI

struct EquipmentsHome: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            EquipmentList()
                .environmentObject(EquipmentListViewModel())
        }
    }
}

struct EquipmentsHome_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentsHome()
    }
}
