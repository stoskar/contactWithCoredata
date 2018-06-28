//
//  ContactDetailViewController.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet weak var mobNumberLbl: UILabel!
    
    var contactObjectID = Contacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        firstNameLbl.text = contactObjectID.first_name
        lastNameLbl.text = contactObjectID.last_name
        mailLbl.text = contactObjectID.email
        mobNumberLbl.text = contactObjectID.mob_number
        profilePic.image = UIImage(data: contactObjectID.contact_image!)
        // Do any additional setup after loading the view.
    }

   
    @IBAction func editBtnAction(_ sender: UIButton) {
        
    }
    
}
