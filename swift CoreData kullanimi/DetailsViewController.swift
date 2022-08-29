//
//  DetailsViewController.swift
//  swift CoreData kullanimi
//
//  Created by Mert AKBAŞ on 25.08.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    
    var secilenUrunIsmi = ""
    var secilenUrunUUID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if secilenUrunIsmi != "" {
            
            kaydetButton.isHidden = true // kaydet butonu gizledik.
            
            if let  uuidString = secilenUrunUUID?.uuidString { // seçilen urunuuıd sini optionalden string e çevirdik.
                print(uuidString)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString) // id si uuidString e eşit olanları getir demek
                fetchRequest.returnsObjectsAsFaults = false
                
                do{
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0 {
                        for sonuc in sonuclar as! [NSManagedObject]{
                            
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                isimTextField.text = isim
                            }
                            if let fiyat = sonuc.value(forKey: "fiyat") as? Int{
                                fiyatTextField.text = String(fiyat)
                            }
                            if let beden = sonuc.value(forKey: "beden") as? String{
                                bedenTextField.text = beden
                            }
                            if let gorselData = sonuc.value(forKey: "gorsel") as? Data {
                                let image = UIImage(data: gorselData)
                                imageView.image = image
                            }
                            
                        }
                    }
                }catch{
                    print("hata var ")
                }
            }
            
        }else{
            
            kaydetButton.isHidden = false // kaydet butonu gizlemedik.
            kaydetButton.isEnabled = false // gorsel secmeden tıklanmsın diye silik hale getirdik
            isimTextField.text = ""
            fiyatTextField.text = ""
            bedenTextField.text = ""
            
        }
        
        // KLAVYE ACILDIĞINDA TEXTFİELD DIŞINA DOKUNULDUĞUNDA KLAVYEYİ KAPATIYOR.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        
        view.addGestureRecognizer(gestureRecognizer)// viewin kendisine atadık yani view e dokunulduğunu anlayacak.
        
        imageView.isUserInteractionEnabled = true // image view i kullanıcının etkileşime girecği hale getirdik
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))//gorsele tıklanıldığında çalışacak fonksiyonu ekledik.
        imageView.addGestureRecognizer(imageGestureRecognizer)

   
    }
    
    @objc func gorselSec(){
        
        let picker = UIImagePickerController() // galeri ve kameradan foto ve video almak için ekledik. class a da iki tane ekleme yaptık yukarıda.
        picker.delegate = self
        picker.sourceType = .photoLibrary // görütüyü galeriden sectik camerada olabilir di
        picker.allowsEditing = true // secilen fotoya edit izni verdik.
        present(picker, animated: true, completion: nil) // görüntüyü kullanıcıya gösterdik animasyonlu bir şekilde.
        
        
    }
    
    
    // didfinished yazarak bu fonksiyonu getirdik kullanıcı foto seçmini yaptıktan sonra olaacakları işliyoruz.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage // kasting işlemi yaptık kullnıcı foto seçiminden vazgeçerse uygulama çökmeyecek. .original image diyerek orijinal fotoyu aldık bunu değiştirebiliriz
        kaydetButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var kaydetButton: UIButton!
    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext //AppDelegate dosyasındaki contxt e ulaştık.
        
        let alisveris = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context) //Coredatada oluşturduğumuz Alisveris tablosunu bağladık ve yukarıdaki  context i kullandık.
        
        alisveris.setValue(isimTextField.text!, forKey: "isim")
        alisveris.setValue(bedenTextField.text!, forKey: "beden")
        
        if let fiyat = Int(fiyatTextField.text!){ // fiyat int ten farklı girilirse uygulama  çökmesin diye iflet kullandik
            alisveris.setValue(fiyat, forKey: "fiyat")
        }
        
        alisveris.setValue(UUID(), forKey: "id")//swift id yi belirleyecek
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5) // fotoyu veritabanına 0.5 oranında sıkıştırarak kaydettik
        alisveris.setValue(data, forKey: "gorsel")
        
        do{
            try context.save()
            print("kaydedildi")
        }catch{
            print("hata var ")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)// veri girildiğinde mesaj göndereceğiz.
        self.navigationController?.popViewController(animated: true) // verileri alınca sayfaya geri gidiyor.
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)// KLAVYEYİ KAPATIYOR.
    }
    

}
