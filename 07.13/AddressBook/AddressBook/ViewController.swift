//
//  ViewController.swift
//  AddressBook
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let nameArray = [
        [ "ᄀ" : ["김다인","김수완","김준영","김하은","김형종"] ],
        [ "ᄇ" : ["박예준","박진수"] ],
        [ "ᄉ" : ["서동욱","송통일"] ],
        [ "ᄋ" : ["양재형","오세훈","이단비","이미정","이정웅","이준범"] ],
        [ "ᄌ" : ["전한나"] ],
        [ "ᄎ" : ["최송이","최혜선"] ],
        [ "ᄒ" : ["한민호","한지웅","홍성호","홍창남","황예린"] ] ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let names = nameArray[section].flatMap { $0.value }
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let names = nameArray.flatMap { Array($0.values) }

        cell.textLabel?.text = String(describing: names[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = nameArray.flatMap { Array($0.keys) }
        return header[section]
    }
    
}

