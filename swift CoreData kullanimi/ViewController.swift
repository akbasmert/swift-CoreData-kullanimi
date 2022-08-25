//
//  ViewController.swift
//  swift CoreData kullanimi
//
//  Created by Mert AKBAŞ on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonutiklandi))
    }
    
   @objc func eklemeButonutiklandi(){
        
       performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }


}

