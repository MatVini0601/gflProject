//
//  Tdoll.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import Foundation
    

class TdollModel{
    func getARSize() async -> Int {
        guard let ars = try? await NetworkManager.shared.getTdollByType(type: .AR) else { return 0 }
        return ars.count
    }
    
    func getSMGSize() async -> Int {
        guard let smgs = try? await NetworkManager.shared.getTdollByType(type: .SMG) else { return 0 }
        return smgs.count
    }
}



