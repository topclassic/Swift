//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by WebEngineering on 2/19/2559 BE.
//  Copyright © 2559 Chris Orcutt. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var currentData: Data?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        currentData = Data()
        currentData!.name = "New Name"
        currentData!.tel = "New tel"
    }


}
