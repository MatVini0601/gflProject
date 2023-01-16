//
//  TagsView.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 28/12/22.
//

import SwiftUI

struct TagsView: View {
    @EnvironmentObject var ViewModel: TdollDetailsViewModel
    var body: some View {
        if ViewModel.tdollHasTags(){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top){
                    ForEach(ViewModel.tags, id: \.self){tag in
                        Text(tag.tagName)
                            .foregroundColor(Color.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background{
                                Capsule().stroke(lineWidth: 1).fill(Color.LightGray)
                                    Capsule()
                                    .fill(Color.Gray)
                                }
                    }
                    .contentShape(Capsule())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 2)
                .padding(.horizontal, 1)
            }
        }
    }
}
