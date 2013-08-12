//
//  ARProfileManager.h
//  ARUXFLIP
//
//  Created by Daniel Koch on 4/11/13.
//
//

#import <Foundation/Foundation.h>

typedef enum { ARGenderMale, ARGenderFemale, ARGenderNA } ARGender;

/**
 * Manages the Artisan Profiling and Segmentation capability. This includes:
 *
 * - Setting user information for use in targeting experiments and personalizing content.
 * - Collecting user information for analytics reporting and segmentation.
 *
 * ARProfileManager is a singleton that is automatically initialized when your app starts.  Use ARProfileManager to manage the personalization profile for the current user from app inception to completion.
 */

@interface ARProfileManager : NSObject

/** Specify a User ID for the current user.
 *
 * Use this method to connect the current user of this app with an ID in your user management system.  For example, if your user management system has a user whose ID is 'ABC123456' and that user logs into this app, you can use this method to pass that ID to Artisan as part of the personalization profile for this user.  You can then use this ID to trace the data collected by Artisan directly to an existing user in your system.
 *
 * @param userId The ID string to associate with the current user.
 */

+(void)setUserId:(NSString *)userId;


/** Specify the age for the current user.
 *
 * This information is added to the personalization profile of the current user for segmentation, targeting, and reporting purposes.
 *
 * @param age The age of the current user.
 */

+(void)setUserAge:(NSNumber*)age;


/** Specify the address for the current user.
 *
 * This information is added to the personalization profile of the current user for segmentation, targeting, and reporting purposes.  Artisan will automatically convert this value to a latitude and longitude coordinate.
 *
 * @param address The address of the current user.  This address needs to be in CLGeocoder format.  Unrecognized or unparseable address strings will automatically be converted to 0°N / 0°E.
 *
 */

+(void)setUserAddress:(NSString *)address;


/** Specify the gender of the current user.
 *
 * This information is added to the personalization profile of the current user for segmentation, targeting, and reporting purposes.
 *
 * @param gender The gender of the current user.  Possible values for ARGender include ARGenderMale, ARGenderFemale, and ARGenderNA.
 *
 */

+(void)setGender:(ARGender)gender;


/** Register a custom profile variable for this user.
 *
 * This custom variable will be included in this user's personalization profile, and can be used for segmentation, targeting, and reporting purposes.
 *
 * Once registered, the value for this variable can be set using setValue:forVariable:.  The default value is nil.
 *
 * @param variableName Name of the variable to register for the current user.  Valid characters for this name include [0-9],[a-z],[A-Z], -, and _.  Any other characters will automatically be stripped out.
 */

+(void)registerProfileVariable:(NSString *)variableName;


/** Register a custom profile variable for this user and set the initial value.
 *
 * This custom variable will be included in this user's personalization profile, and can be used for segmentation, targeting, and reporting purposes.
 *
 * Once registered, the value for this variable can be changed via setValue:forVariable:.
 *
 * @param variableName  Name of the variable to register for the current user.  Valid characters for this name include [0-9],[a-z],[A-Z], -, and _.  Any other characters will automatically be stripped out.
 *
 * @param value Initial value for the variable.
 */

+(void)registerProfileVariable:(NSString *)variableName withValue:(NSString *)value;


/** Set or update the value associated with a custom profile variable.
 *
 * This new value will be used as part of this user's personalization profile, and will be used from this pount forward for segmentation, targeting, and reporting purposes.
 *
 * @param value Value to use for the given variable.
 *
 * @param variableName Variable to which this value should be assigned.
 */

+(void)setValue:(NSString *)value forVariable:(NSString *)variableName;

/** Specify whether to submit user profile information to Artisan Analytics.
 *
 * The user profile information collected via setUserId:, setUserAge:, setUserAddress:, setGender, and setValue:forVariable: is sent by default to Artisan Analytics to enrich the experiment results.  Use this API call to deactivate (or reactivate) collection of this data.
 *
 * If profile data is not enabled for analytics collection, it can still be used to target experiments to specific user segments.
 *
 * @param enabled Whether to enable collection of user profile data by Artisan Analytics.
 */

+(void)enableProfileAnalytics:(BOOL)enabled;

/** Clear out all previously specified profile information.
 *
 * Use this method to clear out all data previously specified for the current user, including any data set via setUserId:, setUserAge:, setUserAddress:, setGender:, setUserAddress:, and setValue:forVariable:.
 *
 */

+(void)clearProfile;

@end
