//
//  PhotoCell.h
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitle;

@end
