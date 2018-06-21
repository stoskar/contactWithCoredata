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
    
    @IBOutlet weak var FirstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var mailLbl: UILabel!
    @IBOutlet var mobNumberLbl: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

   
    @IBAction func editBtnAction(_ sender: UIButton) {
        
    }
    
}
