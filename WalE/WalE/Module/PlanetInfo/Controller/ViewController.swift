//
//  ViewController.swift
//  WalE
//
//  Created by Yogesh2 Gupta on 19/03/22.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var planetViewModel = PlanetViewModel()
    private var alert : UIAlertController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    func getData(){
        showLoader()
        planetViewModel.getPlanetData { error in
            DispatchQueue.main.async {[weak self] in
                if let err = error {
                    self?.showAlertWithMessage(msg: err.msg)
                }else{
                    
                }
                self?.showLoader(false)
            }
        }
    }
    
    func showLoader(_ isEnable : Bool = true) {
        if isEnable {
            alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating()
            alert!.view.addSubview(loadingIndicator)
            present(alert!, animated: true, completion: nil)
        }else{
            if alert != nil {
                alert = nil
                dismiss(animated: false, completion: nil)
            }
        }
      
    }

    func showAlertWithMessage(msg : String?){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


