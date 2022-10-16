//
//  TdollListViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 06/06/22.
//

import Foundation
import SwiftUI

class TdollListViewModel: ObservableObject{
    @Published var tdollsList: [Tdoll] = []
    private let Model: TdollModel = TdollModel()
    
    func getData() async throws -> Void{
        do{
            guard let tdolls = try? await Model.getTdolls() else { return }
            DispatchQueue.main.async{
                self.tdollsList = tdolls
            }
        }
    }
    
    func getSearch(_ search: String) async throws -> Void{
        do{
            guard let searchedTdoll = try? await Model.search(search) else { return }
            DispatchQueue.main.async {
                self.tdollsList = searchedTdoll
            }
        }
    }
}
