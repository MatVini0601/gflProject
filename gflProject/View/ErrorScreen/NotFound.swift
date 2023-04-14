//
//  NotFound.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 17/03/23.
//

import SwiftUI

struct NotFound: View {
    @State var message = ""
    
    var body: some View {
        VStack{
            Image("G11-noBG")
                .resizable()
                .frame(maxWidth: 250, maxHeight: 300)
                .grayscale(0.95)
            Text(message)
                .foregroundColor(Color.LightText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct NotFound_Previews: PreviewProvider {
    static var previews: some View {
        NotFound()
    }
}
