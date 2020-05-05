//
//  ViewController.swift
//  ArtBookProject
//
//  Created by mustafacan on 5.05.2020.
//  Copyright © 2020 mustafacan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton))
    }

    @objc func clickAddButton() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

