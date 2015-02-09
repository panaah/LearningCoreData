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
    
    if (_objPerson) {
        [btnSaveAndAddMore setTitle:@"Update Info" forState:UIControlStateNormal];
        [btnSaveAndExit setTitle:@"DELETE" forState:UIControlStateNormal];
        
        self.txtName.text = self.objPerson.name;
        self.txtAge.text = [NSString stringWithFormat:@"%@",self.objPerson.age];
        self.txtSex.text = self.objPerson.sex;
        self.txtPhone.text = self.objPerson.phone;
        self.txtCity.text = self.objPerson.address.city;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.objPerson) {
        [self.txtName becomeFirstResponder];
    }
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
    
    if (self.objPerson) {
        NSLog(@"do update");
        
        Person *record = (Person *)[_delegate.managedObjectContext objectWithID:self.objPerson.objectID];
//        NSError *error;
//        Person *record = (Person *)[_delegate.managedObjectContext existingObjectWithID:self.objPerson.objectID error:&error];
        [record setValue:self.txtName.text forKey:@"name"];
        [record setValue:[NSNumber numberWithInteger:[self.txtAge.text integerValue]] forKey:@"age"];
        [record setValue:self.txtSex.text forKey:@"sex"];
        [record setValue:self.txtPhone.text forKey:@"phone"];

        // Address record
        Address *addressRecord;
        if (self.objPerson.address == nil) {
            NSEntityDescription *addressEntity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:_delegate.managedObjectContext];
            addressRecord = (Address *)[[NSManagedObject alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:_delegate.managedObjectContext];
        } else {
            addressRecord = (Address *)[_delegate.managedObjectContext objectWithID:self.objPerson.address.objectID];
//            NSError *error;
//            Address *addressRecord = (Address *)[_delegate.managedObjectContext existingObjectWithID:self.objPerson.address.objectID error:&error];
        }
        
        [addressRecord setValue:self.txtCity.text forKey:@"city"];
//        [addressRecord setValue:self.txtSex.text forKey:@"state"];
//        [addressRecord setValue:self.txtPhone.text forKey:@"zip"];
//        [addressRecord setValue:self.txtPhone.text forKey:@"country"];
//        [addressRecord setValue:self.txtPhone.text forKey:@"street"];
        
        record.address = addressRecord;
        
        // Save Record
        NSError *error = nil;
        
        if ([_delegate.managedObjectContext save:&error]) {
            // Dismiss View Controller
//            [self dismissViewControllerAnimated:YES completion:nil];
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Person info is updated." delegate:self cancelButtonTitle:@"Great" otherButtonTitles:nil] show];

        } else {
            if (error) {
                NSLog(@"Unable to update record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be updated." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else {
        //    if (name && name.length) {
        // Create Person's Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_delegate.managedObjectContext];
        Person *record = (Person *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_delegate.managedObjectContext];
        // Populate Record
        [record setValue:self.txtName.text forKey:@"name"];
        [record setValue:[NSNumber numberWithInteger:[self.txtAge.text integerValue]] forKey:@"age"];
        [record setValue:self.txtSex.text forKey:@"sex"];
        [record setValue:self.txtPhone.text forKey:@"phone"];
        
        // Create Address entity
        NSEntityDescription *addressEntity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:_delegate.managedObjectContext];
        NSManagedObject *addressRecord = [[NSManagedObject alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:_delegate.managedObjectContext];
//        [addressRecord setValue:self.txtCity.text forKey:@"street"];
        [addressRecord setValue:self.txtCity.text forKey:@"city"];
//        [addressRecord setValue:self.txtCity.text forKey:@"state"];
//        [addressRecord setValue:self.txtCity.text forKey:@"country"];
//        [addressRecord setValue:self.txtCity.text forKey:@"zip"];
        record.address = (Address *)addressRecord;
        
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
}

- (IBAction)btnSaveAndExitClicked:(id)sender {
    if (self.objPerson) {
        NSLog(@"do delete");
        
//        Person *record = (Person *)[_delegate.managedObjectContext objectWithID:self.objPerson.objectID];
        NSError *error;
        Person *record = (Person *)[_delegate.managedObjectContext existingObjectWithID:self.objPerson.objectID error:&error];
        [_delegate.managedObjectContext deleteObject:record];
        if ([_delegate.managedObjectContext save:&error]) {
            // Dismiss View Controller
//            [self dismissViewControllerAnimated:YES completion:nil];
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Person is deleted" delegate:self cancelButtonTitle:@"Ok. Take me back !!" otherButtonTitles:nil] show];
            
        } else {
            if (error) {
                NSLog(@"Unable to update record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your to-do could not be deleted." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        
    } else {
        //    if (name && name.length) {
        // Create Person's Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_delegate.managedObjectContext];
        Person *record = (Person *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_delegate.managedObjectContext];
        // Populate Record
        [record setValue:self.txtName.text forKey:@"name"];
        [record setValue:[NSNumber numberWithInteger:[self.txtAge.text integerValue]] forKey:@"age"];
        [record setValue:self.txtSex.text forKey:@"sex"];
        [record setValue:self.txtPhone.text forKey:@"phone"];
        
        // Create Address entity
        NSEntityDescription *addressEntity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:_delegate.managedObjectContext];
        NSManagedObject *addressRecord = [[NSManagedObject alloc] initWithEntity:addressEntity insertIntoManagedObjectContext:_delegate.managedObjectContext];
//        [addressRecord setValue:self.txtCity.text forKey:@"street"];
        [addressRecord setValue:self.txtCity.text forKey:@"city"];
//        [addressRecord setValue:self.txtCity.text forKey:@"state"];
//        [addressRecord setValue:self.txtCity.text forKey:@"country"];
//        [addressRecord setValue:self.txtCity.text forKey:@"zip"];
        record.address = (Address *)addressRecord;
        
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
}

- (IBAction)btnCancelClicked:(id)sender {
    if (self.objPerson) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
         [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self btnCancelClicked:nil];
}

@end
