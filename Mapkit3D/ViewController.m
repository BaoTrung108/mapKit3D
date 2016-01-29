//
//  ViewController.m
//  Mapkit3D
//
//  Created by Trung Bao on 1/29/16.
//  Copyright © 2016 Trung Bao. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@import AVFoundation;
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *outMap;
@property (weak, nonatomic) IBOutlet UIButton *outPause;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outSegment;

@end

@implementation ViewController
{
    AVAudioPlayer* audioPlay;
    BOOL isPause;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isPause = false;
    [self.outPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    self.outMap.delegate = self;
    [self setupLocation:53.463056 with:-2.291389];
    [self setupAudiowithName:@"music" withFileExtension:@"mp3"];
}
- (IBAction)butSegment:(id)sender {
    switch (self.outSegment.selectedSegmentIndex) {
        case 0:
            [self setupLocation:53.463056 with:-2.291389];
            break;
            case 1:
            [self setupLocation:51.555 with:-0.108611];
            break;
            case 2:
            [self setupLocation:53.430828 with:-2.960847];
            break;
            case 3:
            [self setupLocation:53.483056 with:-2.200278];
            break;
            case 4:
            [self setupLocation:41.38087 with:2.122802];
            break;
    }
}
- (IBAction)butPause:(id)sender {
    if (isPause) {
        [audioPlay stop];
        isPause = false;
        [self.outPause setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        [audioPlay play];
        isPause = true;
        [self.outPause setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}
- (void) setupAudiowithName:(NSString*) nameSong
          withFileExtension:(NSString*) fileExtension
{
    NSURL* urlAudio = [[NSBundle mainBundle] URLForResource:nameSong withExtension:fileExtension];
    NSError* error;
    audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:urlAudio error:&error];
    audioPlay.numberOfLoops = -1;
}
- (void) setupLocation: (float) lat
                  with: (float) longs
{
    CLLocationCoordinate2D locations = CLLocationCoordinate2DMake(lat, longs);
    self.outMap.region = MKCoordinateRegionMakeWithDistance(locations, 1000, 200);
    self.outMap.mapType = MKMapTypeSatellite;
    MKMapCamera* mapCamera = [MKMapCamera new];
    mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:locations fromDistance:1200 pitch:0 heading:90];
    self.outMap.camera = mapCamera;
}

@end
