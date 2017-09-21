//
//  SpeechPlugin.h
//
//  Created by Marcel Goya from LinguSocial on 16/07/16.
//
//

#import <Cordova/CDV.h>
#import <PermissionScope/PermissionScope-Swift.h>

@interface PermissionScopePlugin : CDVPlugin {
    
}

- (void) initialize:(CDVInvokedUrlCommand*)command;

- (void) addPermission:(CDVInvokedUrlCommand*)command;

- (void) show:(CDVInvokedUrlCommand*)command;

- (void) requestPermission:(CDVInvokedUrlCommand*)command;

@end

