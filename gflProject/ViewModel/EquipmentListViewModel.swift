//
//  EquipmentListViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 13/06/22.
//

import Foundation

class EquipmentListViewModel: ObservableObject {
    @Published var equipmentList: [EquipmentModel.Equipment] = []
    
    func getData() async throws -> Void{
        do{
            guard let equipments = try? await EquipmentModel().getEquipments() else { return }
            DispatchQueue.main.async {
                self.equipmentList = equipments
            }
        }
    }
}
