//
//  ViewController.swift
//  Liveblog
//
//  Created by Mathias Beke on 9/06/15.
//  Copyright © 2015 DenBeke. All rights reserved.
//

import UIKit
import Starscream


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WebSocketDelegate  {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //textView.textContainerInset = UIEdgeInsetsMake(8,8,4,8); // top, left, bottom, right
        
        // Register table cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Setup WebSocket
        let socket = WebSocket(url: NSURL(scheme: "ws", host: "labs.denbeke.be:1234", path: "/")!)
        socket.delegate = self
        socket.connect()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Interface for WebSockets
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        }
    }
    
    func websocketDidReceiveMessage(ws: WebSocket, text: String) {
    
        let json: NSDictionary
        do {
            // Parse JSON request
            try json = NSJSONSerialization.JSONObjectWithData(text.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            // Do something with the parsed JSON data
            if (json["Content"] != nil) {
                //label.text = (json["Content"] as! String)
                //textView.text = (json["Content"] as! String) + "\n\n" + textView.text
                items.insert(json["Content"] as! String, atIndex: 0)
                tableView.reloadData()
                //items =
            }
            
        }
        catch {
            print("Could not parse json message")
        }

        
        print("Received text: \(text)")
    }
    
    func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        print("Received data: \(data.length)")
    }
    
    
    // Overides for TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size: 14) // decrease font-size of label
        
        cell.textLabel?.text = self.items[indexPath.row]
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        //self.tableView.estimatedHeightForRowAtIndexPath()
        
        self.tableView.estimatedRowHeight = 68.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    
    
}

