//
//  DetailsViewController.swift
//  swift CoreData kullanimi
//
//  Created by Mert AKBAŞ on 25.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        
        view.addGestureRecognizer(gestureRecognizer)// viewin kendisine atadık yani view e dokunulduğunu anlayacak.

   
    }
    

    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)// KLAVYEYİ KAPATIYOR.
    }
    

}
