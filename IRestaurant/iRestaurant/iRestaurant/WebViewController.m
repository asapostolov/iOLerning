//
//  WebViewController.m
//  iRestaurant
//
//  Created by Apostol Apostolov on 1/17/14.
//  Copyright (c) 2014 Apostol Apostolov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *pageView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadPage];
    
    //CGRect frame = self.pageView.frame;
    //frame.size.width = 100;
    //self.pageView.frame = frame;
    
    //self.pageView.scalesPageToFit = YES;
    
}

-(void)loadPage{
    //self.pageView.frame = CGRectMake(5, 5, self.view.frame.size.width, self.view.frame.size.height);
    //self.pageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.pageView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ", (int)self.pageView.frame.size.width]];
    
    NSString *fullURL = [NSString stringWithFormat:@"%@/pdf", self.loadUrl ] ;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.pageView loadRequest:requestObj];
}
//-(void) loadUrl:(NSString *) stringUrl{
    
    
//    NSURL *url = [NSURL URLWithString:stringUrl];
//NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    [self.pageView loadRequest:requestObj];
    
    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
