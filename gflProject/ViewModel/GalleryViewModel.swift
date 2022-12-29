//
//  GalleryViewModel.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 14/12/22.
//

import Foundation

class GalleryViewModel: ObservableObject{
    private let GalleryModel = Gallery()
    @Published var skinNameSelection = "Default Skin"
    @Published var skinImageLink = ""
    @Published var gallery: [Gallery.galleryData] = []
    
    func tdollHasGallery() -> Bool{
        return gallery.count > 0
    }
    
    func getTdollGallery(id: Int) async -> Void{
        guard let gallery = try? await GalleryModel.getGallery(id) else { return }
        DispatchQueue.main.async {
            self.gallery = gallery
            self.skinImageLink = gallery.first!.image_link
        }
    }
}
