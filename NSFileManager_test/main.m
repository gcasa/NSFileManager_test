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
    
    url = [fileManager URLForDirectory:NSUserDirectory
                              inDomain:NSUserDomainMask
                     appropriateForURL:nil
                                create:NO
                                 error:NULL];
    NSLog(@"%@",url);
    passTest(url == nil,
             @"Returns nil");
}

void runTest2()
{
    NSURL *homeURL = [NSURL URLWithString: NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *keysArray = [NSArray arrayWithObject: NSURLFileSizeKey];
    NSDirectoryEnumerator * en =  [fileManager enumeratorAtURL: homeURL
                                    includingPropertiesForKeys: keysArray
                                                       options: NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                  errorHandler: NULL];
    
    id obj = nil;
    while((obj = [en nextObject]) != nil)
    {
        NSLog(@"%@",obj);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        runTests();
        runTest2();
    }
    return 0;
}
