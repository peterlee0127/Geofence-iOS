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
    
    //取得檔案路徑
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/isGeofence.plist"];

    //
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([fileManager fileExistsAtPath: filePath]) //檢查檔案是否存在
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
    //存檔
    if (![plistDict writeToFile:filePath atomically: YES])
    {
        NSLog(@"writePlist fail");
    }
    plistDict=nil;
    
}
- (NSString *)readPlist
{
    //取得檔案路徑
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/isGeofence.plist"];
    //
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([fileManager fileExistsAtPath: filePath]) //檢查檔案是否存在
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
    
    //取得檔案路徑
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/message.plist"];
    
    //
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    if ([filemanager fileExistsAtPath: filePath]) //檢查檔案是否存在
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
    
    [plistDict setValue:message forKey:@"message"];
    
    
    //存檔
    if (![plistDict writeToFile:filePath atomically: YES])
    {
        NSLog(@"writePlist fail");
    }
    plistDict=nil;
    
}




@end
