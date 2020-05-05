//
//  ViewController.swift
//  ArtBookProject
//
//  Created by mustafacan on 5.05.2020.
//  Copyright © 2020 mustafacan. All rights reserved.
//

import UIKit
import CoreData

class ArtBookTableViewCell : UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var bookList = [Paintings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("DIDLOAD")
        tableView.dataSource = self;
        tableView.delegate = self;
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton))
        
        setAllData();
    }

    @objc func clickAddButton() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "artBookCell", for: indexPath) as! ArtBookTableViewCell
        
        cell.lblName?.text = bookList[indexPath.row].name
        
        cell.lblYear?.text = String(bookList[indexPath.row].year)
        
        if let image = UIImage(data: bookList[indexPath.row].image!) {
            cell.img?.image = image
        }
        
        return cell;
    }
    
    func setAllData() {
        bookList.removeAll(keepingCapacity: false)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                let  list = results as! [Paintings]

                for item in list {
                    
                    bookList.append(item)
                }
            }
            

        } catch {
            print("error")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setAllData()
        print("viewDidAppear \(bookList.count)")
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
         print("viewDidDisappear")
    }
    
}

