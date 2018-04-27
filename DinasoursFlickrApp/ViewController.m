//
//  ViewController.m
//  DinasoursFlickrApp
//
//  Created by ruijia lin on 4/26/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *photoArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.detailView.hidden = TRUE;
    self.photoArray = [NSMutableArray new];
    [self makeNetworkRequest:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=2da5c79660e494bf3778ed6caa21696f&tags=dinasour" completion:^(NSDictionary *dict) {
        [self processResponseDictionary:(NSDictionary *)dict];
    }];
    
    
}


-(void)makeNetworkRequest:(NSString *)urlStr completion:(void(^)(NSDictionary *dict))completed{
    
    // URL to use
    NSString *urlString = urlStr;
    
    // Convert string to URL object
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Create a NSURLSessionDataTask object that will execute the URL and get a response
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Handle response here, we're still in the background thread
        if (error != nil) {
            // If error is not nil, an error was encountered
            dispatch_async(dispatch_get_main_queue(), ^{
                // Back at main queue
                //                self.label.text = @"Error";
                NSLog(@"Error: %@", error);
            });
            return;
        }
        
        // Parse the server's response
//        [self processResponse:data];
        
        // Convert data to JSON (parsing)
        NSError *parsingError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&parsingError];
        if (error != nil) {
            // Error in parsing JSON
            dispatch_async(dispatch_get_main_queue(), ^{
                // Back at main queue
                //            self.label.text = @"Error";
                NSLog(@"Error: %@", error);
            });
            return;
        }
        
        // Cast JSON to NSDictionary only if it is truly a dictionary
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *)json;
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self processResponseDictionary:jsonDict];
                completed(jsonDict);
            });
        }
        
    }];
    
    // Execute the task in a background thread
    [dataTask resume];
    
}

-(void)processResponseDictionary:(NSDictionary *)responseDictionary{
    //    NSLog(@"jsonDict: %@", responseDictionary);
    // Walk through dictionary, etc...
    
    NSArray *jsonArray = [NSArray arrayWithObjects:responseDictionary[@"photos"][@"photo"], nil];
    //    NSLog(@"jsonArray:  %@", jsonArray);
    
    for (NSDictionary *photoDict in jsonArray[0]){
        
        // Instantiate photo object
        Photo *photo = [Photo new];
        photo.photoTitle = photoDict[@"title"];
        photo.photoUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", photoDict[@"farm"], photoDict[@"server"],photoDict[@"id"],photoDict[@"secret"]];
        [self.photoArray addObject:photo];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        // This will run on the main queue
        [self.collectionView reloadData];
    }];
}

//-(void)processResponseDictForDetail:(NSDictionary *)detailDict{
//
//    NSLog(@"json: %@", detailDict);
//    self.detailPhoto.detailUserName = detailDict[@"photo"][@"owner"][@"username"];
//    self.detailPhoto.detailUrl = detailDict[@"photo"][@"urls"][@"url"][0][@"_content"];
//    self.detailPhoto.detailLocation = detailDict[@"photo"][@"owner"][@"location"];
//}


-(void)processImageDownload:(NSIndexPath *)indexPath{
    
    Photo *photo = [self.photoArray objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:photo.photoUrl]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            photo.photoImage = image; // 4
            [self.collectionView reloadData];
        }];
        
    }]; // 4
    
    
    [downloadTask resume]; // 5
    //    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    
    Photo *photo = [Photo new];
    photo = [self.photoArray objectAtIndex:indexPath.row];
    
    // check if the image is downloaded
    if ([photo.photoImage CIImage] == nil){
        [self processImageDownload:indexPath];
    }
    
    cell.photoView.image = photo.photoImage;
    cell.photoTitle.text = photo.photoTitle;
    //    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

//    [self makeNetworkRequest:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&format=json&nojsoncallback=1&api_key=2da5c79660e494bf3778ed6caa21696f&photo_id=27247676614&tags=dinasour" completion:^(NSDictionary *dict) {
//        [self processResponseDictForDetail:(NSDictionary *)dict];
//    }];
    
    [self performSegueWithIdentifier:@"segueToDetail" sender:indexPath];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath{
    
    if ([[segue identifier] isEqualToString:@"segueToDetail"])
    {
        // Get reference to the destination view controller
        DetailViewController *detailVC = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        detailVC.image = [[self.photoArray objectAtIndex:indexPath.row] photoImage];
    }
    
}
@end
