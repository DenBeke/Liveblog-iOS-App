//
//  ViewController.swift
//  Liveblog
//
//  Created by Mathias Beke on 9/06/15.
//  Copyright © 2015 DenBeke. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate  {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView.textContainerInset = UIEdgeInsetsMake(8,5,8,5); // top, left, bottom, right
        
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
                textView.text = (json["Content"] as! String) + "\n\n" + textView.text
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
    
    
    
}

