//
//  ViewController.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager().getPlanetDetail { planet, error in
          //  print("Error\(error)")
        }
    }


}

