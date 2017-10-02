//
//  ViewController.m
//  NSDictionary
//
//  Created by Puvanarajan on 10/2/17.
//  Copyright © 2017 Puvanarajan. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+DictCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Json" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *jsonDictionay = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    
    // Before removeing Null values
    NSLog(@"%@", jsonDictionay);
    
    // After replace the null values
    
    NSDictionary *tempDict = [jsonDictionay dictionaryRemovingNSNullValues];
    NSLog(@"%@", tempDict);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

