//
//  DetailViewController.h
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailUserName;
@property (weak, nonatomic) IBOutlet UILabel *detailLocation;

@end
