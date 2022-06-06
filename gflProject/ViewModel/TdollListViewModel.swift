//
//  TdollListViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 06/06/22.
//

import Foundation

class TdollListViewModel: ObservableObject{
    @Published var tdollsList: [TdollModel.Tdoll] = []
    
    func getData() async throws -> Void{
        do{
            guard let tdolls = try? await TdollModel().getTdolls(completion: { isSuccess in
                if !isSuccess{
                    return
                }
            })else{ print("TdollListViewModel: failed at getting data from the server)"); return}
            DispatchQueue.main.async{
                self.tdollsList = tdolls
            }
        }
    }
}
