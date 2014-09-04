//
//  main.m
//  mutableArrayValueForValueOfNilTest
//
//  Created by Peter Hosey on 2014-09-03.
//  Copyright (c) 2014 Peter Hosey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PropertyOwner.h"

int main(int argc, char *argv[]) {
	@autoreleasepool {
		PropertyOwner *owner = [PropertyOwner new];

		NSMutableArray *things = [owner mutableArrayValueForKey:@"listOfThings"];
		NSLog(@"Things 0 (pointer only): %p", things);
		NSLog(@"Things 0 (class only): %@", things.class);

		owner.listOfThings = @[ @"Thing" ];
		NSLog(@"Things 1: %@", things);

		owner.listOfThings = nil;
		NSLog(@"Things 2: %@", things);
	}
	return EXIT_SUCCESS;
}

