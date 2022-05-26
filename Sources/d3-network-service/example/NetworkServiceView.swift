//
//  SwiftUIView.swift
//  
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import SwiftUI

public struct NetworkServiceView: View {
    
    @StateObject var viewModel = ViewModel()
    
    public init(){ }


    public var body: some View {
        VStack(spacing: 15) {

            Button { viewModel.readAll(page: 0) }
            label: { labelBuilder("Read all users by pagination") }

            Button { viewModel.read(id: 1) }
            label: { labelBuilder("Read the user by ID = 1") }

            Button {
                let user = Model(id: 11, name: "Igor")
                viewModel.create(user)
            } label: { labelBuilder("Create a user", .green) }

            Button {
                let user = Model(id: 11, name: "Igor")
                viewModel.update(user)
            } label: { labelBuilder("Update a user", .orange) }

            Button { viewModel.delete(id: 11) }
            label: { labelBuilder("Delete a user", .red) }

        }.padding()
    }

    @ViewBuilder
    func labelBuilder(_ text: String, _ color: Color = .blue) -> some View {
        Text(text)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
        )
    }
}

