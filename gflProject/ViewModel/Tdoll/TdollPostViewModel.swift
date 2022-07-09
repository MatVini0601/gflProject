//
//  TdollPostViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import Foundation

class TdollPostViewModel: ObservableObject {
    var alertMessage = ""
    var ErrorType: TdollModel.errorTypes = .NoError
    
    func postTdoll(_ tdoll: TdollModel.Tdoll) async throws -> Void{
        try await TdollModel().post(tdoll) { isSuccess, error  in
            if isSuccess{ self.alertMessage = "Tdoll salva com sucesso"; return }
            else {
                self.alertMessage = error.rawValue
                self.ErrorType = error
                return
            }
        }
    }
}
