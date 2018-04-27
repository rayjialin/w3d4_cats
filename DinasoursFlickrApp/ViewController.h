//
//  ViewController.h
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "PhotoCell.h"
#import "AFNetworking.h"
#import "DetailPhoto.h"
#import "DetailViewController.h"
#import "SafariViewController.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) Photo *photo;
@property (nonatomic) DetailPhoto *detailPhoto;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailUserName;
@property (weak, nonatomic) IBOutlet UILabel *detailLocation;

@end

