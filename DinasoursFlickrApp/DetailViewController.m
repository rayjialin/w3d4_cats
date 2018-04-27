//
//  DetailViewController.m
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "DetailViewController.h"
#import "SafariViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailImageView.image = self.image;
}

- (IBAction)jumpToSafari:(UIButton *)sender {
    SafariViewController *safariVC = [SafariViewController new];
    [self presentViewController:safariVC animated:YES completion:nil];
}


@end
