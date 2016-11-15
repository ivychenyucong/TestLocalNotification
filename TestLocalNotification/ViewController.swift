//
//  ViewController.swift
//  TestLocalNotification
//
//  Created by ivy on 16/9/21.
//  Copyright © 2016年 ivy. All rights reserved.
//
import UserNotifications
import UIKit

class ViewController: UIViewController {
    
    var i : Int?
    
    @IBAction func clickAddNotification(_ sender: Any) {
        scheduleLocalNotificationFor10()
    }
    


//    lazy var notifyLabel: UILabel = {
//        var label = UILabel()
//        label.frame = CGRect(origin: CGPoint(x:20,y:30), size:CGSize(width:self.scrollView.contentSize.width,height:self.scrollView.contentSize.height))
//        label.backgroundColor = UIColor.yellow
//        label.numberOfLines = 0
//        self.scrollView.addSubview(label)
//        return label
//    }()
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        i = 0;
        // Do any additional setup after loading the view, typically from a nib.
        
 

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // self.notifyLabel.text = UserDefaults.standard.value(forKey: ivyFirstLaunch) as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentSettings()->UIUserNotificationSettings?{
        return UIApplication.shared.currentUserNotificationSettings
    }

    func scheduleLocalNotificationFor10(){
        let content = UNMutableNotificationContent()
        
        content.title = "coffee"
        content.body = "Time for another cup of coffee!"
        content.sound = UNNotificationSound.default()
        
        content.categoryIdentifier = "123";
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:3, repeats:false)
        
        i = i! + 1;
    
        let request = UNNotificationRequest(identifier:"TIMER_EXPIRED_\(i!)", content:content,trigger:trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print("注册成功!")
        }
        
    }

   
}

