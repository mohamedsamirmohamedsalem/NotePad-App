//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by mohamed samir on 21/04/2021.
//

import Foundation
import UIKit
import RealmSwift
import CoreLocation


class TaskListViewController: UIViewController{
    
    //MARK:- IBoutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //MARK:- Properities
    var taskLists : Results<NotePadTask>!
    var currentCreateAction:UIAlertAction!
    let locationManager = CLLocationManager()
    var locationsList = [CLLocation()]
    var closestLocation :CLLocation = CLLocation()
    let detailsVCIdentifiers = "DetailsViewController"
    
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //MARK:_ View Lify Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilizeTableView()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readTasksAndUpdateUI()
    }
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //MARK:- IBActions
    @IBAction func addIconBT(_ sender: UIButton) {
        navigateToDetailsVC()
    }
    
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //Mark:- UI methods
    func initilizeTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(cell: NotePadTableViewCell.self)
    }
    
    func  setupUI(){
        //Setting Title and Buttons of Nav Bar
        self.navigationController?.navigationBar.topItem?.title = "Notes";
        
        let newButton = UIButton(type: .custom)
        newButton.setBackgroundImage(UIImage(named: "new"), for: .normal)
        newButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        newButton.addTarget(self, action: #selector(self.addNew), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: newButton)
        self.navigationItem.rightBarButtonItem = item1
    }
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //Mark:- bussiness methods
    func readTasksAndUpdateUI(){
        readNotePadList()
        getNearestLocationNotePad()
        sortNotePadList()
        //Reload the table to make sort changes
        self.tableView.reloadData()
    }
    
    @objc func addNew() {
        navigateToDetailsVC()
    }
    
    func navigateToDetailsVC(){
        let DetailsVC = (self.storyboard?.instantiateViewController(identifier: detailsVCIdentifiers))! as DetailsViewController
        self.navigationController?.pushViewController(DetailsVC, animated: true)
    }
    
    func navigateToUpdateTask(_ updatedTask:NotePadTask!){
        let DetailsVC = (self.storyboard?.instantiateViewController(identifier: detailsVCIdentifiers))! as DetailsViewController
        DetailsVC.task = updatedTask
        self.navigationController?.pushViewController(DetailsVC, animated: true)
        
    }
    
    func getNearestLocationNotePad(){
        for item  in taskLists {
            locationsList.append(item.location)
        }
        
        //get closestLocation to put it as first element in table view 
        guard let currentLocation: CLLocation = locationManager.location else {return}
        closestLocation =   locationInLocations(locations: locationsList, closestToLocation: currentLocation ) ?? CLLocation()
    }
    
    
}

