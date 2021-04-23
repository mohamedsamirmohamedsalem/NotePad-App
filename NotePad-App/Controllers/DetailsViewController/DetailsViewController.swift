//
//  DetailsViewController.swift
//  NotePad-App
//
//  Created by mohamed samir on 22/04/2021.
//

import UIKit
import CoreLocation

class DetailsViewController: UIViewController {
    
    //MARK:- IBoutlets
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var locationLB: UILabel!
    @IBOutlet weak var pickedImage: UIImageView!
    
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    
    //MARK:- Properities
    var imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    var location : CLLocation?
    var isLocationSelected = false
    var task : NotePadTask?
    var taskCity:String = ""
    var taskCountry:String = ""
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    
    //MARK:_ View Lify Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //MARK:- UI Methods
    func  setupUI(){
        
        let newButton = UIButton(type: .custom)
        newButton.setTitle("Add Note", for: .normal)
        newButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        newButton.setTitleColor(#colorLiteral(red: 0.1856514215, green: 0.425026685, blue: 0.9963873029, alpha: 1), for: .normal)
        newButton.addTarget(self, action: #selector(self.addNote), for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: newButton)
        self.navigationItem.rightBarButtonItem = item
        
        if let task = self.task {
            titleView.insertText(task.taskName)
            descriptionView.insertText(task.taskDescription)
            pickedImage.image = task.noteImage.convertFromNSDataToImage(task.noteImage)
        }
    }
    
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    
    //MARK:- IBAction
    @IBAction func addLocationBT(_ sender: UIButton) {
        AuthorizeLocation()
    }
    @IBAction func addImageBt(_ sender: UIButton) {
        self.pickImageFromDevice()
    }
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
    //MARK:- Bussiness logic
    func addTaskToDataBase(){
        let nsDataImage = convertImageToNSData((self.pickedImage.image ?? UIImage(named: "")) ?? UIImage())
        
        
        let newTask = NotePadTask()
        
        newTask.taskName = self.titleView.text!
        newTask.taskDescription = self.descriptionView.text!
        newTask.noteImage = nsDataImage
        if(isLocationSelected){
            newTask.locationSelected = true
            newTask.location = self.location ?? CLLocation()
        }else{
            newTask.locationSelected = false
            newTask.location = CLLocation(latitude: 0.0, longitude: 0.0)
        }
        
        //delete task from realm offline database
        self.realmSave(newTask: newTask)
        if let task = task{
            self.realmDelete(item: task)
        }
        
    }
    
    //convert image to nsdata object for saving it in offline database
    func convertImageToNSData(_ image : UIImage) -> NSData{
        return image.pngData() as NSData? ?? NSData()
    }
    
    
    @objc func addNote(){
        addTaskToDataBase()
    }
    
    //display alert view when getting address successfully 
    func displaySuccessLocationAlert(){
        let alertController = UIAlertController(title: "get location successfully , please addNote to save it", message: "\(taskCountry)"+","+"\(taskCity)", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayCancelLAlert(){
        self.isLocationSelected = false
        let alertController = UIAlertController(title: "TITLE", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// ///// /////
}


