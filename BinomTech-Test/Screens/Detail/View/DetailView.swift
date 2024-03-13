//
//  DetailView.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import UIKit
protocol DetailViewProtocol: AnyObject {
    func setImage(imageName: String)
    func setName(name: String)
}
final class DetailView: UIViewController {
    var viewModel: DetailViewModel?
    private let contentInsets: CGFloat = 8
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    private lazy var persomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.blue.cgColor
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    private lazy var historyButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.title = "Посмотреть историю"
        conf.titleAlignment = .center
        conf.cornerStyle = .capsule
        let button = UIButton(configuration: conf)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupView()
        viewModel?.viewDidLoaded()
    }
    private func setupView() {
        view.addView(blurEffectView)
        view.addView(persomImageView)
        view.addView(nameLabel)
        view.addView(historyButton)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.25),
            blurEffectView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blurEffectView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            persomImageView.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: -50),
            persomImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            persomImageView.widthAnchor.constraint(equalToConstant: 100),
            persomImageView.heightAnchor.constraint(equalToConstant: 100),
          
            nameLabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: persomImageView.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
           
            historyButton.topAnchor.constraint(equalTo: persomImageView.bottomAnchor, constant: 10),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
// MARK:  DetailViewProtocol
extension DetailView: DetailViewProtocol {
    func setImage(imageName: String) { persomImageView.image = UIImage(named: imageName) }
    func setName(name: String) { nameLabel.text = name }
}

