//
//  DetailPhoto.m
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "DetailPhoto.h"

@implementation DetailPhoto

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _detailTitle = [NSString new];
        _detailUserName = [NSString new];
        _detailLocation = [NSString new];
        _detailImage = [UIImage new];
        _detailUrl = [NSString new];
//        _detailDescription = [NSString new];
    }
    return self;
}
@end
