//
//  SpeechPlugin.m
//
//  Created by Marcel Goya from LinguSocial on 16/07/16.
//
//

#import "PermissionScopePlugin.h"

@interface PermissionScopePlugin ()
@property (nonatomic, strong) PermissionScope *pscope;
@property (nonatomic, strong) NSString *callbackId;
@end

@implementation PermissionScopePlugin

- (void) initialize:(CDVInvokedUrlCommand*)command {
    self.pscope = [[PermissionScope alloc]init];
    self.pscope.viewControllerForAlerts = self.viewController;
    
    self.pscope.onAuthChange = ^(BOOL finished, NSArray<PermissionResult *>* results){
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    };
    
    self.pscope.onCancel = ^(NSArray<PermissionResult *>* results){
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    };
    
    self.pscope.onDisabledOrDenied = ^(NSArray<PermissionResult *>* results){
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    };
    
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
        if(self.pscope.statusNotifications == PermissionStatusUnknown) {
            [self.pscope requestNotifications];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"Contacts"]) {
        if(self.pscope.statusContacts == PermissionStatusUnknown) {
            [self.pscope requestContacts];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"Microphone"]) {
        if(self.pscope.statusMicrophone == PermissionStatusUnknown) {
            [self.pscope requestMicrophone];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"LocationInUse"]) {
        if(self.pscope.statusLocationInUse == PermissionStatusUnknown) {
            [self.pscope requestLocationInUse];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"Camera"]) {
        if(self.pscope.statusCamera == PermissionStatusUnknown) {
            [self.pscope requestCamera];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"Photos"]) {
        if(self.pscope.statusPhotos == PermissionStatusUnknown) {
            [self.pscope requestPhotos];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    } else if([permission isEqualToString:@"Speech"]) {
        if(self.pscope.statusSpeech == PermissionStatusUnknown) {
            [self.pscope requestSpeech];
        } else {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        }
    }
}

@end
