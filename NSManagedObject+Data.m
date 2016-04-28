//
//  NSManagedObject+Data.m
//
//  Created by Maurice Raguse on 30.06.15.
//  Copyright (c) 2015 Maurice Raguse All rights reserved.
//
//  Version 1.0

#import "NSManagedObject+Data.h"
#import "AppDelegate.h"
 
 

@implementation NSManagedObject (Data)

+(void)save
{
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate saveContext];
}

+(NSManagedObjectContext*)moc
{
    AppDelegate * appDelegate = [[UIApplication sharedApplication]delegate];
    return appDelegate.managedObjectContext;
}

+(void)deleteAllEntities
{
    NSString *name = NSStringFromClass(self.class);
    [self deleteEntitiesForName:name withPredicate:nil];
}

+(void)deleteAllEntitiesForName:(NSString*)name
{
    [self deleteEntitiesForName:name withPredicate:nil];
}

+(void)deleteEntitiesWithPredicate:(NSPredicate*)predicate
{
    NSString *name = NSStringFromClass(self.class);
    [self deleteEntitiesForName:name withPredicate:predicate];
}

/**
 * Deletes the object without force saving the context!
 * @author Maurice Raguse
 */
-(void)deleteEntity
{
    [self.managedObjectContext deleteObject:self];
}

-(void)deleteEntityAndSaveContext:(BOOL)shouldSaveContext
{
    [self.managedObjectContext deleteObject:self];
    
    if (shouldSaveContext)
    {
        [NSManagedObject save];
    }
}

+(void)deleteEntitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    NSError* error;
    NSArray* allEntities = [[self moc] executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error.localizedDescription);
        abort();
    }
    
    for (NSManagedObject *Entity in allEntities)
    {
        [Entity.managedObjectContext deleteObject:Entity];
    }
    [self save];
}

+(NSArray*)allEntitiesWithSortDescriptors:(NSArray*)sortDescriptors
{
    NSString *name = NSStringFromClass(self.class);
    return [self allEntitiesForName:name sortDescriptors:sortDescriptors];
}

+(NSArray*)allEntitiesForName:(NSString*)name sortDescriptors:(NSArray*)sortDescriptors
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray* allEntities = [[self moc] executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error.localizedDescription);
        abort();
    }
    
    return allEntities;
}

+(NSArray*)entitiesWithPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors
{
    NSString *name = NSStringFromClass(self.class);
    return [self entitiesForName:name withPredicate:predicate sortDescriptors:sortDescriptors];
}

+(NSArray*)entitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:name];
    [fetchRequest setPredicate:predicate];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    NSError* error;
    NSArray* allEntities = [[self moc] executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"Error: %@", error.localizedDescription);
        abort();
    }
    
    return allEntities;
    
}

+(NSArray*)entitiesWithPredicate:(NSPredicate*)predicate
{
    return [self entitiesWithPredicate:predicate sortDescriptors:nil];
}

+(NSArray*)entitiesForName:(NSString*)name withPredicate:(NSPredicate*)predicate
{
    return [self entitiesForName:name withPredicate:predicate sortDescriptors:nil];
}

+(instancetype)entityWithPredicate:(NSPredicate*)predicate
{
    NSString *name = NSStringFromClass(self.class);
    return [self entityForName:name withPredicate:predicate];
}

+(instancetype)entityForName:(NSString*)name withPredicate:(NSPredicate*)predicate
{
    NSArray* allEntities = [self entitiesForName:name withPredicate:predicate];
    
    if (allEntities && allEntities.count > 0)
    {
        return allEntities[0];
    }
    
    return nil;
}

/**
 * Creates an new instance from self classname type.
 * @author Maurice Raguse
 *
 * @return The new entity instance.
 */
+(instancetype)createEntity
{
    NSString *name = NSStringFromClass(self.class);
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[self moc]];;
}

/**
 * Creates an new instance for an entity type.
 * @author Maurice Raguse
 *
 * @return The new entity instance.
 *
 * @param name The class name of the entity.
 */
+(instancetype)createEntityForName:(NSString*)name
{
    return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[self moc]];;
}

@end
