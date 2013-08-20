//
//  ViewController.m
//  Geofence
//
//  Created by Peterlee on 7/31/13.
//  Copyright (c) 2013 Peterlee. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end
@implementation ViewController
@synthesize locationManager,entertextView,exittextView;
@synthesize plistmodel;


NSArray *_regionArray;

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark - Observer

-(void) EnterOb:(NSNotification *) note
{
    NSDictionary *thedata=[note userInfo];
    if(thedata!=nil)
    {

    }
}
-(void) ExitOb:(NSNotification *) note
{
    NSDictionary *thedata=[note userInfo];
    if(thedata!=nil)
    {

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(EnterOb:) name:@"Enter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExitOb:) name:@"Exit" object:nil];
    self.entertextView.text=@"";
    self.exittextView.text=@"";
    self.pushMessage=[[NSString alloc] init];

    
    self.plistmodel=[[PlistModel alloc]init];
    [self addRegionCircleLayout];
    [self initializeLocationManager];
    [self.locationManager startUpdatingLocation];
    [self initializeMap];
    NSArray *geofences = [self buildGeofenceData];
   
       
    if( [[self.plistmodel readPlist]isEqualToString:@"YES"])
    {
        [self startRegionMonitoring:geofences];
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
    else
    {
        [self stopRegionMonitoring:geofences];
        [self.locationManager stopMonitoringSignificantLocationChanges];
        [self.switchGeofence setOn:NO];
    }

 
    
    UITapGestureRecognizer *press = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressToGetLocation:)];
    press.numberOfTapsRequired = 1;
    press.numberOfTouchesRequired = 1;
    [self.mapView addGestureRecognizer:press];
    self.mapView.delegate=self;
    
   	// Do any additional setup after loading the view, typically from a nib.
}



-(IBAction)switchGeofence:(id)sender
{
    NSArray *geofences = [self buildGeofenceData];
    if(self.switchGeofence.isOn==YES)
    {
        [self.locationManager startUpdatingLocation];
        [self startRegionMonitoring:geofences];
        [plistmodel writePlist:YES];
    }
    else
    {
        [self stopRegionMonitoring:geofences];
        [self.locationManager stopMonitoringSignificantLocationChanges];
        [plistmodel writePlist:NO];
    }
}

-(void) addRegionCircleLayout
{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"regions" ofType:@"plist"];
    _regionArray = [NSArray arrayWithContentsOfFile:plistPath];
    for(NSDictionary *regionDict in _regionArray)
    {    
        CLRegion *region = [self mapDictionaryToRegion:regionDict];
//        CLCircularRegion *region = [self mapDictionaryToRegion:regionDict];
        // Draw Circle

        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(region.center.latitude,region.center.longitude);
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:centerCoordinate radius:region.radius];
        [self.mapView addOverlay:circle];
    }
}


- (void)initializeMap
{
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = locationManager.location.coordinate.latitude;
    initialCoordinate.longitude = locationManager.location.coordinate.longitude;
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 300, 300) animated:YES];
    self.mapView.centerCoordinate = initialCoordinate;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (void)initializeLocationManager
{
    if(![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"%@",@"You need to enable location services to use this app.");
        return;
    }
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.activityType=CLActivityTypeOtherNavigation;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    self.locationManager.distanceFilter=20;
    
}


- (void) startRegionMonitoring:(NSArray*)geofences
{
    for(CLRegion *geofence in geofences)
    {
        [self.locationManager startMonitoringForRegion:geofence];
    }
}
-(void) stopRegionMonitoring:(NSArray*)geofences
{
    for(CLRegion *geofence in geofences)
    {
        [self.locationManager stopMonitoringForRegion:geofence];
    }
}

- (NSArray*) buildGeofenceData
{
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"regions" ofType:@"plist"];
    _regionArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *geofences = [NSMutableArray array];
    for(NSDictionary *regionDict in _regionArray)
    {
        CLRegion *region = [self mapDictionaryToRegion:regionDict];
        [geofences addObject:region];
    }
    return [NSArray arrayWithArray:geofences];
}
// - (CLCircularRegion *)mapDictionaryToRegion:(NSDictionary*)dictionary {
- (CLRegion*)mapDictionaryToRegion:(NSDictionary*)dictionary {
    NSString *title = [dictionary valueForKey:@"title"];
    
    CLLocationDegrees latitude = [[dictionary valueForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude =[[dictionary valueForKey:@"longitude"] doubleValue];
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    CLLocationDistance regionRadius = [[dictionary valueForKey:@"radius"] doubleValue];
   return [[CLRegion alloc] initCircularRegionWithCenter:centerCoordinate radius:regionRadius  identifier:title];
 
}
-(IBAction)toCurrentLocation:(id)sender
{
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = self.locationManager.location.coordinate.latitude;
    initialCoordinate.longitude = self.locationManager.location.coordinate.longitude;
    
    self.coordinateLabel.text = [NSString stringWithFormat:@"%f,%f",initialCoordinate.latitude ,initialCoordinate.longitude];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 300, 300) animated:YES];
    self.mapView.centerCoordinate = initialCoordinate;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}


- (void) pressToGetLocation:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D location =[self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

    NSLog(@"Tap:%f %f",location.latitude,location.longitude);    
}



#pragma mark - Location Manager - Region Task Methods 




- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSDictionary *dataDict=[NSDictionary dictionaryWithObject:region.identifier forKey:@"Enter"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Enter" object:self userInfo:dataDict];
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];

    [self httpPost:[NSString stringWithFormat:@"%@   進入:%@",currentTime,region.identifier ]];
    
    [self.plistmodel writetest:[NSString stringWithFormat:@"進入%@區域",region.identifier] ];
    
    [self sentLocalPushNotification:[NSString stringWithFormat:@"%@ 進入區域:%@",currentTime,region.identifier] ];
    self.entertextView.text=[[NSString stringWithFormat:@"%@ %@\n",currentTime,[NSString stringWithFormat:@"進入區域:%@",region.identifier]] stringByAppendingString:self.entertextView.text];
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSDictionary *dataDict=[NSDictionary dictionaryWithObject:region.identifier forKey:@"Exit"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Exit" object:self userInfo:dataDict];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    
    
    [self httpPost:[NSString stringWithFormat:@"%@   離開:%@",currentTime,region.identifier]];
     [self.plistmodel writetest:[NSString stringWithFormat:@"離開%@區域",region.identifier] ];

    [self sentLocalPushNotification:[NSString stringWithFormat:@"%@ 離開區域:%@",currentTime,region.identifier]];
    self.exittextView.text=[[NSString stringWithFormat:@"%@ %@\n",currentTime,[NSString stringWithFormat:@"離開區域:%@",region.identifier]] stringByAppendingString:self.exittextView.text];
}



-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{

    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
   NSLog(@"Start montioring %@", region.identifier);

   self.entertextView.text=[[NSString stringWithFormat:@"%@\n",[NSString stringWithFormat:@"montioring %@ 區域",region.identifier]] stringByAppendingString:self.entertextView.text];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Region monitoring failed with error: %@", [error localizedDescription]);
}


-(void) sentLocalPushNotification:(NSString *) message
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil)
    {
      
        notification.alertAction=@"Alert";
        notification.alertBody=message;
        notification.hasAction=YES;
        [[UIApplication sharedApplication]  presentLocalNotificationNow:notification];
    }

}


#pragma mark - MKMapView Delegate

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKCircle class]])
    {
        MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
        circleView.strokeColor = [UIColor redColor];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        return circleView;
    }
    else
    {
    if (!self.crumbView)
    {
            _crumbView = [[CrumbPathView alloc] initWithOverlay:overlay];
    }
        return self.crumbView;
    }

}


#pragma mark -  Http post 

-(void) httpPost:(NSString *) message
{
//    NSURL *POSTURL=[[NSURL alloc] initWithString:@"http://192.168.2.38:8080"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:POSTURL ];
//    
//    NSString *post = [NSString stringWithFormat:@"name=%@&message=%@",[[UIDevice currentDevice] name],message];
//    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
//    [request setValue: @"application/text" forHTTPHeaderField: @"Accept"];
//    [request setValue: @"application/text; charset=utf-8" forHTTPHeaderField: @"content-type"];
//    [request setHTTPMethod:@"POST"];    //Set Http Hethod
//    [request setHTTPBody:postData];     //Set Post Data
//
//    
//    [NSURLConnection  sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response,NSData *data, NSError *error)
//     {
//         if ([data length] >0 && error == nil)
//         {
//              NSLog(@"Res: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//         }
//         else if ([data length] == 0 && error == nil)
//         {
//             NSLog(@"Nothing was downloaded.");
//         }
//         else if (error != nil)
//         {
//             NSLog(@"Error = %@", error);
//         }
//         
//     }];
    
}


#pragma mark - Location Manager - Standard Task Methods, Draw path

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *location=[locations lastObject];
    self.coordinateLabel.text = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
    
    if (!self.crumbs)
    {
        // This is the first time we're getting a location update, so create
        // the CrumbPath and add it to the map.
        //
        _crumbs = [[CrumbPath alloc] initWithCenterCoordinate:location.coordinate];
        [self.mapView addOverlay:self.crumbs];
        
        // On the first location update only, zoom map to user location
        MKCoordinateRegion region =
        MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
        [self.mapView setRegion:region animated:YES];
    }
    else
    {
        // This is a subsequent location update.
        // If the crumbs MKOverlay model object determines that the current location has moved
        // far enough from the previous location, use the returned updateRect to redraw just
        // the changed area.
        //
        // note: iPhone 3G will locate you using the triangulation of the cell towers.
        // so you may experience spikes in location data (in small time intervals)
        // due to 3G tower triangulation.
        //
        MKMapRect updateRect = [self.crumbs addCoordinate:location.coordinate];
        
        if (!MKMapRectIsNull(updateRect))
        {
            // There is a non null update rect.
            // Compute the currently visible map zoom scale
            MKZoomScale currentZoomScale = (CGFloat)(self.mapView.bounds.size.width / self.mapView.visibleMapRect.size.width);
            // Find out the line width at this zoom scale and outset the updateRect by that amount
            CGFloat lineWidth = MKRoadWidthAtZoomScale(currentZoomScale);
            updateRect = MKMapRectInset(updateRect, -lineWidth, -lineWidth);
            // Ask the overlay view to update just the changed area.
            [self.crumbView setNeedsDisplayInMapRect:updateRect];
        }
    }

}
@end

