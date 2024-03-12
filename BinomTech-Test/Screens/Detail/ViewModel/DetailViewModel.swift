//
//  DetailViewModel.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 12.03.2024.
//
protocol DetailViewModelProtocol: AnyObject {
    func viewDidLoaded()
}
final class DetailViewModel {
    weak var view: DetailView?
    fileprivate let person: Location?
    init(view: DetailView? = nil, location: Location?) {
        self.person = location
        self.view = view
    }
}
// MARK:  DetailViewModelProtocol
extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoaded() {
        guard let person = person else { return }
        view?.setName(name: person.id)
        view?.setImage(imageName: "boy")
    }
}
