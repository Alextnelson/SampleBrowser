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
@property UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.networkActivityIndicator];
    self.urlTextField.text = @"http://www.espn.go.com";
    [self goToURL:self.urlTextField.text];
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *check = self.urlTextField.text;
    BOOL result = [[check lowercaseString] hasPrefix:@"http://"];
    
    if (result) {
        [self goToURL:self.urlTextField.text];
    }
    else {
        NSString *good = [NSString stringWithFormat:@"http://%@", self.urlTextField.text];
        [self goToURL:good];
    }
    [textField resignFirstResponder];
    return YES;
}

-(void)goToURL:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.urlTextField.text = urlString;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.networkActivityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.networkActivityIndicator stopAnimating];
    
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    }
    
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    }
    
}
- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

- (IBAction)addingFeaturesAlert:(id)sender {
    UIAlertController *newFeatureComing = [UIAlertController alertControllerWithTitle:@"Coming soon!" message:@"We are adding some features" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [newFeatureComing dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [newFeatureComing addAction:defaultAction];
    [self presentViewController:newFeatureComing animated:YES completion:nil];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertController *loadFailure = [UIAlertController alertControllerWithTitle:@"Loading Failed" message:@"Your website did not load properly" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [loadFailure dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [loadFailure addAction:defaultAction];
    [self presentViewController:loadFailure animated:YES completion:nil];
}


@end
