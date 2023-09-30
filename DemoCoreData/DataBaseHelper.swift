//
//  DataBaseHelper.swift
//  DemoCoreData
//
//  Created by mac on 12/24/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataBaseHelper{
    
    static var shareInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData (object: [String: String]){
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        student.name = object["name"]
        student.mobile = object["mobile"]
        student.address = object["address"]
        student.city = object["city"]
        
        do{
            try context.save()
        }
        catch{
            print("data does not save")
        }
    }
    
    func getData() -> [Student]{
        var student = [Student]()
        let featchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do{
            student = try context.fetch(featchRequest) as! [Student]
        }catch{
            print("can not get data")
        }
        return student
    }
    
    func deleteData(index: Int) -> [Student] {
        var student = getData()
        context.delete(student[index])
        student.remove(at: index)
        do {
            try context.save()
        } catch {
            print("cannot delete data")
        }
        return student
    }
    
    func editData(object: [String: String], i: Int){
        var student = getData()
        student[i].name = object["name"]
        student[i].mobile = object["mobile"]
        student[i].city = object["city"]
        student[i].address = object["address"]
        do {
            try context.save()
        } catch  {
            print("Data is not Set")
        }
    }
}
