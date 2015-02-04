//
//  Person.h
//  LearningCoreData
//
//  Created by Thakur VJ on 04/02/15.
//  Copyright (c) 2015 Thakur VJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * personId;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSManagedObject *address;

@end
