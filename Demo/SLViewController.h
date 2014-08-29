//
//  SLViewController.h
//  Demo
//
//  Created by Glavin Wiechert on 2014-08-29.
//  Copyright (c) 2014 Streamlyne Technologies Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *organizationTextField;
- (IBAction)signInPressed:(id)sender;

@end
