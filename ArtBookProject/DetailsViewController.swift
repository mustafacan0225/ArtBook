//
//  DetailsViewController.swift
//  ArtBookProject
//
//  Created by mustafacan on 5.05.2020.
//  Copyright © 2020 mustafacan. All rights reserved.
//

import UIKit

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
    }
    
}
