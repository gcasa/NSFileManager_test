//
//  main.m
//  NSFileManager_test
//
//  Created by Gregory John Casamento on 8/3/19.
//  Copyright © 2019 Gregory John Casamento. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Show whether test was passed */
void passTest(BOOL flag,
              NSString *msg)
{
    if(flag == YES)
    {
        NSLog(@"PASS: %@",msg);
    }
    else
    {
        NSLog(@"FAIL: %@",msg);
    }
}

/* Run all tests */
void runTests()
{
    NSURL *homeURL = [NSURL URLWithString: NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [fileManager URLForDirectory:NSItemReplacementDirectory
                                     inDomain:NSUserDomainMask
                            appropriateForURL:homeURL
                                       create:NO
                                        error:NULL];
    NSLog(@"%@",url);
    passTest([[url absoluteString] containsString: @"Temporary"],
             @"Creates a temporary directory");
    
    url = [fileManager URLForDirectory:NSUserDirectory
                              inDomain:NSUserDomainMask
                     appropriateForURL:homeURL
                                create:NO
                                 error:NULL];
    NSLog(@"%@",url);
    passTest(url == nil, @"Returns nil");
    
    url = [fileManager URLForDirectory:NSUserDirectory
                              inDomain:NSAllDomainsMask
                     appropriateForURL:nil
                                create:NO
                                 error:NULL];
    NSLog(@"%@",url);
    passTest([[url absoluteString] isEqualToString: @"file:///Users/"],
             @"Returns user parent dir");
    
    url = [fileManager URLForDirectory:NSLibraryDirectory
                              inDomain:NSAllDomainsMask
                     appropriateForURL:nil
                                create:NO
                                 error:NULL];
    NSLog(@"%@",url);
    passTest([[url absoluteString] isEqualToString: @"file:///Users/heron/Library/"],
             @"Returns user parent dir");
    
    url = [fileManager URLForDirectory:NSTrashDirectory
                              inDomain:NSAllDomainsMask
                     appropriateForURL:nil
                                create:NO
                                 error:NULL];
    NSLog(@"%@",url);
    passTest([[url absoluteString] isEqualToString: @"file:///Users/heron/.Trash/"],
             @"Returns user parent dir");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        runTests();
    }
    return 0;
}
