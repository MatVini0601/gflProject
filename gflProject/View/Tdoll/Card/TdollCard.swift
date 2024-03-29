//
//  TdollCard.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct TdollCard: View {
    @State var tdolls: Tdoll
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: tdolls.image)!){image in
                image
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(16)
            }placeholder: {
                ProgressView()
                    .frame(width: 175, height: 230, alignment: .center)
            }
            //Info
            Text(tdolls.name)
                .font(.custom("Montserrat", size: 18))
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .lineLimit(1)
                .frame(maxWidth: 200, alignment: .leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 1 , y: 5)
        )
        .frame(maxWidth: 200, maxHeight: 300)
    }
}

struct TdollCard_Previews: PreviewProvider {
    static var previews: some View {
        TdollForm(tdoll: Tdoll(
            id: 56,
            image: "https://iopwiki.com/images/a/a2/ST_AR-15_S.png",
            name: "ST AR-15",
            tier: 4,
            manufacturer: "16LAB",
            type: .AR,
            hasMindUpgrade: nil), isEditing: false)
    }
}
