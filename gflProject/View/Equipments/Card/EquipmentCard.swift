//
//  EquipmentCard.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/06/22.
//

import SwiftUI

struct EquipmentCard: View {
    @State var equipment: EquipmentModel.Equipment
    let lightYellow = Color("LightYellow")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: equipment.image)!){image in
                image
                    .resizable()
                    .scaledToFill()
                    .background(lightYellow)
                    .cornerRadius(16)
            }placeholder: {
                ProgressView()
                    .frame(maxWidth: 200, maxHeight: 300, alignment: .center)
            }
            //Info
            Text(equipment.name)
                .font(.custom("Montserrat", size: 18))
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 1 , y: 5)
        )
        .frame(maxWidth: 200, maxHeight: 300)
    }
}

struct EquipmentCard_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentCard(equipment:
            EquipmentModel.Equipment(
                id: 1,
                image: "https://iopwiki.com/images/0/07/16Lab_Telescopic_Sight.png",
                name: "16Lab 6-24X56",
                type: .ACCESSORIES)
        )
    }
}
