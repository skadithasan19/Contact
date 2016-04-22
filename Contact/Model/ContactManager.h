//
//  ContactManager.h
//  Contact
//
//  Created by Md Adit Hasan on 4/22/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactManager : NSObject

/**
 @return singleTon instance
 */
+ (ContactManager *)shareInstance;

/**
 Load contacts from End point
 */
- (void)loadDataFromAPI;

/**
 @return all contacts
 */
- (NSArray *)getContacts;

/**
 @param selectedItem is selected object from the list.
 @searchText is the selected item which been selected from the Object
 */
+ (NSDictionary *)searchInArray:(id)selectedItem searchItem:(NSString *)searchText;

/**
 @param data is selected object from the list.
 @return array of values from the dictionary. including array values of key
 */
+ (NSArray *)contentArrayFromDictionary:(NSDictionary *)data ;

/**
 @param item is the individual object from the list.
 @return number of element in the dictionary.including array values of key
 */

+ (NSInteger)returnItemCounts:(NSDictionary *)item;

@end
