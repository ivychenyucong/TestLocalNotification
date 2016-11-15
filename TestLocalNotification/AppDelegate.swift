//
//  AppDelegate.swift
//  TestLocalNotification
//
//  Created by ivy on 16/9/21.
//  Copyright © 2016年 ivy. All rights reserved.
//

import UIKit
import UserNotifications

let ivyFirstLaunch = "ivyFirstLaunch"
let categoryIdentifier = "categoryIdentifier"
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerLocalNotificationFor10()
        
        //registerLocalNotificationWraper(launchOptions:launchOptions)
        
        return true
    }
    
    func registerLocalNotificationForNormalFor10(){
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: appdelegate和通知的相关
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        print("ivy:handleAction:id:\(identifier)")
        
        addLogStr("|handle action ")
        
        completionHandler() //这个很重要
    }
    
    
    /// <#Description#>
    /// 通知到达! 仅限于到达时app前台,而不是被杀死
    /// - parameter application:  <#application description#>
    /// - parameter notification: <#notification description#>
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("ivy:i did receive local notification:\(notification.alertBody), application state:( UIApplication.shared.applicationState)")
        
       
        
        addLogStr("|suspend get notification")
    }
    
    
    /**
     注册 成功本地通之后,调用
     
     - parameter application:          <#application description#>
     - parameter notificationSettings: <#notificationSettings description#>
     */
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings){
        print("注册成功本地通知")
        
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "didRegisterUserNotificationSettings"), object: self)
    }
    
    
    //MARK: 通知的相关函数
    
    
    /// 注册通知 -ios10
    func registerLocalNotificationFor10(){
        let center = UNUserNotificationCenter.current()
        
        let action1 = UNNotificationAction(identifier: "yum", title:"Yum", options:.foreground)
        
        let action2 = UNNotificationAction(identifier: "ohno", title:"Oh, No!", options:.foreground)
        
          let action3 = UNNotificationAction(identifier: "ivy", title:"ivy is good ", options:.foreground)
        
         let action4 = UNNotificationAction(identifier: "hz", title:"hz is good bird", options:.foreground)
        
        
          let action5 = UNNotificationAction(identifier: "yaoer", title:"yao er is good", options:.foreground)
        
//        let category = UNNotificationCategory(identifier:categoryIdentifier, actions:[action1, action2], intentIdentifiers:["1"], options:[UNNotificationCategoryOptions.customDismissAction])
        
        //我看加不加customDismissAction都有clear 键嘛
        let category = UNNotificationCategory(identifier:"123", actions:[action1, action2,action3, action5, action4], intentIdentifiers:[], options:UNNotificationCategoryOptions(rawValue: 0))
            //[UNNotificationCategoryOptions()])

//        var categorySet = Set<UNNotificationCategory>()
//        categorySet.insert(category)
        
        //TODO: 设置了category,暂时效果未明
        //center.setNotificationCategories( categorySet)
        
        
        
        
        
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "Snooze",
                                                options:.foreground)
        
   
        
            //UNNotificationActionOptions(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: "STOP_ACTION",
                                              title: "Stop",
                                              options: .foreground)
        
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        
        
        center.setNotificationCategories( [ category])
        
        //该代理的头文件:文档说:delegate必须在app结束launch的时候设置,可以在appdelegate的
        //application(_:willFinishLaunchingWithOptions:)或者 application(_:didFinishLaunchingWithOptions:)中设置
        
        center.delegate = self
        
        center.getNotificationSettings { (UNNotificationSettings) in
            print("settsing is :\(UNNotificationSettings)")
        }
        
        //第一次请求权限会导致出对话框,问用户是否同意,以后就不会了
        center.requestAuthorization(options: [UNAuthorizationOptions.badge, UNAuthorizationOptions.sound , UNAuthorizationOptions.alert]) { (result, error) in
           // print("request authorization:\(result),请求权限成功")
            
            //姑且schedule通知
           //self.scheduleLocalNotificationFor10()
            
        }

        
    }
    

    /// 注册通知
    func registerLocalNotification(){
      
        //1 通知的类型
        let types : UIUserNotificationType = [.alert, .sound]
        
        //2 通知出现的实际"长相"   ---ios9
        let category = UIMutableUserNotificationCategory()
        category.identifier = categoryIdentifier
        
        //按钮1
        let action1 = UIMutableUserNotificationAction()
        action1.identifier = "yum"
        action1.title = "Yum" // user will see this
        action1.isDestructive = false
        action1.activationMode = .foreground
        
        //按钮2
        let action2 = UIMutableUserNotificationAction()
        action2.identifier = "ohno"
        action2.title = "Oh, No!" // user will see this
        action2.isDestructive = false
        action2.activationMode = .background
        
        action2.behavior = .textInput
        
        category.setActions([action1, action2], for: .default)
        
        let settings = UIUserNotificationSettings(types: types, categories: [category])
        UIApplication.shared
            .registerUserNotificationSettings(settings)
        
        
    }
    
    
    /// schedule一个本地通知
//    func scheduleLocalNotificationFor10(){
//        let content = UNMutableNotificationContent()
//        
//        content.title = "coffee"
//        content.body = "Time for another cup of coffee!"
//        content.sound = UNNotificationSound.default()
//        content.badge = 2
//        
//        content.categoryIdentifier = "123";
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:1, repeats:false)
//        
//        let request = UNNotificationRequest(identifier:"TIMER_EXPIRED_1", content:content,trigger:trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            print("注册成功!")
//        }
//        
//    }
    
    /// schedule一个本地通知
    func scheduleLocalNotification() {
        let ln = UILocalNotification()
        ln.alertBody = "Time for another cup of coffee!"
        ln.category = "coffee" // adds action buttons
        ln.fireDate = NSDate(timeIntervalSinceNow:5) as Date
        ln.soundName = UILocalNotificationDefaultSoundName
        
        ln.alertLaunchImage = "image1.jpg"
        
        UIApplication.shared.scheduleLocalNotification(ln)
    }
    
    /// 注册本地通知wraper, 在ios9上
    func registerLocalNotificationWraper(launchOptions:[UIApplicationLaunchOptionsKey: Any]?){
        //判断第一次启动时,注册----这个方法不好之处在于每次重新调试都要先删除app,不然UserDefaults的值还是有的 不调试 "杀死app时通知的表现" 时去掉这个if
        let firstTag = UserDefaults.standard.object(forKey:ivyFirstLaunch) as? String
        //if firstTag == nil || firstTag == "" {
        
        //指定通知机制的观察者---不是本地通知哈
        registerMyNotification()
        
        
        //注册本地通知 最好只注册一次,注册成功后,通知app  schedule通知
        registerLocalNotification()
        
        
        addLogStr("|start")
        //}
        
        //当程序not run时, 收到本地通知
        let notifyValue = launchOptions?[UIApplicationLaunchOptionsKey.localNotification]
        if notifyValue != nil {
            addLogStr("|launch get notification:\(notifyValue)")
        }
        
        
    }
    
    /// 注册成功后,系统可以schedule通知
    func registerMyNotification() {
        // ... as before ...
        var ob : NSObjectProtocol! = nil
        
        
        ob = NotificationCenter.default.addObserver(
        forName: NSNotification.Name(rawValue: "didRegisterUserNotificationSettings"), object: nil, queue: nil) {
            _ in
            NotificationCenter.default.removeObserver(ob)
            
            //我发现2个对象是不一样的,说明通知机制额外开了一个对象ob放入通知队列中
            print("\(ob),  \(self)")
            
            self.scheduleLocalNotification()
            
        }
    }
    
    
    func getVersion() -> Int{
        let os = ProcessInfo().operatingSystemVersion
        
        
        switch (os.majorVersion, os.minorVersion, os.patchVersion){
        case (10, 0, _):
            return 8;
        default:
            return 7;
        }
    }
    
    //MARK: Utils
    
    /// 加日志
    ///
    /// - parameter log: <#log description#>
    func addLogStr(_ log:String){
        
        var mStr:String?
        if let str = UserDefaults.standard.value(forKey: ivyFirstLaunch) as? String {
            mStr = str + log
            
        }else{
            mStr = log
        }
        
        UserDefaults.standard.set(mStr, forKey: ivyFirstLaunch)
    }

    

    //MARK: UNUserNotificationCenterDelegate
    
    
    ///
    /// 如文档所说,只有当通知到达时,并且app在前台时,会调用这个函数,这个函数决定是否要显示系统的通知提示
    /// 如果没有实现这个函数,或者没有调用completionHandler,都不会显示系统的通知
    /// - parameter center:            <#center description#>
    /// - parameter notification:      <#notification description#>
    /// - parameter completionHandler: <#completionHandler description#>
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        print("app在前台,接受到是否显示通知的delegate响应")
        completionHandler([UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.badge, UNNotificationPresentationOptions.sound])
        
        
        //UNNotificationPresentationOptionNone
        //completionHandler([])
        let i = 3
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        print("已经收到通知, action:\(response.actionIdentifier)")
    
       completionHandler()
     
        
//        
//        UNUserNotificationCenter.current().getPendingNotificationRequests { (pos:[UNNotificationRequest]) in
//            print("pending:\(pos.count)")
//            
//            
//            //UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        }
//        
//        UNUserNotificationCenter.current().getDeliveredNotifications { (nos: [UNNotification]) in
//            print("delivered:\(nos.count)")
//            
//            
//            //UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        }

       
    }
    
}

