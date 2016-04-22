//
//  ContactManager.m
//  Contact
//
//  Created by Md Adit Hasan on 4/22/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "ContactManager.h"

@interface ContactManager()

@property (nonatomic, strong) NSArray *contacts;

@end

@implementation ContactManager
/**
 @return singleTon instance
 */

+ (ContactManager *)shareInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self alloc];
    });
    
    return sharedInstance;
}

/**
 Load contacts from End point
 */
-(NSArray *)getContacts {
    return self.contacts;
}

-(void)loadDataFromAPI {

    [iService getJsonResponse:@"http://nsmith.nfshost.com/sf/contacts.json" success:^(NSDictionary *responseDict) {
        self.contacts = [responseDict valueForKey:@"contacts"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetResponse" object:self.contacts];
    }];
}

/**
 @return all contacts
 */

+ (NSDictionary *)searchInArray:(id)selectedItem searchItem:(NSString *)searchText {
    
    NSMutableArray * tempArray = [[[ContactManager shareInstance] contacts] mutableCopy];
    [tempArray removeObject:selectedItem];
    
    for (NSDictionary *dict in tempArray) {
        if ([[dict allValues] containsObject:searchText]) {
            return dict;
        }
    }
    return nil;
}

/**
 @return all search result
 */

+ (NSArray *)searchObjectsInArray:(NSString *)searchText {
    
    NSArray * tempArray = [[ContactManager shareInstance] getContacts];
    NSMutableArray *searchResult = [NSMutableArray new];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@", searchText];
    for (NSDictionary *dict in tempArray) {
         NSArray *aNames = [[dict allValues] filteredArrayUsingPredicate:predicate];
        if ([aNames count]) {
            [searchResult addObject:dict];
        }
    }
    return searchResult;
}

/**
 @param selectedItem is selected object from the list.
 @searchText is the selected item which been selected from the Object
 */

+ (NSArray *)contentArrayFromDictionary:(NSDictionary *)data {
    NSMutableArray *mutable = [NSMutableArray array];
    for (NSString *key in data.allKeys) {
        if([key hasSuffix:@"s"]) {
            [mutable addObjectsFromArray:[data valueForKey:key]];
        } else
            [mutable addObject:[data valueForKey:key]];
    }
    return mutable;
}

/**
 @param item is the individual object from the list.
 @return number of element in the dictionary.including array values of key
 */
+ (NSInteger)returnItemCounts:(NSDictionary *)item {
    for (NSString *key in item.allKeys) {
        if([key hasSuffix:@"s"]) {
            return [[item allKeys] count] + [[item valueForKey:key] count] - 1;
        }
    }
    return [[item allKeys] count];
}

@end
