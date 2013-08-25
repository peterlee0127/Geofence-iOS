//
//  SwitchModel.m
//  Geofence
//
//  Created by Peterlee on 8/5/13.
//  Copyright (c) 2013 Peterlee. All rights reserved.
//

#import "PlistModel.h"

@implementation PlistModel



- (void)writePlist:(BOOL) status
{
    

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/isGeofence.plist"];

    //
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([fileManager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
    if(status==YES)
    {
        [plistDict setValue:@"YES" forKey:@"isEnableGeoFence"];
    }
    else
    {
        [plistDict setValue:@"NO" forKey:@"isEnableGeoFence"];
    }
  
    if (![plistDict writeToFile:filePath atomically: YES])
    {
        NSLog(@"writePlist fail");
    }
    plistDict=nil;
    
}
- (NSString *)readPlist
{
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/isGeofence.plist"];
    //
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([fileManager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        plistDict = [[NSMutableDictionary alloc] init];
    }
    
    return [plistDict objectForKey:@"isEnableGeoFence"];
}





- (void)writetest:(NSString *) message
{
    
 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/message.plist"];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([filemanager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
    
    [plistDict setValue:message forKey:@"message"];
    

  
    if (![plistDict writeToFile:filePath atomically: YES])
    {
        NSLog(@"writePlist fail");
    }
    plistDict=nil;
    
}




@end
