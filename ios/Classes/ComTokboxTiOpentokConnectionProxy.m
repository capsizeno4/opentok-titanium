/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokConnectionProxy.h"
#import <Opentok/OTConnection.h>

@implementation ComTokboxTiOpentokConnectionProxy

#pragma mark - Helpers

- (void)requireConnectionInitializationWithLocation:(NSString *)codeLocation andMessage:(NSString *)message {
    if (_connection == nil) {
        [self throwException:TiExceptionInternalInconsistency
                   subreason:message
                    location:codeLocation];
    }
}

- (void)requireConnectionInitializationWithLocation:(NSString *)codeLocation {
    [self requireConnectionInitializationWithLocation:codeLocation andMessage:@"This connection was not properly initialized"];
}

#pragma mark - Initialization

// This is NOT meant to be called from javascript land, only for native code use.
// TODO: store weak reference to session proxy?
- (id)initWithConnection:(OTConnection *)existingConnection {
    
    self = [super init];
    if (self) {
        // Initializations
        _connection = existingConnection;
    }
    
    return self;
}

// Overriding designated initializer in order to prevent instantiation from javascript land (hopefully)
- (id)init {
    return nil;
}

#pragma mark - Deallocation


#pragma mark - Properties

-(id)connectionId
{
    [self requireConnectionInitializationWithLocation:CODELOCATION];
    return _connection.connectionId;
}

-(id)creationTime
{
    [self requireConnectionInitializationWithLocation:CODELOCATION];
    return _connection.creationTime;
}

#pragma mark - Opentok Object Proxy

- (id) backingOpentokObject
{
    return _connection;
}

@end
