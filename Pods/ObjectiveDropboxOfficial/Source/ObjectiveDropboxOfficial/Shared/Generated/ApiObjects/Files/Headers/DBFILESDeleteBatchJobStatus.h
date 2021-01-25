///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESDeleteBatchError;
@class DBFILESDeleteBatchJobStatus;
@class DBFILESDeleteBatchResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `DeleteBatchJobStatus` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESDeleteBatchJobStatus : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBFILESDeleteBatchJobStatusTag` enum type represents the possible tag
/// states with which the `DBFILESDeleteBatchJobStatus` union can exist.
typedef NS_ENUM(NSInteger, DBFILESDeleteBatchJobStatusTag) {
  /// The asynchronous job is still in progress.
  DBFILESDeleteBatchJobStatusInProgress,

  /// The batch delete has finished.
  DBFILESDeleteBatchJobStatusComplete,

  /// The batch delete has failed.
  DBFILESDeleteBatchJobStatusFailed,

  /// (no description).
  DBFILESDeleteBatchJobStatusOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBFILESDeleteBatchJobStatusTag tag;

/// The batch delete has finished. @note Ensure the `isComplete` method returns
/// true before accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESDeleteBatchResult *complete;

/// The batch delete has failed. @note Ensure the `isFailed` method returns true
/// before accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESDeleteBatchError *failed;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "in_progress".
///
/// Description of the "in_progress" tag state: The asynchronous job is still in
/// progress.
///
/// @return An initialized instance.
///
- (instancetype)initWithInProgress;

///
/// Initializes union class with tag state of "complete".
///
/// Description of the "complete" tag state: The batch delete has finished.
///
/// @param complete The batch delete has finished.
///
/// @return An initialized instance.
///
- (instancetype)initWithComplete:(DBFILESDeleteBatchResult *)complete;

///
/// Initializes union class with tag state of "failed".
///
/// Description of the "failed" tag state: The batch delete has failed.
///
/// @param failed The batch delete has failed.
///
/// @return An initialized instance.
///
- (instancetype)initWithFailed:(DBFILESDeleteBatchError *)failed;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "in_progress".
///
/// @return Whether the union's current tag state has value "in_progress".
///
- (BOOL)isInProgress;

///
/// Retrieves whether the union's current tag state has value "complete".
///
/// @note Call this method and ensure it returns true before accessing the
/// `complete` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "complete".
///
- (BOOL)isComplete;

///
/// Retrieves whether the union's current tag state has value "failed".
///
/// @note Call this method and ensure it returns true before accessing the
/// `failed` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "failed".
///
- (BOOL)isFailed;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBFILESDeleteBatchJobStatus` union.
///
@interface DBFILESDeleteBatchJobStatusSerializer : NSObject

///
/// Serializes `DBFILESDeleteBatchJobStatus` instances.
///
/// @param instance An instance of the `DBFILESDeleteBatchJobStatus` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESDeleteBatchJobStatus` API object.
///
+ (nullable NSDictionary *)serialize:(DBFILESDeleteBatchJobStatus *)instance;

///
/// Deserializes `DBFILESDeleteBatchJobStatus` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESDeleteBatchJobStatus` API object.
///
/// @return An instantiation of the `DBFILESDeleteBatchJobStatus` object.
///
+ (DBFILESDeleteBatchJobStatus *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
