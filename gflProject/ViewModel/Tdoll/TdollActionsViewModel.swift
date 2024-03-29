//
//  TdollPostViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import Foundation

class TdollActionsViewModel: ObservableObject {
    private let Model = TdollModel()
    private let GalleryModel = Gallery()
    private let TagModel = Tags()
    
    private let LAB = "16LAB Research Institute (also rendered “16Lab”) is the company created by Persicaria in 2057, and one of IOP's first-party manufacturer and R&D partners in the Tactical Doll market."
    private let IOP = "Important Operations Prototype Manufacturing Company, or IOP, is a R&D and manufacturing company specializing in Tactical Dolls, directed by Havier Witkin. IOP is the world leader in Tactical Doll production since World War Three thanks to 16LAB's groundbreaking technological research, and the main supplier of workforce for Griffin & Kryuger PMC."
    private let Unknown = "This doll is not originally from the game. it`s a character from a collab so it`s either don`t have a manufacturer or we don`t know who they are."
    var alertMessage = ""
    var ErrorType: NetworkManager.errorTypes = .NoError

    //MARK: Tdoll
    func postTdoll(_ tdoll: Tdoll) async -> Void{
        do{
            try await NetworkManager.shared.post(tdoll) { isSuccess, error  in
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
            try await NetworkManager.shared.updateTdoll(id, tdoll, completion: { isSuccess, error in
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
        guard let tdoll = try? await NetworkManager.shared.getTdollById(id) else { return nil }
        return tdoll
    }
    func deleteTdoll(id: Int) async {
        NetworkManager.shared.deleteTdoll(id) { deleted, error in
            if deleted { self.alertMessage = "Tdoll excluída com sucesso"; return}
            else {
                self.alertMessage = error.rawValue
                self.ErrorType = .DeleteError
                return
            }
        }
    }
    
    //MARK: Gallery
    func getTdollGallery(id: Int) async -> [Gallery.galleryData]{
        guard let gallery = try? await GalleryModel.getGallery(id) else { return [] }
        return gallery
    }
    func tdollHasGallery() -> Bool{
       return GalleryModel.hasGallery()
    }
    
    //MARK: Tags
    func getTdollTags(id: Int) async -> [Tags.tagData]{
        guard let tags = try? await TagModel.getTags(id) else { return [] }
        return tags
    }
    func tdollHasTags() -> Bool{
        return TagModel.hasTags()
    }
    
    
    //MARK: Aux
    func getLAB() -> String{ return self.LAB }
    func getIOP() -> String{ return self.IOP }
    func getUnknow() -> String { return self.Unknown }
}
