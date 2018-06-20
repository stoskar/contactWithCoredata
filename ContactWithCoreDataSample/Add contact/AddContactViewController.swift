//
//  AddContactViewController.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController,UIImagePickerControllerDelegate {
    
    var contact:[Contacts]? = nil
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firsttextField: UITextField!
    @IBOutlet weak var lasttextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Save, fetch, single delete and clean delete operation
        
        contact = CoreDataHandler.fetchObject()
        print("Before Single Delete")
        for i in contact! {
            print(i.first_name!)
        }
        
        
      //  CoreDataHandler.saveObject(firstname: "asf", lastname: "fvew", email: "wfwf", mobileNo: "wefwq", contactimage:"as")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
    }
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        let firstName = firsttextField.text
        let lastName = lasttextField.text
        let email = emailtextField.text
        let mobileNo = mobileNumberTextField.text
        var imgData = NSData()
        
        if let img = UIImage(named: "Profile.png") {
            imgData = (UIImagePNGRepresentation(img) as NSData?)!
        }
        
        let saveData = CoreDataHandler.saveObject(firstname: firstName!, lastname: lastName!, email: email!, mobileNo: mobileNo!, contactimage: imgData)
        
        if saveData{
            print("data save")
            
            
        }
        else{
            
            print("data not save")
        }
    }
    
}

