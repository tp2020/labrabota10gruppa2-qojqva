//
//  MenuController.swift
//  bank_app
//
//  Created by Roman on 4/15/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit
import Firebase

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellid = "cell"
    let tableView = UITableView(frame: .zero, style: .grouped)
    var label_name = String()
    var dict:[String: AnyObject] = [:]
    var structArray:[Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfo()
        self.navigationItem.title = "Ваши счета"
        self.navigationController?.navigationBar.backgroundColor = .white
        tableView.frame = CGRect(x: 0, y: 44, width: self.view.frame.maxX, height: self.view.frame.maxY - 44)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dequeueReusableCell(withIdentifier: cellid)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "4.png")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(show_course))
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "icons8-america-30.png")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(show_nearest_back)), UIBarButtonItem(image: UIImage(named: "icons8-location-30.png")!.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(show_banks_map))]
        self.view.addSubview(tableView)
    }
    
    @objc func show_course() {
        let vc = CourseController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func show_nearest_back() {
            let vc = MapController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func show_banks_map() {
       
        let vc = MapControllerDetailed()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchInfo() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("clientsInfo").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        self.dict = dictionary
                        self.fillStruct()
                        self.tableView.reloadData()
                }
        })
    }
    
    func fillStruct() {
        var i = 0
        while (dict.count > i) {
        let detailText = (Array(dict)[i].key)
        let rightText = (Array(dict)[i].value)
        let item = Item(image: UIImage(named: "logo.jpg")!, text: "hello", detailText:detailText, rightText:"\(rightText)")
        structArray.append(item)
            i += 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellid)
        if structArray.count == 0 {
            return cell
        }
        cell.textLabel!.text = "Счет №\(indexPath.row + 1): \(structArray[indexPath.row].detailText)"
        cell.detailTextLabel!.text = "\(structArray[indexPath.row].rightText) BYN"
        cell.textLabel?.textColor = .lightGray
        if (cell.detailTextLabel?.text != "0 BYN") {
        cell.detailTextLabel?.textColor = .black
            cell.textLabel?.textColor = .black
        }

        return cell
    }
    


}
