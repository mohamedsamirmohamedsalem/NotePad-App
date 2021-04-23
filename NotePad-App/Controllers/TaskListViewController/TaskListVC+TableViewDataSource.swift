//
//  TaskListVC+TableViewDataSource.swift
//  NotePad-App
//
//  Created by mohamed samir on 22/04/2021.
//

import UIKit
import Foundation
import CoreLocation

extension TaskListViewController : UITableViewDataSource {
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(taskLists.count == 0){
            self.emptyView.isHidden = false
            self.tableView.isHidden = true
            return 0
        }else{
            self.emptyView.isHidden = true
            self.tableView.isHidden = false
            return taskLists.count
        }
        
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque() as NotePadTableViewCell
        
        let list = taskLists[indexPath.row]
        
        cell.titleLB.text = list.taskName
        cell.descriptionLB.text = list.taskDescription
        if(list.location == closestLocation ||  indexPath.row == 0){
            cell.nearestLB.text = "Nearest"
        }else{
            cell.nearestLB.text = ""
        }
        cell.noteImage.image = list.noteImage.convertFromNSDataToImage(list.noteImage)
        if(list.locationSelected){
            cell.locationImage.image = UIImage(named: "locationImage")
        }else{
            cell.locationImage.image = UIImage()
            
        }
        return cell
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let item = taskLists[indexPath.row]
            self.realmDelete(item: item)
            self.readTasksAndUpdateUI()
            
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
}
