//
//  HeaderDetailVC.swift
//  TestDemo
//
//  Created by JadavMac on 20/07/17.
//  Copyright © 2017 MV Jadav. All rights reserved.
//

import UIKit

@objc protocol HeaderDelegate:class {
    @objc optional func didFinishAddTask(title : String,index : Int,isHeader : Bool)
}

class HeaderDetailVC: UIViewController {

    var delegate:HeaderDelegate?
    
    @IBOutlet var IBbarbtnBack                      : UIBarButtonItem!
    @IBOutlet var IBbarbtnDone                      : UIBarButtonItem!
    @IBOutlet weak var IBtxtTitle                   : UITextField!
    
    var index : Int             = 0
    var isHeader : Bool         = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - Other Methods
extension HeaderDetailVC {
    
    func setView() {
        
        if isHeader {
            self.title = "Add Header"
        }else {
            self.title = "Add Row"
        }
        
        self.navigationItem.leftBarButtonItem       = IBbarbtnBack
        self.navigationItem.rightBarButtonItems     = [IBbarbtnDone]
    }
    
}

//MARK: - IBAction methods
extension HeaderDetailVC {
    
    @IBAction func btnClickAddHeaderBack(_ sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClickAddHeaderDone(_ sender: AnyObject) {
        
        if (IBtxtTitle.text?.isEmpty)! {}else {
            self.delegate?.didFinishAddTask!(title: self.IBtxtTitle.text!, index: self.index, isHeader: self.isHeader)
            _ =  self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
