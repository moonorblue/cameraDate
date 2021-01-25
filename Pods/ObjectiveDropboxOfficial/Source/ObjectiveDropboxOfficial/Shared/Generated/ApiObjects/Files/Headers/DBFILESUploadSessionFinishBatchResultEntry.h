///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBFILESFileMetadata;
@class DBFILESUploadSessionFinishBatchResultEntry;
@class DBFILESUploadSessionFinishError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `UploadSessionFinishBatchResultEntry` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILESUploadSessionFinishBatchResultEntry : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBFILESUploadSessionFinishBatchResultEntryTag` enum type represents the
/// possible tag states with which the
/// `DBFILESUploadSessionFinishBatchResultEntry` union can exist.
typedef NS_ENUM(NSInteger, DBFILESUploadSessionFinishBatchResultEntryTag) {
  /// (no description).
  DBFILESUploadSessionFinishBatchResultEntrySuccess,

  /// (no description).
  DBFILESUploadSessionFinishBatchResultEntryFailure,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBFILESUploadSessionFinishBatchResultEntryTag tag;

/// (no description). @note Ensure the `isSuccess` method returns true before
/// accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESFileMetadata *success;

/// (no description). @note Ensure the `isFailure` method returns true before
/// accessing, otherwise a runtime exception will be raised.
@property (nonatomic, readonly) DBFILESUploadSessionFinishError *failure;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "success".
///
/// @param success (no description).
///
/// @return An initialized instance.
///
- (instancetype)initWithSuccess:(DBFILESFileMetadata *)success;

///
/// Initializes union class with tag state of "failure".
///
/// @param failure (no description).
///
/// @return An initialized instance.
///
- (instancetype)initWithFailure:(DBFILESUploadSessionFinishError *)failure;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "success".
///
/// @note Call this method and ensure it returns true before accessing the
/// `success` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "success".
///
- (BOOL)isSuccess;

///
/// Retrieves whether the union's current tag state has value "failure".
///
/// @note Call this method and ensure it returns true before accessing the
/// `failure` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "failure".
///
- (BOOL)isFailure;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBFILESUploadSessionFinishBatchResultEntry`
/// union.
///
@interface DBFILESUploadSessionFinishBatchResultEntrySerializer : NSObject

///
/// Serializes `DBFILESUploadSessionFinishBatchResultEntry` instances.
///
/// @param instance An instance of the
/// `DBFILESUploadSessionFinishBatchResultEntry` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILESUploadSessionFinishBatchResultEntry` API object.
///
+ (nullable NSDictionary *)serialize:(DBFILESUploadSessionFinishBatchResultEntry *)instance;

///
/// Deserializes `DBFILESUploadSessionFinishBatchResultEntry` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILESUploadSessionFinishBatchResultEntry` API object.
///
/// @return An instantiation of the `DBFILESUploadSessionFinishBatchResultEntry`
/// object.
///
+ (DBFILESUploadSessionFinishBatchResultEntry *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
