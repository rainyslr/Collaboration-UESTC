//
//  BookBaseInfo.m
//  MyBookRecycle
//
//  Created by 苏丽荣 on 16/6/26.
//  Copyright © 2016年 苏丽荣. All rights reserved.
//

#import "BookBaseInfo.h"

@implementation BookBaseInfo
//- (instancetype)initBook:(NSString*)Isbn withOriginalPrice:(NSString*)oPrice currentPrice:(NSString*)cPrice searchLink:(NSString*)link
//{
//    self = [super init];
//    if (self) {
//        self.PromotionBookISBN = Isbn;
//        self.PromotionBookCurrentPrice = cPrice;
//    }
//    return self;
//}
//
//- (instancetype)initBook:(NSString*)Isbn withName:(NSString*)name currentPrice:(NSString*)cPrice imageLink:(NSString*)ilink searchLink:(NSString*)slink {
//    self = [super init];
//    if (self) {
//        self.PromotionBookISBN = Isbn;
//        self.promotionBookName = name;
//        self.PromotionBookCurrentPrice = cPrice;
//        self.promotionBookImageLink = ilink;
//        self.PromotionBookSearchLink = slink;
//    }
//    return self;
//}

- (id)copyWithZone:(NSZone *)zone
{
    BookBaseInfo *info = [[[self class] alloc] init];
    info.PromotionBookISBN = self.PromotionBookISBN;
    info.promotionBookName = self.promotionBookName;
    info.promotionBookImageLink = self.promotionBookImageLink;
    info.PromotionBookCurrentPrice = self.PromotionBookCurrentPrice;
    return info;
}

-(instancetype)initBook:(NSString*)Isbn name:(NSString*)aName currentPrice:(NSString*)cPrice imageLink:(NSString*)link {
    self = [super init];
    if (self) {
        self.PromotionBookISBN = Isbn;
        self.promotionBookName = aName;
        self.promotionBookImageLink = link;
        self.PromotionBookCurrentPrice = cPrice;
    }
    return self;
}
@end