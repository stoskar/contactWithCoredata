//
//  AddContactViewController.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firsttextField: UITextField!
    @IBOutlet weak var lasttextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    var contactObjectID : Contacts?
    var isForEdit = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // CoreDataHandler.cleanDelete()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        
        if isForEdit {
            imageView.image = UIImage(data:(contactObjectID?.contact_image)!)
            firsttextField.text = contactObjectID?.first_name
            lasttextField.text = contactObjectID?.last_name
            emailtextField.text = contactObjectID?.email
            mobileNumberTextField.text = contactObjectID?.mob_number
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        if isForEdit {
            
            if isValidName(firsttextField.text!) && (lasttextField.text?.isValidName())! && isValidPhoneNumber(mobileNumberTextField.text!) && isValidEmailAddress(emailtextField.text!) && (imageView.image != nil) {
                
                var imgData = NSData()
                
                if let img = imageView.image {
                    imgData = (UIImagePNGRepresentation(img) as NSData?)!
                }
                
                contactObjectID?.first_name = firsttextField.text!
                contactObjectID?.last_name = lasttextField.text!
                contactObjectID?.contact_image = imgData as Data
                contactObjectID?.email = emailtextField.text
                contactObjectID?.mob_number = mobileNumberTextField.text!
                
                //let saveData = CoreDataHandler.saveObject(firstname: firsttextField.text!, lastname: lasttextField.text!, email:emailtextField.text!, mobileNo:mobileNumberTextField.text!, contactimage: imgData)
                let updateData = CoreDataHandler.deleteObject(Contacts1: contactObjectID!)
                
                if updateData{
                    
                    let alert =  UIAlertController.init(title: "Success", message: "Update data successfully", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                        let storybord = UIStoryboard.init(name: "Main", bundle: nil)
                        let contactlistVC = storybord.instantiateViewController(withIdentifier: "ContactListViewController") as! ContactListViewController
                        self.navigationController?.pushViewController(contactlistVC, animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    print("data save")
                }
                else{
                    print("data not save")
                }
                
            }
            
        }
        else{
            if isValidName(firsttextField.text!) && (lasttextField.text?.isValidName())! && isValidPhoneNumber(mobileNumberTextField.text!) && isValidEmailAddress(emailtextField.text!) && (imageView.image != nil) && CoreDataHandler.checkIfContactIsExist(mobileNumber: mobileNumberTextField.text!) {
                
                var imgData = NSData()
                
                if let img = imageView.image {
                    imgData = (UIImagePNGRepresentation(img) as NSData?)!
                }
                
                let saveData = CoreDataHandler.saveObject(firstname: firsttextField.text!, lastname: lasttextField.text!, email:emailtextField.text!, mobileNo:mobileNumberTextField.text!, contactimage: imgData)
                
                if saveData{
                    
                    let alert =  UIAlertController.init(title: "Success", message: "data insert successfully", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                        let storybord = UIStoryboard.init(name: "Main", bundle: nil)
                        let contactlistVC = storybord.instantiateViewController(withIdentifier: "ContactListViewController") as! ContactListViewController
                        self.navigationController?.pushViewController(contactlistVC, animated: true)
                        
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    print("data save")
                }
                else{
                    print("data not save")
                }
                
            }
            
        }
        
        
    }
    
   
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } 
}

extension AddContactViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddContactViewController{
    
    // Name validation
    func isValidName(_ nameString: String) -> Bool {
        
        var returnValue = true
        let mobileRegEx =  "[A-Za-z]{2}"  // "^[A-Z0-9a-z.-_]{5}$"
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = nameString as NSString
            let results = regex.matches(in: nameString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
                showToast(message: " Enter name ")
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    // email validaton
    func isValidEmailAddress(_ emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
                
                let alert = UIAlertController(title: "Alert", message: "Pleas enter valide email id", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
            
            let alert = UIAlertController(title: "Alert", message: "Pleas enter valide email id", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return  returnValue
    }
    
    // mobile no. validation
    func isValidPhoneNumber(_ phoneNumberString: String) -> Bool {
        
        var returnValue = true
        //        let mobileRegEx = "^[789][0-9]{9,11}$"
        let mobileRegEx = "^[0-9]{10}$"
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = phoneNumberString as NSString
            let results = regex.matches(in: phoneNumberString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
                
                let alert = UIAlertController(title: "Alert", message: "Plase enter valid mobile no", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}

extension String {
    
    func isValidName() -> Bool {
        
        var returnValue = true
        let mobileRegEx =  "[A-Za-z]{2}"  // "^[A-Z0-9a-z.-_]{5}$"
        
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            //let nsString = self
            let results = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
}


