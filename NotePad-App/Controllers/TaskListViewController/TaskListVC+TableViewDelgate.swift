//
//  TaskListVC+TableViewDelgate.swift
//  NotePad-App
//
//  Created by mohamed samir on 22/04/2021.
//

import UIKit
extension TaskListViewController : UITableViewDelegate {
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToUpdateTask(taskLists[indexPath.row])
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
}