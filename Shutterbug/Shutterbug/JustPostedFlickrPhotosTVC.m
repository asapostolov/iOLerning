//
//  JustPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Apostol Apostolov on 1/15/14.
//  Copyright (c) 2014 Apostol Apostolov. All rights reserved.
//

#import "JustPostedFlickrPhotosTVC.h"
#import "Flickr Fetcher/FlickrFetcher.h"

@implementation JustPostedFlickrPhotosTVC

-(void) viewDidLoad{
    [super viewDidLoad];
    [self fetchPhotos];
}

- (IBAction) fetchPhotos{
    [self.refreshControl beginRefreshing];
    
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    dispatch_queue_t fetchQ= dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQ
                   , ^{
       NSData *jsonResults = [NSData dataWithContentsOfURL:url];
       NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                                           options:0
                                                                                             error:NULL];
                       
       NSLog(@"Flickr results = %@", propertyListResults);
                       
       NSArray  *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.refreshControl endRefreshing];
           self.photos = photos;
           
       });
       
    });
    
}

@end
