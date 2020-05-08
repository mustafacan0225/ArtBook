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
    
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contenView: UIView!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var bookList = [Paintings]()
    var selectedItem : Paintings?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settingsBackground()
       
        print("DIDLOAD")
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self;
        tableView.delegate = self;
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton))
        
        //setAllData();
    }

    @objc func clickAddButton() {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = bookList[indexPath.row];
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let target = segue.destination as! DetailsViewController;
            target.selectedItem = selectedItem;
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "artBookCell", for: indexPath) as! ArtBookTableViewCell
        
        cell.contenView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        cell.mainView.layer.cornerRadius = 8
        
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = bookList[indexPath.row].id?.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
            let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == bookList[indexPath.row].id {
                                context.delete(result)
                                bookList.remove(at: indexPath.row)
                                
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                    
                                } catch {
                                    print("error")
                                }
                                
                                break
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }
            } catch {
                print("error")
            }
            
            
            
            
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
    
    func settingsBackground() {
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        /*gradientLayer.colors = [#colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 1).cgColor, UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1).cgColor]*/
        
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        
        // Diagonal: top left to bottom corner.
        //gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        //gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.

        // Horizontal: left to right.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // Left side.
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // Right side.
        
        // Apply the gradient to the backgroundGradientView.
        parentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

