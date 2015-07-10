//
//  ViewController.swift
//  lightSwitchOn
//
//  Created by Jeroen van Dijk on 09/07/15.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("start applicatie");
        checkState();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkState(){
        println("turn on");
        let url = NSURL(string: "ip-adress/cgi-bin/json.cgi?get=state")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var out = NSString(data: data, encoding: NSUTF8StringEncoding);
            print(out);
            let json = JSON(data: data);
            let state = json["content"].stringValue; //depence on json data you're trying to receive
            println(state);
            if(state == "light: off"){ //response from json
                println("You may switch on!");
                self.switchLight("on");
            }
            else if(state == "light: on"){
                println("You may switch off!");
                self.switchLight("off");
            }
        }
        task.resume();
    }
   
    func switchLight(set: String){
        let url = NSURL(string: "ip-adress/cgi-bin/json.cgi?set="+set)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        close();
    }

    func close(){
        sleep(2); //delay for a while. Give the URLsession time to response
        exit(0); // force app to close. I know ugly ^^
    }

}

