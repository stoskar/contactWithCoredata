//
//  ContactListViewController.swift
//  ContactListWithCoreData
//
//  Created by IOS Developer6 on 19/06/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UIViewController {

    @IBOutlet weak var contactTblView: UITableView!
    var contact:[Contacts]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         contact = CoreDataHandler.fetchObject()
    }
  
}

extension ContactListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contactDetiles = contact![indexPath.row]
        let firstname = contactDetiles.first_name
        let number = contactDetiles.mob_number
        let image = contactDetiles.contact_image

        cell.detailTextLabel?.text = String(describing: number!)
        cell.textLabel?.text = String(describing: firstname!)
        cell.imageView?.image = UIImage(data: image!)
        
        return cell
    }
  
}

extension ContactListViewController:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // let indexPath = tableView.indexPathForSelectedRow
        
        
        
        let storybord = UIStoryboard.init(name: "Main", bundle: nil)
        let contactDetailVC = storybord.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        contactDetailVC.contactObjectID = contact![indexPath.row]
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
        
    }
}
