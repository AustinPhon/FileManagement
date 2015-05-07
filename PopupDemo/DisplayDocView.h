//
//  DisplayDocView.h
//  FileManagement
//
//  Created by Mobile C&C on 5/6/15.
//  Copyright (c) 2015 MCNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayDocView : UIViewController

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end
