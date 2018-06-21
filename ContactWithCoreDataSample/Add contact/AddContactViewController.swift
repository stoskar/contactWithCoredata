//
//  AddContactViewController.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firsttextField: UITextField!
    @IBOutlet weak var lasttextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
      //  let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        // Your action
    }
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        let firstName = firsttextField.text
        let lastName = lasttextField.text
        let email = emailtextField.text
        let mobileNo = mobileNumberTextField.text
        var imgData = NSData()
        
        if let img = imageView.image {
            imgData = (UIImagePNGRepresentation(img) as NSData?)!
        }
        
        let saveData = CoreDataHandler.saveObject(firstname: firstName!, lastname: lastName!, email: email!, mobileNo: mobileNo!, contactimage: imgData)
        
        if saveData{
            print("data save")
            
           // self.performSegue(withIdentifier: "detailSegue", sender: self)
            
        }
        else{
            
            print("data not save")
        }
    }
    
}

