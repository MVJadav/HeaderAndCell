//
//  HeaderRowVC.swift
//  TestDemo
//
//  Created by JadavMac on 20/07/17.
//  Copyright © 2017 MV Jadav. All rights reserved.
//

import UIKit

class HeaderRowVC: UIViewController {

    @IBOutlet weak var IBtblHeaderCell: UITableView!
    @IBOutlet var IBbarbtnAdd                   : UIBarButtonItem!
    
    var mySections: [SectionData] = {
        let section1 = SectionData(title: "Mothns", data: "January", "February", "March", "Aplir")
        let section2 = SectionData(title: "Days", data: "Sunday", "Monday")
        
        return [section1, section2]
    }()
    
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

//MARK: - IBAction methods
extension HeaderRowVC {
    
    @IBAction func btnClickAddHeader(_ sender: AnyObject) {
        
        let objHeaderDetailVC                   = HeaderDetailVC(nibName: "HeaderDetailVC", bundle: nil)
        objHeaderDetailVC.delegate              = self
        objHeaderDetailVC.isHeader              = true
        self.navigationController?.pushViewController(objHeaderDetailVC, animated: true)
    }

}

//MARK: - Other Methods
extension HeaderRowVC {
    
    func setView() {
        self.title = "My List"
        
        //self.navigationItem.leftBarButtonItem = IBbarbtnBack
        self.navigationItem.rightBarButtonItems = [IBbarbtnAdd]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.IBtblHeaderCell.tableFooterView = UIView()
        self.IBtblHeaderCell.reloadData()
    }
    
    func setData() {
        var mySectionsTemp: [SectionData] = []
        
        for i in 0..<mySections.count {
            if mySections[i].data.count > 0 {
                mySectionsTemp.append(mySections[i])
            }
        }
        self.mySections = mySectionsTemp
        self.IBtblHeaderCell.reloadData()
    }
    
}

//MARK: - UITableView Delegate, DataSource Method
extension HeaderRowVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mySections[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.textLabel?.text            =  mySections[indexPath.section][indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame: CGRect = tableView.frame
        
        // Text Title
        let lbl : UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: 150, height: 50))
        lbl.text = mySections[section].title
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
                self.mySections[indexPath.section].data.remove(at: indexPath.row)
                self.setData()
            }
        }
    }

}



//MARK: - Detail Delegate Method
extension HeaderRowVC : HeaderDelegate {
    
    func didFinishAddTask(title: String, index: Int, isHeader: Bool) {
        
        if isHeader {
            let newSection = SectionData(title: title, data: [])
            self.mySections.append(newSection)
        }else {
            self.mySections[index].data.append(title)
        }
        self.IBtblHeaderCell.reloadData()
    }
}



//MARK: - Set Data Structure
struct SectionData {
    let title: String
    var data : [String]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> String {
        return data[index]
    }
}

extension SectionData {
    //  Putting a new init method here means we can
    //  keep the original, memberwise initaliser.
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}
    





