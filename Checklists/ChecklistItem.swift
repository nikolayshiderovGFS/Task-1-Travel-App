//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Nikolay Shiderov on 21.10.21.
//

import Foundation

class ChecklistItem {
    var text = ""
    var description = ""
    var checked = false
    func toggleChecked() {
        checked = !checked
    }
}
