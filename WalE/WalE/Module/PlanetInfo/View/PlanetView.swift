//
//  PlanetView.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 20/03/22.
//

import UIKit

class PlanetView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    @IBOutlet weak var planetImage: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   
    
    func refreshView(vm : PlanetViewModel){
        vm.downloadImage { [weak self] data, error in
            self?.updateImage(data: data)
        }
        titleLabel.text = vm.getTitle()
        subtitleView.text = vm.getExplanation()
    }
    
    private func updateImage(data : Data?) {
        if let dta = data, dta.isEmpty == false {
            planetImage.image = UIImage(data: dta)
        } else{
            planetImage.image = nil
        }
    }
    
    
    
    func setConstraint(rootView : UIView,
                       edge     : UIEdgeInsets =  .zero) {
        leadingAnchor .constraint(equalTo  : rootView.leadingAnchor ,
                                  constant : edge.left).isActive = true
        
        trailingAnchor.constraint(equalTo  : rootView.trailingAnchor ,
                                  constant : edge.right).isActive = true
        
        topAnchor.constraint(equalTo  : rootView.safeAreaLayoutGuide.topAnchor ,
                              constant : edge.top).isActive = true
        bottomAnchor.constraint(equalTo  : rootView.safeAreaLayoutGuide.bottomAnchor ,
                              constant : edge.bottom).isActive = true
    }
}
