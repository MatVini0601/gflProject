//
//  AsyncImagePreview.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 20/08/22.
//

import SwiftUI

struct AsyncImagePreview: View {
    @Binding var url: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            AsyncImage(url: URL(string: url))
                .frame(width: 200, height: 300)
                .cornerRadius(16)
                .padding(.bottom, 20)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.7))
                .frame(height: 1)
                .padding()
        }
    }
}

