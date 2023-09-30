//
//  UserListVC.swift
//  DemoCoreData
//
//  Created by mac on 12/25/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

protocol DataPass {
    func data(object: [String: String], index: Int, isEdit: Bool)
    }

class UserListVC: UIViewController {

    @IBOutlet weak var userListTV: UITableView!
    var student = [Student]()
    var delegate: DataPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        student = DataBaseHelper.shareInstance.getData()
    }
}
extension UserListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTV.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        cell.nameLbl.text = student[indexPath.row].name ?? "N/A"
        cell.mobileLbl.text = student[indexPath.row].mobile ?? "N/A"
        cell.cityLbl.text = student[indexPath.row].city ?? "N/A"
        cell.addressLbl.text = student[indexPath.row].address ?? "N/A"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            student = DataBaseHelper.shareInstance.deleteData(index: indexPath.row)
            self.userListTV.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ["name": student[indexPath.row].name, "mobile": student[indexPath.row].mobile, "city": student[indexPath.row].city, "address": student[indexPath.row].address]
        delegate.data(object: dict as! [String: String], index: indexPath.row, isEdit: true)
        self.navigationController?.popViewController(animated: true)
        
    }
}

class UserListCell: UITableViewCell{
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    var student: Student!{
        didSet{
            nameLbl.text = student.name
            mobileLbl.text = student.mobile
            cityLbl.text = student.city
            addressLbl.text = student.address
        }
    }
}
