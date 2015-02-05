//
//  AddViewController.m
//  LearningCoreData
//
//  Created by Thakur VJ on 05/02/15.
//  Copyright (c) 2015 Thakur VJ. All rights reserved.
//

#import "AddViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface AddViewController ()
{
    AppDelegate *_delegate;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _delegate = [[UIApplication sharedApplication] delegate];
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
- (void)resetTextfields {
    self.txtName.text = @"";
    self.txtAge.text = @"";
    self.txtSex.text = @"";
    self.txtPhone.text = @"";
    self.txtCity.text = @"";
}

- (IBAction)btnSaveAndAddMoreClicked:(id)sender {
    
//    if (name && name.length) {
        // Create Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_delegate.managedObjectContext];
        
        // Initialize Record
        NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_delegate.managedObjectContext];
        
        // Populate Record
        [record setValue:self.txtName.text forKey:@"name"];
        [record setValue:[NSNumber numberWithInteger:[self.txtAge.text integerValue]] forKey:@"age"];
        [record setValue:self.txtSex.text forKey:@"sex"];
        [record setValue:self.txtPhone.text forKey:@"phone"];
//        [record setValue:self.txtName.text forKey:@"personId"];
        
        // Save Record
        NSError *error = nil;
        
        if ([_delegate.managedObjectContext save:&error]) {
            // Dismiss View Controller
//            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
//    } else {
//        // Show Alert View
//        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }

    [self resetTextfields];
    [self.txtName becomeFirstResponder];
}

- (IBAction)btnSaveAndExitClicked:(id)sender {
    //    if (name && name.length) {
    // Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_delegate.managedObjectContext];
    
    // Initialize Record
    NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_delegate.managedObjectContext];
    
    // Populate Record
    [record setValue:self.txtName.text forKey:@"name"];
    [record setValue:[NSNumber numberWithInteger:[self.txtAge.text integerValue]] forKey:@"age"];
    [record setValue:self.txtSex.text forKey:@"sex"];
    [record setValue:self.txtPhone.text forKey:@"phone"];
    //        [record setValue:self.txtName.text forKey:@"personId"];
    
    // Save Record
    NSError *error = nil;
    
    if ([_delegate.managedObjectContext save:&error]) {
        // Dismiss View Controller
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (error) {
            NSLog(@"Unable to save record.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    //    } else {
    //        // Show Alert View
    //        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do needs a name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    //    }
    
}

- (IBAction)btnCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
