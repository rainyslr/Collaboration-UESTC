//
//  welcomeViewController.h
//  MyBookRecycle
//
//  Created by 苏丽荣 on 16/6/17.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface welcomeViewController : UIViewController
- (IBAction)goHomePage:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *head;
- (IBAction)downImage:(id)sender;
- (IBAction)testReciveHtml:(id)sender;

- (IBAction)testImage:(id)sender;
@end