//
//  ViewModel.swift
//
//  Created by Igor Shelopaev on 26.05.2022.
//

import Foundation
import Combine

final class ViewModel: ObservableObject {

    typealias Output = AnyPublisher<[Model], ServiceError>

    private var subs = Set<AnyCancellable>()

    let network = NetworkService(
        environment: Environment.development)

    func readAll(page: Int) {
        let cfg = UserRestAPI.index(page: page)
        let publisher: Output = network.get(with: cfg)
        onSink(publisher)
    }

    func read(id: Int) {
        let cfg = UserRestAPI.read(id: 1)
        let publisher: Output = network.get(with: cfg)

        onSink(publisher)
    }
    func create(_ user: Model) {
        let cfg = UserRestAPI.create
        let publisher: Output = network.post(user, with: cfg)
        onSink(publisher)
    }

    func update(_ user: Model) {
        let cfg = UserRestAPI.update
        let publisher: Output = network.put(user, with: cfg)
        onSink(publisher)
    }

    func delete(id: Int) {
        let cfg = UserRestAPI.delete(id: id)
        let publisher: Output = network.delete(with: cfg)
        onSink(publisher)
    }

    private func onSink(_ publisher: Output) {
        publisher
            .sink(receiveCompletion: { print("\($0)") }, receiveValue: { print("\($0)") })
            .store(in: &subs)
    }
}

struct Model: IModel {
    var id: Int
    let name: String
}
