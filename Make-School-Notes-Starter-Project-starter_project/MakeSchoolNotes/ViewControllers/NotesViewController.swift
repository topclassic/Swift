//
//  NotesViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UITableViewController {
    var selectData: Data?
    @IBAction func unwindToSegue(segue: UIStoryboardSegue){
        if let id = segue.identifier{
            do{
                let realm = try Realm()
                switch id{
                    case "Save":
                        let source = segue.sourceViewController as! NewNoteViewController
                        try realm.write(){
                            realm.add(source.currentData!)
                    }
                    case "Delete":
                            try realm.write(){
                                realm.delete(self.selectData!)
                            }
                            let source = segue.sourceViewController as! ContactDisplayViewController
                            source.contact = nil
                    
                default: print("Identifier \(id)")
            }
            contacts = realm.objects(Data).sorted("name", ascending: true)
            }catch{
                print("handle error")
            }
        }
    }
    
    var contacts: Results<Data>! {
        didSet{
            tableView.reloadData()
        }
    }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self

    }
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        do{
            let realm = try Realm()
            contacts = realm.objects(Data).sorted("name", ascending: true)
        }catch{
            print("Error")
        }
        
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
extension NotesViewController{
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! NoteTableViewCell
       // cell.textLabel?.text = "Hello World"
       // cell.namelabel.text = "Top"
       // cell.tellabel.text = "083-919-9360"
        let row = indexPath.row
        let contact = contacts[row] as Data
        cell.contact = contact
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return contacts.count ?? 0
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectData = contacts[indexPath.row]
        self.performSegueWithIdentifier("ShowExistingData", sender: self)
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath){
            if editingStyle == .Delete{
                let contact = contacts[indexPath.row] as Object
                do{
                    let realm = try Realm()
                    try realm.write(){
                        realm.delete(contact)
                    }
                    contacts = realm.objects(Data).sorted("name", ascending: true)
                }catch{
                    print("Error")
                }
            }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowExistingData"){
            let noteViewController = segue.destinationViewController as! ContactDisplayViewController
            noteViewController.contact = selectData
        }
    }
}
