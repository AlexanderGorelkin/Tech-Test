//
//  BaseButton.swift
//  BinomTech-Test
//
//  Created by Александр Горелкин on 11.03.2024.
//

import UIKit
final class CustomButton: UIButton {
    override var isHighlighted: Bool {
             didSet {
                 UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                     self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
                 }, completion: nil)
             }
         }
     
     override func tintColorDidChange() {
         super.tintColorDidChange()
         if tintAdjustmentMode == .dimmed {
             self.imageView?.tintColor = .systemGray3
             self.backgroundColor = .clear
         } else {
             self.imageView?.tintColor = .white
             self.setTitleColor(.white, for: .normal)
             self.backgroundColor = .clear
         }
     }
    
    init(imageName: String, action: Selector) {
        super.init(frame: .zero)
        setImage(.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(.init(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        tintColorDidChange()
        addTarget(nil, action: action, for: .touchUpInside)
        setInsets()
    }
    func setInsets() {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .all
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
