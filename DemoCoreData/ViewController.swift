//
//  ViewController.swift
//  DemoCoreData
//
//  Created by mac on 10/17/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataPass {
    
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    var i = Int()
    var isUpdate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func saveBtnAction(_ sender: UIButton) {
        let dict = ["name":nameTF.text, "mobile":mobileTF.text, "city":cityTF.text, "address":addressTF.text]
        if isUpdate{
            DataBaseHelper.shareInstance.editData(object: dict as! [String : String], i: i)
        }else{
            DataBaseHelper.shareInstance.saveData(object: dict as! [String : String])
            print(dict)
        }
        
    }
    @IBAction func showBtnAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        nameTF.text = object["name"]
        mobileTF.text = object["mobile"]
        cityTF.text = object["city"]
        addressTF.text = object["address"]
        i = index
        isUpdate = isEdit
    }
}

