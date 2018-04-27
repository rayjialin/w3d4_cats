//
//  Photo.h
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Photo : NSObject

@property (nonatomic) NSString *photoUrl;
@property (nonatomic) NSString *photoTitle;
@property (nonatomic) NSString *photoAuthor;
@property (nonatomic) UIImage *photoImage;
@end
