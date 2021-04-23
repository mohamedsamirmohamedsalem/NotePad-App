//
//  RealmDataManuipilation.swift
//  NotePad-App
//
//  Created by mohamed samir on 22/04/2021.
//

import Foundation
import  RealmSwift

extension TaskListViewController {
    
    //MARK: - Delete Data From Swipe
    func realmDelete(item : NotePadTask) {
        try! notePadRealmObj.write{
            notePadRealmObj.delete(item)
            self.readTasksAndUpdateUI()
        }
    }
    //getting notePad list from realm database
    func readNotePadList(){
        taskLists = notePadRealmObj.objects(NotePadTask.self)
    }
    //sort notePad list after retriving it from database
    func sortNotePadList() {
        taskLists = taskLists!.sorted(byKeyPath: "taskCreatedAt", ascending: false)
    }
    
}


extension DetailsViewController {
    //MARK:- save data in realm
    func realmSave(newTask : NotePadTask) {
        DispatchQueue.main.async {
            do {
                try notePadRealmObj.write({
                    notePadRealmObj.add(newTask)
                })
                self.navigationController?.popViewController(animated: true)
            }catch  let error as NSError {
                print("Error saving location name: \(error)")
            }
        }
    }
    //MARK: - Delete Data From Swipe
    func realmDelete(item : NotePadTask) {
        try! notePadRealmObj.write{
            notePadRealmObj.delete(item)
        }
    }
}
