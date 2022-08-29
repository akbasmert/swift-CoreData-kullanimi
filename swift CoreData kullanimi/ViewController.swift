//
//  ViewController.swift
//  swift CoreData kullanimi
//
//  Created by Mert AKBAŞ on 25.08.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{ // Tableview kullanabilmek için ekledik

    @IBOutlet weak var tableView: UITableView!
    
    var isimDizisi = [String]()
    var idDizisi = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonutiklandi))
        
        verileriAl()
    }
    
    
    func verileriAl(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
        fetchRequest.returnsObjectsAsFaults = false // çok büyük veriler ile çalışırken true yapılabilir ama bizim için gerek yok.
        
        do{
            let sonuclar =   try context.fetch(fetchRequest)
            for sonuc in sonuclar as! [NSManagedObject]{
                
                if let isim = sonuc.value(forKey: "isim") as? String{
                    isimDizisi.append(isim)
                }
                if let id = sonuc.value(forKey: "id") as? UUID{
                    idDizisi.append(id)
                }
            }
            tableView.reloadData() // Tableview a ben dataları değiştirdim hadi güncelle dedik:)
        }catch{
            print("hata var ")
        }
    }
    
   @objc func eklemeButonutiklandi(){
        
       performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isimDizisi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = isimDizisi[indexPath.row]
        return cell
    }


}

