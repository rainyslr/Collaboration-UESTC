//
//  BookDetailViewController.h
//  MyBookRecycle
//
//  Created by 苏丽荣 on 16/6/27.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailInfo.h"
#import "EGOImageButton.h"


@interface BookDetailViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *bookAuthorLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *publisherLabel;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong, nonatomic) IBOutlet UILabel *numRatersLabel;
@property (strong, nonatomic) IBOutlet EGOImageButton *bookCoverBtn;

@property (strong, nonatomic) IBOutlet UILabel *discount;
@property (strong, nonatomic) IBOutlet UILabel *originalPrice;

- (IBAction)addToCart:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addToCartBtn;

@property (strong, nonatomic) IBOutlet UITextView *summaryText;
- (IBAction)changeTextContent:(id)sender;
- (IBAction)getPriceComparison:(id)sender;
- (IBAction)GoDouBan:(id)sender;
- (IBAction)collect:(id)sender;

@property (nonatomic ,assign) BOOL IsGroupBuy;//指示书籍是否为GroupBuy活动中的书籍
@property (nonatomic, copy) NSString* promotionID;
@property (nonatomic, copy) NSString* bookIsbn;
@property (nonatomic, copy) BookBaseInfo* bookBaseInfo;


@end
