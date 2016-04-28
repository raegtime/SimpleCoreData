//
//  NSManagedObject+Data.h
//   
//
//  Created by Maurice Raguse on 30.06.15.
//  Copyright (c) 2015 Maurice Raguse All rights reserved.
//
//  Version 1.0

#import <CoreData/CoreData.h>

@interface NSManagedObject (Data)

+(void)save;

+(instancetype)createEntity;
+(instancetype)createEntityForName:(NSString*)name;

+(void)deleteAllEntitiesForName:(NSString*)name;
+(void)deleteAllEntities;

-(void)deleteEntity;
-(void)deleteEntityAndSaveContext:(BOOL)shouldSaveContext;

+(void)deleteEntitiesWithPredicate:(NSPredicate*)predicate;
+(void)deleteEntitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate;

+(instancetype)entityWithPredicate:(NSPredicate*)predicate;
+(instancetype)entityForName:(NSString*)name withPredicate:(NSPredicate*)predicate;

+(NSArray*)entitiesWithPredicate:(NSPredicate*)predicate;
+(NSArray*)entitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate;

+(NSArray*)entitiesWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
+(NSArray*)entitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;

+(NSArray*)allEntitiesForName:(NSString*)name sortDescriptors:(NSArray*)sortDescriptors;
+(NSArray*)allEntitiesWithSortDescriptors:(NSArray*)sortDescriptors;
@end

