//
//  TopBar.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 19/06/22.
//

import SwiftUI

struct TopBar: View {
    @EnvironmentObject var tdollsListVM: TdollListViewModel
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Image("Bombardment_Fairy_chibi")
                    .resizable()
                    .frame(maxWidth: 36, maxHeight: 36)
                
                
                Search()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
