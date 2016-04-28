# SimpleCoreData

How to install:

(0. Create Project with CoreData)

1. Copy category "NSManagedObject+Data" in your Project (Download Link)

2. If you have a .pch file, you can import the category there

3. DONE :-)


How to use it:


in your ViewController class:

(if category is imported by precompiled header file you only need to import your entity class ... else import the category "NSManagedObject+Data" too.

#import "MyCustomEntity.h"
#import "NSManagedObject+Data.h"

-(void)methodFoo
{
         //get all entities of MyCustomEntity
         NSArray *myCostumEntities = [MyCustomEntity allEntitiesWithSortDescriptors:nil];

         //create a new entity in db
         MyCustomEntity *newOne = (MyCustomEntity*)[MyCustomEntity createEntity];

         //delete a entity
         [newOne deleteEntity]; 
         // or 
         [MyCustomEntity deleteEntitiesWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",newOne.name]];
}
