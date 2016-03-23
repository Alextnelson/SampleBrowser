//
//  ViewController.m
//  SampleBrowser
//
//  Created by Alexander Nelson on 3/22/16.
//  Copyright © 2016 Alexander Nelson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlTextField.text = @"http://www.espn.go.com";
    [self goToURL:self.urlTextField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToURL:self.urlTextField.text];
    [textField resignFirstResponder];
    return YES;
}

-(void)goToURL:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.networkActivityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
}

@end
