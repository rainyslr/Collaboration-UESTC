//
//  AppDelegate.m
//  MyBookRecycle
//
//  Created by 苏丽荣 on 16/5/9.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/html",@"text/plain",nil];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.OnLineTest = NO;
//    self.OnLineTest = YES;
    [self initShopList];
//    self.baseUrl = @"http://192.168.1.146:8000";
//    self.baseUrl = @"http://192.168.1.100:8000";
//    self.baseUrl = @"http://192.168.3.107:8000";
    self.baseUrl = @"http://115.159.219.141:8000";

    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    //判断是否由远程消息通知触发应用程序启动
    if (launchOptions) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
            
            NSDictionary* pushInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
            if (pushInfo)
            {
                NSDictionary *apsInfo = [pushInfo objectForKey:@"aps"];
                if(apsInfo)
                {
                    NSString *alerMsg = [apsInfo objectForKey:@"alert"];
                    
                    
                    NSMutableString *msg = [[NSMutableString alloc] initWithFormat:@"alerMsg:%@",alerMsg];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }

        }
    }
    return YES;
}

-(void)application:(UIApplication* )application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *str = [NSString
                     stringWithFormat:@"Device Token=%@",deviceToken];
    NSLog(@"%@",str);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"alert");
    NSDictionary *dic = [userInfo objectForKey:@"aps"];
    NSString *alerMsg = [dic objectForKey:@"alert"];
    NSString *state;
    if (application.applicationState == UIApplicationStateActive) {
        state = @"active";
    }
    else if(application.applicationState == UIApplicationStateInactive)
    {
        state = @"inactive";
    }
    
    NSMutableString *msg = [[NSMutableString alloc] initWithFormat:@"%@.alerMsg:%@。",state, alerMsg];
    NSMutableArray *keys = [NSMutableArray arrayWithArray:userInfo.allKeys];
    [keys removeObject:@"aps"];
    for (id key in keys) {
        [msg appendString:[NSString stringWithFormat:@"key: %@, value: %@", key, [userInfo objectForKey:key]]];
        NSLog(@"key: %@, value: %@。", key, [userInfo objectForKey:key]);
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收到数据为：" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    //    [BPush handleNotification:userInfo];
    //    [self applicationOnReceiveNotification:userInfo];
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"%@",str);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"call fetch");
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:3000/update.do"];
//    NSURLSession *updateSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    [updateSession dataTaskWithHTTPGetRequest:url
//                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                NSDictionary *messageInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                NSLog(@"messageInfo:%@",messageInfo);
//                                completionHandler(UIBackgroundFetchResultNewData);
//                            }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSDictionary *dic = [userInfo objectForKey:@"aps"];
    NSString *alerMsg = [dic objectForKey:@"alert"];
    NSString *state;
    if (application.applicationState == UIApplicationStateActive) {
        state = @"active";
    }
    else if(application.applicationState == UIApplicationStateInactive)
    {
        state = @"inactive";
    }
    
    NSMutableString *msg = [[NSMutableString alloc] initWithFormat:@"%@.alerMsg:%@。",state, alerMsg];
    NSMutableArray *keys = [NSMutableArray arrayWithArray:userInfo.allKeys];
    [keys removeObject:@"aps"];
    for (id key in keys) {
        [msg appendString:[NSString stringWithFormat:@"key: %@, value: %@", key, [userInfo objectForKey:key]]];
        NSLog(@"key: %@, value: %@。", key, [userInfo objectForKey:key]);
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收到数据为：" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
//    UIBackgroundFetchResult *result = 
    NSLog(@"fetch");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.thinkofsomethingclever.MyBookRecycle" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyBookRecycle" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyBookRecycle.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark --内部函数
- (void)initShopList{
//    self.shopList = [NSArray arrayWithObjects:@"京东",@"亚马逊",@"当当",@"天猫",@"中图",nil];
    self.shopList = [NSDictionary dictionaryWithObjectsAndKeys:@"jd.com",@"京东", @"amazon.cn", @"亚马逊", @"dangdang.com",@"当当",@"taobao.com",@"天猫", @"bookschina.com",@"中图",nil];
}

@end