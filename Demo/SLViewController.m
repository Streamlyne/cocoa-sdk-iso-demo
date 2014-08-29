//
//  SLViewController.m
//  Demo
//
//  Created by Glavin Wiechert on 2014-08-29.
//  Copyright (c) 2014 Streamlyne Technologies Limited. All rights reserved.
//

#import "SLViewController.h"
#import "StreamlyneSDK.h"
#import "MBProgressHUD.h"

@interface SLViewController ()

@end

@implementation SLViewController
@synthesize emailTextField,passwordTextField,organizationTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInPressed:(id)sender {
    
    // Validate login
    
    // Streamlyne API Client
    NSString *host = @"54.183.15.175:5000";
    SLClient *client = [SLClient connectWithHost:host];
    
    // Get Login info
    NSString *email = emailTextField.text;
    NSString *password = passwordTextField.text;
    NSString *organization = organizationTextField.text;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    // Login with credentials
    [client authenticateWithUserEmail:email
                         withPassword:password
                     withOrganization:organization]
    .then(^(SLClient *client, SLUser *me) {
        
        [hud hide:YES];
        
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                           message:[NSString stringWithFormat:@"Welcome %@", me.firstName]
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
        
    }).catch(^(NSError *error) {
        
        [hud hide:YES];
        
        // Switch out error message for more user friendly message
        NSLog(@"Desc: %@", error.localizedDescription);
        NSLog(@"Recov: %@", error.localizedRecoverySuggestion);
        NSString *errorTitle = @"Login Failure";
        NSString *errorMessage = @"An unexpected error occurred.";
        if ([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"])
        {
            errorTitle = @"Login Failure";
            errorMessage = @"Your username, password, or organization is incorrect.";
        }
        else //if ([error.localizedDescription isEqualToString:@"Request failed: internal server error (500)"])
        {
            errorTitle = @"Server Error";
            errorMessage = @"Please contact dawson@streamlyne.co";
        }
        
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:errorTitle
                                                           message:errorMessage
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
        
    });
}

@end
