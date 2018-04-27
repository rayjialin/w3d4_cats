//
//  SafariViewController.m
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "SafariViewController.h"
#import <SafariServices/SafariServices.h>

@interface SafariViewController () <SFSafariViewControllerDelegate>

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:@"https://www.flickr.com/photos/muchlove2016/27247676614/"];
    
//    safariVC.delegate = self;



}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
