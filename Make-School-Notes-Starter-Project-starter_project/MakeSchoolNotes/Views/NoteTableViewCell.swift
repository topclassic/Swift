//
//  NoteTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    var contact: Data?{
        didSet {
            if let note = contact, namelabel = namelabel, tellabel = tellabel{
                namelabel.text = note.name
                tellabel.text = note.tel
            }
        }
    }
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var tellabel: UILabel!
}