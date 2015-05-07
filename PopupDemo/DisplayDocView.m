//
//  DisplayDocView.m
//  FileManagement
//
//  Created by Mobile C&C on 5/6/15.
//  Copyright (c) 2015 MCNC. All rights reserved.
//

#import "DisplayDocView.h"
#import "AppDelegate.h"

@interface DisplayDocView ()

@end

@implementation DisplayDocView
@synthesize webview;
@synthesize url;

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    webview.contentMode=UIViewContentModeScaleAspectFit;
    NSURL *targetURL = [NSURL fileURLWithPath:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setShouldRotate:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
