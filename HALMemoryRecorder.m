//
//  Spectator
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALMemoryRecorder.h"
#import "HALServer.h"

@interface HALMemoryRecorder ()

@property (weak, nonatomic) HALServer *server;

@end

@implementation HALMemoryRecorder

- (id)initWithServer:(HALServer *)server
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.server = server;
        
    return self;
}

- (void)parseLine:(NSString *)line
{
    NSArray *parts = [line componentsSeparatedByString:@" "];
    if ([parts count] == 5) {
        long long total;
        long long used;
        long long free;
        long long buffers;
        long long cached;
        
        NSScanner *scanner;
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:0]];
        [scanner scanLongLong:&total];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:1]];
        [scanner scanLongLong:&used];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:2]];
        [scanner scanLongLong:&free];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:3]];
        [scanner scanLongLong:&buffers];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:4]];
        [scanner scanLongLong:&cached];
        
        self.total = total;
        self.used = used;
        self.free = free;
        self.buffers = buffers;
        self.cached = cached;
    } else if ([parts count] == 6) {
        long long total;
        long long used;
        long long free;
        long long shared;
        long long buffers;
        long long cached;
        
        NSScanner *scanner;
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:0]];
        [scanner scanLongLong:&total];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:1]];
        [scanner scanLongLong:&used];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:2]];
        [scanner scanLongLong:&free];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:3]];
        [scanner scanLongLong:&shared];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:4]];
        [scanner scanLongLong:&buffers];
        
        scanner = [NSScanner scannerWithString:[parts objectAtIndex:5]];
        [scanner scanLongLong:&cached];
        
        self.total = total;
        self.used = used;
        self.free = free;
        self.shared = shared;
        self.buffers = buffers;
        self.cached = cached;
    } else {
        return;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"MemoryInfoChanged"
                                                        object:self.server];
}

@end
