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
    
    @IBOutlet weak var btnSave: UIButton!
    var selectedItem : Paintings?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( hideKeybord));
        view.addGestureRecognizer(gestureRecognizer);
        
        img.isUserInteractionEnabled = true
        let imgRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage));
        img.addGestureRecognizer(imgRecognizer)
        
        if selectedItem != nil {
            
            btnSave.isEnabled = false
            btnSave.isHidden = false
            btnSave.backgroundColor = UIColor.gray
            
            print("selectedItem")
            if let image = UIImage(data: (selectedItem?.image!)!) {
                img.image = image
            }
            
            editTextName.text = selectedItem?.name
            editTextArtist.text = selectedItem?.artist
            if let year = selectedItem?.year {
                editTextYear.text = String(year)
            }
            
        } else {
            btnSave.isEnabled = false
            btnSave.isHidden = false
            btnSave.backgroundColor = UIColor.gray
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        img.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        btnSave.isEnabled = true
        btnSave.isHidden = false
        btnSave.backgroundColor = UIColor.blue
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
        newPainting.setValue(UUID(), forKey: "id")
        if let year = Int(editTextYear.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = img.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success save")
            goToBeforePage()
        } catch{
            print("error save");
        }
    }
    
    func goToBeforePage() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
