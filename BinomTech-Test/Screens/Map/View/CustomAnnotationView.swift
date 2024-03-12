//
//  CustomAnnotationView.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import MapKit
final class CustomAnnotationView: MKAnnotationView {
    private lazy var persomImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "boy")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = UIImage(named: "pin")
        self.backgroundColor = .clear
        addView(persomImageView)
        NSLayoutConstraint.activate([
            persomImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            persomImageView.topAnchor.constraint(equalTo: topAnchor, constant: (image?.size.height ?? 2) * 0.2),
            persomImageView.heightAnchor.constraint(equalToConstant: ((image?.size.width ?? 2) / 2)),
            persomImageView.widthAnchor.constraint(equalToConstant: (image?.size.width ?? 2 / 2 ))
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }

}

