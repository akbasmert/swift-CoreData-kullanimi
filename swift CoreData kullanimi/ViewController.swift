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
    var secilenIsim = ""
    var secilenUUID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonutiklandi))
        
        verileriAl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:#selector(verileriAl), name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
    }
    
    
    @objc func verileriAl(){
        
        isimDizisi.removeAll(keepingCapacity: false)//tableview gösterilen ürünlerin tekrarını önlemek için yaptık.
        idDizisi.removeAll(keepingCapacity: false)
        
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
       secilenIsim = ""
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.secilenUrunIsmi = secilenIsim
            destinationVC.secilenUrunUUID = secilenUUID
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        secilenIsim = isimDizisi[indexPath.row]
        secilenUUID = idDizisi[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}

