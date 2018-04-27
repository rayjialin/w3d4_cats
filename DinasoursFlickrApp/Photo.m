//
//  Photo.m
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photoUrl = [NSString new];
        _photoTitle = [NSString new];
        _photoAuthor = [NSString new];
        _photoImage = [UIImage new];
    }
    return self;
}
@end
