//
//  SpeechPlugin.m
//
//  Created by Marcel Goya from LinguSocial on 16/07/16.
//
//

#import "PermissionScopePlugin.h"

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <UserNotifications/UserNotifications.h>

@interface PermissionScopePlugin () <CLLocationManagerDelegate>
@property (nonatomic, strong) NSString *callbackId;
@end

@implementation PermissionScopePlugin

- (void) initialize:(CDVInvokedUrlCommand*)command {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) addPermission:(CDVInvokedUrlCommand*)command {
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) show:(CDVInvokedUrlCommand*)command {
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) requestPermission:(CDVInvokedUrlCommand*)command {
    self.callbackId = command.callbackId;
    NSString *permission = [command.arguments objectAtIndex:0];
    
    if([permission isEqualToString:@"Notifications"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound)
                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                     [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"Contacts"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                CNEntityType entityType = CNEntityTypeContacts;
                CNContactStore * contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"Microphone"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                   [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"LocationInUse"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                CLLocationManager *location = [[CLLocationManager alloc] init];
                location.delegate = self;
                [location requestWhenInUseAuthorization];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"Camera"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if(authStatus == AVAuthorizationStatusNotDetermined){
                    @try {
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                        }];
                    }
                    @catch (NSException *exception) {
                       [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
                    }
                } else {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"Photos"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus granted) {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
        
    } else if([permission isEqualToString:@"Speech"]) {
        
        [self.commandDelegate runInBackground:^{
            @try {
                [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus granted) {
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                }];
            }
            @catch (NSException *exception) {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:self.callbackId];
}

@end
