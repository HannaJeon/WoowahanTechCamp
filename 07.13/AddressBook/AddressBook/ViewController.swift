//
//  ViewController.swift
//  AddressBook
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let synthesizer = AVSpeechSynthesizer()

    var nameArray = [
        [ "ᄀ": ["김다인", "김수완", "김준영", "김하은", "김형종"] ],
        [ "ᄇ": ["박예준", "박진수"] ],
        [ "ᄉ": ["서동욱", "송통일"] ],
        [ "ᄋ": ["양재형", "오세훈", "이단비", "이미정", "이정웅", "이준범"] ],
        [ "ᄌ": ["전한나"] ],
        [ "ᄎ": ["최송이", "최혜선"] ],
        [ "ᄒ": ["한민호", "한지웅", "홍성호", "홍창남", "황예린"] ] ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func speakSomething(name: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let mutableName: NSMutableString = NSMutableString.init(string: name)
        CFStringTransform(mutableName, nil, kCFStringTransformToLatin, Bool(0))
        let utterance = AVSpeechUtterance(string: String(mutableName))
        utterance.rate = 0.5
        synthesizer.speak(utterance)
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 50
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)

        if let name = cell?.textLabel?.text {
            speakSomething(name: name)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let key = nameArray[indexPath.section].keys.first {
                nameArray[indexPath.section][key]?.remove(at: indexPath.row)
                if nameArray[indexPath.section][key]!.isEmpty {
                    nameArray.remove(at: indexPath.section)
                }
                tableView.reloadData()
            }
        }
    }

}
