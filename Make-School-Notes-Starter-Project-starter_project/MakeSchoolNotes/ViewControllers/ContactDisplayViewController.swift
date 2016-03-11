//
//  ContactDisplayViewController.swift
//  MakeSchoolNotes
//
//  Created by WebEngineering on 2/19/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//

import UIKit
import RealmSwift

class ContactDisplayViewController: UIViewController {
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var teltext: UITextField!
    var contact: Data?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayData(contact: Data?){
        if let contact = contact, nametext = nametext, teltext = teltext{
            nametext.text = contact.name
            teltext.text = contact.tel
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayData(contact)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        saveData()
    }
    func saveData(){
        if let contact = contact{
            do{
                let realm = try Realm()
                try realm.write{
                    if(contact.name != self.nametext.text ||
                        contact.tel != self.teltext.text)
                    {
                        contact.name = self.nametext.text!
                        contact.tel = self.teltext.text!
                    }
                }
            }catch{
                print("Error")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
