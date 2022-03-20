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
    private var planetView : PlanetView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       if let planetView = Bundle.main.loadNibNamed("PlanetView",
                                                   owner: view,
                                                    options: nil)?.first as? PlanetView {
           planetView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(planetView)
           planetView.setConstraint(rootView: view)
           planetView.backgroundColor  = .white
           self.planetView = planetView
       }
       
       
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
                }
                self?.refreshUI()
                self?.showLoader(false)
            }
        }
    }
    
    func refreshUI(){
        planetView?.refreshView(vm: planetViewModel)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}


