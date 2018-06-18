//
//  BlogViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 12/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BlogViewController : UIViewController<UIWebViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
