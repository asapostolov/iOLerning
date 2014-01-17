//
//  WebViewController.h
//  iRestaurant
//
//  Created by Apostol Apostolov on 1/17/14.
//  Copyright (c) 2014 Apostol Apostolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

-(void) loadUrl:(NSString *) stringUrl;

@property (nonatomic) NSString *loadUrl;
@end
