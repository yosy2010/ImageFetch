//
//  main.m
//  ImageFetch
//
//  Created by YASSER ALTAMIMI on 03/01/1440 AH.
//  Copyright © 1440 YASSER ALTAMIMI. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // 1- create a url
        NSURL *url = [NSURL URLWithString:@"http://www.google.com/images/logos/ps_logo2.png"];
        
        // 2- create a request
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 3- create an error pointer
        NSError *error;
        
        // 4- get the data
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
        
        // check for errors
        if (!data) {
            NSLog(@"fetch failed %@", [error localizedDescription]);
            return 1;
        }
        
        // no error: proceed the excution
        NSLog(@"the file is %lu byte", (unsigned long) [data length]);
        
        // write to path and return a bool to check if it'c correctly written
        BOOL written = [data writeToFile:@"/tmp/google.png" options:NSDataWritingAtomic error:&error];
        
        // not wrote correctly: log that and exit
        if (!written) {
            NSLog(@"there was an error writing the file into the folder %@",[error localizedDescription]);
            return 2;
        }
        
        // no error: log success
        NSLog(@"success");
        
        // read the file into a data file and see how many bytes it is
        // read it inti an NSData object
        NSData *readData = [NSData dataWithContentsOfFile:@"/tmp/google.png" options:0 error:&error];
        
        // error: log it and exit
        if (!readData) {
            NSLog(@"there was an error reading the file %@", [error localizedDescription]);
            return 3;
        }
        
        // success: log it with how many byte
        NSLog(@"read successfully,the file is %lu kb", (unsigned long) [readData length] / 1024);
        
    }
    
    // secussess
    return 0;
}
