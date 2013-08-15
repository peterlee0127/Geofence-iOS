//
//  SwitchModel.h
//  Geofence
//
//  Created by Peterlee on 8/5/13.
//  Copyright (c) 2013 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface PlistModel : NSObject


- (void)writePlist:(BOOL) status;
- (NSString *)readPlist;


- (void)writetest:(NSString *) message;

@end
