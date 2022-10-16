//
//  TdollPost.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import SwiftUI

struct TdollPost: View {
    @State var tdoll: Tdoll?
    
    //Parametro vem da View TdollDetail ou TopBar
    @State var isEditing: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 0){
                TdollForm(tdoll: tdoll ?? nil, isEditing: isEditing)
                    .environmentObject(TdollActionsViewModel())
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .navigationTitle("Nova Tdoll")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TdollPost_Previews: PreviewProvider {
    static var previews: some View {
        TdollPost(isEditing: false)
    }
}
