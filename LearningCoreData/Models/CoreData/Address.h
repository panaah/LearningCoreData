//
//  Address.h
//  LearningCoreData
//
//  Created by Thakur VJ on 04/02/15.
//  Copyright (c) 2015 Thakur VJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) Person *person;

@end
