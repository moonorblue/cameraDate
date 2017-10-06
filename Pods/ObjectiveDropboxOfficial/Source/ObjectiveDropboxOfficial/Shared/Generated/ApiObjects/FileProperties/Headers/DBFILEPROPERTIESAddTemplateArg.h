///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBFILEPROPERTIESPropertyGroupTemplate.h"
#import "DBSerializableProtocol.h"

@class DBFILEPROPERTIESAddTemplateArg;
@class DBFILEPROPERTIESPropertyFieldTemplate;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `AddTemplateArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBFILEPROPERTIESAddTemplateArg : DBFILEPROPERTIESPropertyGroupTemplate <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param name Display name for the template. Template names can be up to 256
/// bytes.
/// @param description_ Description for the template. Template descriptions can
/// be up to 1024 bytes.
/// @param fields Definitions of the property fields associated with this
/// template. There can be up to 32 properties in a single template.
///
/// @return An initialized instance.
///
- (instancetype)initWithName:(NSString *)name
                description_:(NSString *)description_
                      fields:(NSArray<DBFILEPROPERTIESPropertyFieldTemplate *> *)fields;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `AddTemplateArg` struct.
///
@interface DBFILEPROPERTIESAddTemplateArgSerializer : NSObject

///
/// Serializes `DBFILEPROPERTIESAddTemplateArg` instances.
///
/// @param instance An instance of the `DBFILEPROPERTIESAddTemplateArg` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBFILEPROPERTIESAddTemplateArg` API object.
///
+ (nullable NSDictionary *)serialize:(DBFILEPROPERTIESAddTemplateArg *)instance;

///
/// Deserializes `DBFILEPROPERTIESAddTemplateArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBFILEPROPERTIESAddTemplateArg` API object.
///
/// @return An instantiation of the `DBFILEPROPERTIESAddTemplateArg` object.
///
+ (DBFILEPROPERTIESAddTemplateArg *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
