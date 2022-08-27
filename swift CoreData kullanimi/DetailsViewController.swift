//
//  DetailsViewController.swift
//  swift CoreData kullanimi
//
//  Created by Mert AKBAŞ on 25.08.2022.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var isimTextField: UITextField!
    @IBOutlet weak var fiyatTextField: UITextField!
    @IBOutlet weak var bedenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func kaydetButtonTiklandi(_ sender: Any) {
    }
    
    @objc func klavyeyiKapat(){
        view.endEditing(true)// KLAVYEYİ KAPATIYOR.
    }
    

}
