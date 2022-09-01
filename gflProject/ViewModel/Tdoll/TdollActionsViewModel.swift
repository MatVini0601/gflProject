//
//  TdollPostViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import Foundation

class TdollActionsViewModel: ObservableObject {
    var alertMessage = ""
    var ErrorType: TdollModel.errorTypes = .NoError
    
    func postTdoll(_ tdoll: TdollModel.Tdoll) async -> Void{
        do{
            try await TdollModel().post(tdoll) { isSuccess, error  in
                if isSuccess{ self.alertMessage = "Tdoll salva com sucesso"; return }
                else {
                    self.alertMessage = error.rawValue
                    self.ErrorType = error
                    return
                }
            }
        }
        catch{
            print("erro ao realizar post")
        }
    }
    
    func updateTdoll(id: Int, _ tdoll: TdollModel.Tdoll) async -> Void{
        do{
            try await TdollModel().updateTdoll(id, tdoll, completion: { isSuccess, error in
                if isSuccess{ self.alertMessage = "Tdoll atualizada com sucesso"; return }
                else {
                    debugPrint("Erro ao atualizar")
                    self.alertMessage = error.rawValue
                    self.ErrorType = error
                    return
                }
            })
        }
        catch{
            print("error ao realizar update")
        }
    }
    
    func getTdoll(id: Int) async -> TdollModel.Tdoll?{
        guard let tdoll = try? await TdollModel().getTdollById(id) else { return nil }
        return tdoll
    }
}
