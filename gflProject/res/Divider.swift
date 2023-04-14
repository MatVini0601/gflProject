//
//  Divider.swift
//  gflProject
//
//  Created by Matheus Vinicius Mota Rodrigues on 03/04/23.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.7))
            .frame(height: 1)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        Divider()
    }
}
