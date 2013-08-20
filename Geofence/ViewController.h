//
//  ViewController.h
//  Geofence
//
//  Created by Peterlee on 7/31/13.
//  Copyright (c) 2013 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CrumbPath.h"
#import "CrumbPathView.h"
#import "PlistModel.h"


@interface ViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>


@property (weak,nonatomic) IBOutlet UILabel *coordinateLabel;
@property (weak,nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) IBOutlet UITextView *entertextView;
@property (strong,nonatomic) IBOutlet UITextView *exittextView;
@property (nonatomic,strong) IBOutlet UISwitch *switchGeofence;
@property (nonatomic,strong) NSString *pushMessage;
@property (nonatomic,strong) PlistModel *plistmodel;

@property (nonatomic, strong) CrumbPath *crumbs;
@property (nonatomic, strong) CrumbPathView *crumbView;


@end
