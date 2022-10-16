//
//  TdollPostViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import Foundation

class TdollActionsViewModel: ObservableObject {
    var alertMessage = ""
    private let Model: TdollModel = TdollModel()
    var ErrorType: TdollModel.errorTypes = .NoError
    
    
    func postTdoll(_ tdoll: Tdoll) async -> Void{
        do{
            try await Model.post(tdoll) { isSuccess, error  in
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
    
    func updateTdoll(id: Int, _ tdoll: Tdoll) async -> Void{
        do{
            try await Model.updateTdoll(id, tdoll, completion: { isSuccess, error in
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
    
    func getTdoll(id: Int) async -> Tdoll?{
        guard let tdoll = try? await Model.getTdollById(id) else { return nil }
        return tdoll
    }
    
    func getTdollGallery(id: Int) async -> [TdollModel.galleryLinks]{
        guard let gallery = try? await Model.getTdollGallery(id) else { return [] }
        return gallery
    }
    
    func getTdollTags(id: Int) async -> [TdollModel.tdollTags]{
        guard let tags = try? await Model.getTdollTags(id) else { return [] }
        return tags
    }
}
