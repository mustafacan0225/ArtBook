//
//  DetailsViewController.swift
//  ArtBookProject
//
//  Created by mustafacan on 5.05.2020.
//  Copyright © 2020 mustafacan. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var editTextName: UITextField!
    @IBOutlet weak var editTextArtist: UITextField!
    @IBOutlet weak var editTextYear: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( hideKeybord));
        view.addGestureRecognizer(gestureRecognizer);
        
        img.isUserInteractionEnabled = true
        let imgRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage));
        img.addGestureRecognizer(imgRecognizer)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        img.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func hideKeybord() {
        view.endEditing(true);
    }
    
    @IBAction func clickHandleSaveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        newPainting.setValue(editTextName.text!, forKey: "name")
        newPainting.setValue(editTextName.text!, forKey: "artist")
        
        if let year = Int(editTextYear.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = img.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success save")
        } catch{
            print("error save");
        }
    }
    
}
