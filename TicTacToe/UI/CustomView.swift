//
//  CustomView.swift
//  TicTacToe
//
//  Created by david martinez on 1/29/19.
//  Copyright © 2019 dmlebron. All rights reserved.
//

import UIKit

final class CustomView: UIControl {
    
    struct ObjectData {
        let player: Player
        let isSelected: Bool
    }
    
    private(set) var objectData: ObjectData? {
        didSet {
            guard let objectData = objectData else { return }
            isSelected = objectData.isSelected
        }
    }
    var mark: Mark? {
        return objectData?.player.mark
    }
    
    var locationValue: Int {
        return tag
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    func setup(objectData: ObjectData) {
        self.objectData = objectData
        imageView.image = objectData.player.mark.image
    }
}

// MARK: - Private Methods
private extension CustomView {
    func setupImageView() {
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
