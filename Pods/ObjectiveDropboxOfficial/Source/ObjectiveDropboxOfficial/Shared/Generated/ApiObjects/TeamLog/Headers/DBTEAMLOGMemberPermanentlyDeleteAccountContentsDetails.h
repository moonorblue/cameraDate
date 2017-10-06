///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MemberPermanentlyDeleteAccountContentsDetails` struct.
///
/// Permanently deleted contents of a removed team member account.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails : NSObject <DBSerializable, NSCopying>

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
/// The serialization class for the
/// `MemberPermanentlyDeleteAccountContentsDetails` struct.
///
@interface DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails`
/// instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails *)instance;

///
/// Deserializes `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails`
/// instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails` object.
///
+ (DBTEAMLOGMemberPermanentlyDeleteAccountContentsDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
