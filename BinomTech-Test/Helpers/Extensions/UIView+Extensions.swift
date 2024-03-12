//
//  UIView+Extensions.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import UIKit
extension UIView {
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    func setSimpleConstraints(constant: CGFloat = 0) {
            guard let superview = superview else {
                return
            }
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
            ])
        }
}
