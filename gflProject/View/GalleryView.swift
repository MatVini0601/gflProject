//
//  GalleryView.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 14/12/22.
//

import SwiftUI

struct GalleryView: View {
    @Namespace var TdollDetails
    @EnvironmentObject var ViewModel: TdollDetailsViewModel
    
    var body: some View {
        if ViewModel.tdollHasGallery(){
            VStack{
                Text("Gallery")
                    .font(.custom("Montserrat", size: 24))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(ViewModel.gallery, id: \.self){ item in
                            Text(item.model_name)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background{
                                    Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                    if ViewModel.skinNameSelection == item.model_name{
                                        Capsule()
                                            .fill(Color.lightYellow)
                                            .matchedGeometryEffect(id: "SKIN", in: TdollDetails)
                                    }
                                }
                                .lineLimit(1)
                                .onTapGesture {
                                    withAnimation{ViewModel.skinNameSelection = item.model_name}
                                    ViewModel.skinImageLink = item.image_link
                                }
                        }
                    }
                    .padding(1)
                }
                
                AsyncImage(url: URL(string: ViewModel.skinImageLink)){image in
                    image
                        .resizable()
                        .scaledToFill()
                    }placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 200, alignment: .center)
                            .scaledToFill()
                    }
            }
            .padding(.horizontal)
        }
    }
}

