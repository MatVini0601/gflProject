//
//  Gallery.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 29/11/22.
//

import Foundation

class Gallery {
    private let baseURL = "http://localhost:3000/tdolls"
    private var gallerySize = 0
    
    struct galleryData: Decodable, Hashable{
        let image_link: String
        let model_name: String
    }
    
    func getGallery(_ id: Int) async throws -> [galleryData]? {
        guard let request = setRequest(method: "GET", string: "\(baseURL)/gallery/\(id)") else { return nil }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
        do{
            let gallery = try JSONDecoder().decode([galleryData].self, from: data)
            gallerySize = gallery.count
            return gallery
        }catch let error as DecodingError{
            print(error.localizedDescription)
        }
        return nil
    }
    
    func hasGallery(_ id: Int) -> Bool {
        return gallerySize > 0
    }
    
    //MARK: AUX
    private func setRequest(method: String, string url: String) -> URLRequest?{
        guard let EPurl = URL(string: url) else { return nil }
        var request = URLRequest(url: EPurl)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
