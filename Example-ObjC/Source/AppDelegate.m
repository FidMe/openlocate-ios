//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "AppDelegate.h"
#import <OpenLocate/OpenLocate-Swift.h>

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Endpoint *endpoint = [[Endpoint alloc] initWithUrl:[NSURL URLWithString:@"https://api.safegraph.com/v1/provider/17d375ec-a2ea-11e7-8078-02ae47b9ff6b/devicelocation"]
                                               headers:@{@"Authorization": @"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NjYwMzc3NDMsImlhdCI6MTUwODM1Nzc0Mywic2NvcGUiOiJpbmdlc3Q6MTdkMzc1ZWMtYTJlYS0xMWU3LTgwNzgtMDJhZTQ3YjlmZjZiIiwicHJvdmlkZXJfaWQiOiIxN2QzNzVlYy1hMmVhLTExZTctODA3OC0wMmFlNDdiOWZmNmIifQ.4j_J9dBaFoROFZsANvOa1VSTIp4gwUCjeDaAkJiU-Zc"}];
    Configuration *config = [[Configuration alloc] initWithEndpoints:@[endpoint]
                                       collectingFieldsConfiguration:[CollectingFieldsConfiguration default]
                                                transmissionInterval:Configuration.defaultTransmissionInterval
                                                 authorizationStatus:kCLAuthorizationStatusAuthorizedAlways];
    
    [OpenLocate.shared initializeWith:config error:nil];
    
    [OpenLocate.shared startTracking];
    
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [OpenLocate.shared performFetchWithCompletionHandler:completionHandler];
}

@end
