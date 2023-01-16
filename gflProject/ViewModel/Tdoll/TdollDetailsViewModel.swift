//
//  TdollDetailsViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 06/12/22.
//

import Foundation

class TdollDetailsViewModel: ObservableObject {
    @Published var update = false
    var alertMessage = ""
    var ErrorType: NetworkManager.errorTypes = .NoError

    //MARK: Tdoll
    private let Model = TdollModel()
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
    
    //MARK: Tags
    private let TagModel = Tags()
    @Published var tags: [Tags.tagData] = []
    
    func getTdollTags(id: Int)async -> Void{
        guard let tags = try? await TagModel.getTags(id) else { return }
        DispatchQueue.main.async {
            self.tags = tags
        }
    }
    
    func tdollHasTags() -> Bool{
        return TagModel.hasTags()
    }
    
    //MARK: Gallery
    private let GalleryModel = Gallery()
    @Published var skinNameSelection = "Default Skin"
    @Published var skinImageLink = ""
    @Published var gallery: [Gallery.galleryData] = []
    
    func tdollHasGallery() -> Bool{
        return GalleryModel.hasGallery()
    }
    
    func getTdollGallery(id: Int) async -> Void{
        guard let gallery = try? await GalleryModel.getGallery(id) else { return }
        DispatchQueue.main.async {
            self.gallery = gallery
            self.skinImageLink = gallery.first!.image_link
        }
    }
    
    //MARK: Aux
    private let LAB = "16LAB Research Institute (also rendered “16Lab”) is the company created by Persicaria in 2057, and one of IOP's first-party manufacturer and R&D partners in the Tactical Doll market."
    private let IOP = "Important Operations Prototype Manufacturing Company, or IOP, is a R&D and manufacturing company specializing in Tactical Dolls, directed by Havier Witkin. IOP is the world leader in Tactical Doll production since World War Three thanks to 16LAB's groundbreaking technological research, and the main supplier of workforce for Griffin & Kryuger PMC."
    private let Unknown = "This doll is not originally from the game. it`s a character from a collab so it`s either don`t have a manufacturer or we don`t know who they are."
    
    func getLAB() -> String{ return self.LAB }
    func getIOP() -> String{ return self.IOP }
    func getUnknow() -> String { return self.Unknown }
    
}

