//
//  ViewController.swift
//  Ringo-iOS
//
//  Created by Gautam Mittal on 5/23/15.
//  Copyright (c) 2015 Gautam Mittal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!

    
    let defaults = NSUserDefaults.standardUserDefaults();
    
    
    
    var items: [String] = []
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = (self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?)
        
        cell?.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 0.0);
        cell?.contentView.backgroundColor = UIColor.clearColor()
        cell?.separatorInset = UIEdgeInsetsZero;
        
        
        cell!.textLabel?.text = self.items[indexPath.row]
        cell!.textLabel?.textColor = UIColor.whiteColor()
        cell!.textLabel?.font = UIFont.init(name: "Roboto Light", size: 15.5)
        
        return cell!
        
    }
    
    
    override func viewDidLayoutSubviews() {
        self.tableView.separatorInset = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.respondsToSelector("setLayoutMargins:") {
            
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
//        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        print("You selected cell #\(selectedCell?.textLabel?.text)!")
        
        defaults.setValue(selectedCell?.textLabel?.text, forKey: "fileKEY");
        defaults.synchronize()
        
        performSegueWithIdentifier("toComp", sender: self)
    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
//        events = currentUser["events"] as? [String]
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var deletedCell = tableView.cellForRowAtIndexPath(indexPath)
            items.removeAtIndex(indexPath.row)
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            if var data = self.defaults.objectForKey("savedSandboxes") as? NSDictionary {
                var mutableData = NSMutableDictionary(dictionary: data)
                mutableData.removeObjectForKey((deletedCell?.textLabel?.text)!);
                
                self.defaults.setObject(mutableData, forKey: "savedSandboxes");
                self.defaults.synchronize()
                
                
            }
            
            
            
//            let deleteKey = deletedCell?.textLabel?.text;
//
//            print(deletedCell?.textLabel?.text)
//            
//            if let text = deletedCell?.textLabel?.text {
//                print(text);
//                data.removeObjectForKey(text);
//            }
            
            
            
//            data[(deletedCell?.textLabel?.text)!] = nil; // delete the key
            
            
            
            
//            data[tableView[indexPath.row]];
            
            
//            currentUser["events"] = events
        }
        
//        currentUser.saveInBackground()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barTintColor = UIColor(red: 19.0/255.0, green: 25.0/255.0, blue: 62.0/255.0, alpha: 1.0);
        navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.init(name: "Roboto Light", size: 21)!, NSForegroundColorAttributeName: UIColor.whiteColor()];
        
        navigationController!.setToolbarHidden(true, animated: true)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        if #available(iOS 9.0, *) {
            tableView.cellLayoutMarginsFollowReadableWidth = false
        } else {
            // Fallback on earlier versions
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        defaults.setObject(nil, forKey: "fileKEY")
        defaults.synchronize()
        
        if ((defaults.objectForKey("savedSandboxes")) != nil) {
            
            items = [];
            
            let disk = defaults.objectForKey("savedSandboxes") as! NSDictionary;
            
            print(disk)
            
            for n in disk {
                print(n.key)
                items.append(n.key as! String)
                
                
            }
        }
        
        
        tableView.reloadData()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

