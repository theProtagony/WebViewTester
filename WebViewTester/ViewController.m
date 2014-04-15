//
//  ViewController.m
//  WebViewTester
//
//  Created by Mitesh Shah on 4/15/14.
//  Copyright (c) 2014 Scientific Games. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString * _lastUrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadUrl:@"http://www.google.com"];
    
    if(self.btnBrowse)
    {
        self.btnBrowse.target = self;
        [self.btnBrowse setAction:@selector(browsePressed)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) browsePressed
{
    // show alert
    NSString *msg = [NSString stringWithFormat:@""];
    if (_lastUrl != nil)
    {
        msg = [NSString stringWithString:_lastUrl];
    }
    
    UIAlertView * alert = [[UIAlertView alloc]
                           initWithTitle:@"Test Your Page" message:@"Enter a valid URL..." delegate:self cancelButtonTitle:@"Test It!"
                           otherButtonTitles:nil];
    
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.text = msg;
    
    [alert show];
    
}

- (void) loadUrl: (NSString*) url
{
    if(self.webView)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}


#pragma mark UIAlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        // presume enter url dialog
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
    NSString *txt = [[alertView textFieldAtIndex:0] text];
    
    // add http if not there
    NSURL *url = [NSURL URLWithString:txt];
    if (!url) return;
    
    if ([txt isEqualToString:@""]){
        txt = @"http://google.com";
    }

    if (!url.scheme)
    {
        txt = [NSString stringWithFormat:@"http://%@", txt ];
    }
    
    _lastUrl = [NSString stringWithString:txt];

    [self loadUrl:txt];
    
}


@end
