//
//  ProjectViewController.swift
//  Ringo-iOS
//
//  Created by Gautam Mittal on 4/23/16.
//  Copyright © 2016 Gautam Mittal. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fileTableView: UITableView!
    @IBOutlet weak var projectSideLabel: UILabel!
    
    @IBOutlet weak var lineNumbers: UITextView!
    @IBOutlet weak var codeEditor: UITextView!
    
    var items: [String] = ["Hello.m", "World.h", "SuperAwesome.mmswifty"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = (self.fileTableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?)
        
        cell?.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 0.0);
        cell?.contentView.backgroundColor = UIColor.clearColor()
        cell?.separatorInset = UIEdgeInsetsZero;
        
        
        cell!.textLabel?.text = self.items[indexPath.row]
        cell!.textLabel?.textColor = UIColor.blackColor()
        cell!.textLabel?.font = UIFont.init(name: "Roboto Light", size: 12)
        
        
        return cell!
        
    }
    
    
    override func viewDidLayoutSubviews() {
        self.fileTableView.separatorInset = UIEdgeInsetsZero
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
        

    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        

    }
    
    
    func lineNumberUpdate() {
        
        var rows = round( (codeEditor.contentSize.height - codeEditor.textContainerInset.top - codeEditor.textContainerInset.bottom) / codeEditor.font!.lineHeight );
        
        var lineNumContent = String();
        
        for var i = 0; i < Int(rows); i++ {
            if (i == 0) {
                lineNumContent += String(i+1);
            } else {
                lineNumContent += "   " + String(i+1);
            }
            
        }
        
        lineNumbers.text = lineNumContent;
        
        lineNumbers.contentOffset.y = codeEditor.contentOffset.y;
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("lineNumberUpdate"), userInfo: nil, repeats: true)
        
        
        self.fileTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fileTableView.separatorInset = UIEdgeInsetsZero
        self.fileTableView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        if #available(iOS 9.0, *) {
            fileTableView.cellLayoutMarginsFollowReadableWidth = false
        } else {
            // Fallback on earlier versions
        }
        
        fileTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
