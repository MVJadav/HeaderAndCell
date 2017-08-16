//
//  HeaderRowByModelVC.swift
//  TestDemo
//
//  Created by JadavMac on 20/07/17.
//  Copyright © 2017 MV Jadav. All rights reserved.
//

import UIKit

class HeaderRowByModelVC: UIViewController {

    @IBOutlet weak var IBtblHeaderCell          : UITableView!
    @IBOutlet var IBbarbtnAdd                   : UIBarButtonItem!
    
    var objHeader : [HeaderSection<Row>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.objHeader = []
        let objTemo = HeaderSection<Row>()
        objTemo?.Title = "Month"
        var objRow : [Row] = []
        
        let rowModel = Row()
        rowModel.title = "Jan"
        objRow.append(rowModel)
        
        let rowModel1 = Row()
        rowModel1.title = "Feb"
        objRow.append(rowModel1)
        
        objTemo?.Row = objRow
        self.objHeader.append(objTemo!)
        
        
        self.setView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - IBAction methods
extension HeaderRowByModelVC {
    
    @IBAction func btnClickAddHeader(_ sender: AnyObject) {
        
        let objHeaderDetailVC                   = HeaderDetailVC(nibName: "HeaderDetailVC", bundle: nil)
        objHeaderDetailVC.delegate              = self
        objHeaderDetailVC.isHeader              = true
        self.navigationController?.pushViewController(objHeaderDetailVC, animated: true)
    }
}


//MARK: - Other Methods
extension HeaderRowByModelVC {
    
    func setView() {
        self.title = "My List"
        
        //self.navigationItem.leftBarButtonItem = IBbarbtnBack
        self.navigationItem.rightBarButtonItems = [IBbarbtnAdd]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.IBtblHeaderCell.tableFooterView = UIView()
        self.IBtblHeaderCell.reloadData()
    }
    
    func setData(section : Int) {
        if (self.objHeader[section].Row?.count)! > 0 { }else {
            self.objHeader.remove(at: section)
        }
        self.IBtblHeaderCell.reloadData()
    }
    
}


//MARK: - UITableView Delegate, DataSource Method
extension HeaderRowByModelVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.objHeader[section].Row?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.textLabel?.text            =  objHeader[indexPath.section].Row?[indexPath.row].title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.objHeader.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.objHeader[section].Title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame: CGRect = tableView.frame
        
        // Text Title
        let lbl : UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: 150, height: 50))
        lbl.text = self.objHeader[section].Title //mySections[section].title
        lbl.textColor = UIColor.white
        
        //Add Button
        let DoneBut: UIButton = UIButton(frame: CGRect(x: frame.size.width - 50, y: 0, width: 50, height: 50)) //
        DoneBut.setTitle("+", for: .normal)
        DoneBut.backgroundColor = UIColor.lightGray
        DoneBut.tag = section
        DoneBut.addTarget(self, action:#selector(buttonTapped(sender:)), for: .touchUpInside)
        DoneBut.backgroundColor = UIColor.lightGray
        
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        headerView.backgroundColor = UIColor.lightGray
        headerView.addSubview(lbl)
        headerView.addSubview(DoneBut)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func buttonTapped(sender: UIButton) {
        //Button Tapped and open your another ViewController
        
        let objHeaderDetailVC                   = HeaderDetailVC(nibName: "HeaderDetailVC", bundle: nil)
        objHeaderDetailVC.delegate              = self
        objHeaderDetailVC.index                 = sender.tag
        self.navigationController?.pushViewController(objHeaderDetailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if (editingStyle == UITableViewCellEditingStyle.delete) {
                self.objHeader[indexPath.section].Row?.remove(at: indexPath.row)
                self.setData(section : indexPath.section)
                
            }
        }
    }
    
}



//MARK: - Detail Delegate Method
extension HeaderRowByModelVC : HeaderDelegate {
    
    func didFinishAddTask(title: String, index: Int, isHeader: Bool) {

        if isHeader {
            //var objRow : [Row] = []
            let objTemo = HeaderSection<Row>()
            objTemo?.Title = title
            objTemo?.Row = []
            self.objHeader.append(objTemo!)
        }else {
            let rowModel = Row()
            rowModel.title = title
            self.objHeader[index].Row?.append(rowModel)
        }
        self.IBtblHeaderCell.reloadData()
    }
}






