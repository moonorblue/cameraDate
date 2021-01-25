///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGFileRollbackChangesDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `FileRollbackChangesDetails` struct.
///
/// Rolled back file change location changes.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGFileRollbackChangesDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `FileRollbackChangesDetails` struct.
///
@interface DBTEAMLOGFileRollbackChangesDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGFileRollbackChangesDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGFileRollbackChangesDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGFileRollbackChangesDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGFileRollbackChangesDetails *)instance;

///
/// Deserializes `DBTEAMLOGFileRollbackChangesDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGFileRollbackChangesDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGFileRollbackChangesDetails`
/// object.
///
+ (DBTEAMLOGFileRollbackChangesDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
