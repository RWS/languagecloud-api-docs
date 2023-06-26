# Welcome to the BCM .NET client API documentation

## [BCM .NET Client API Reference](BCM/API.md)
API reference generated from the code of the  BCM .NET Client.

## [BCM .NET Client API Samples](BCM/samples.md)
Samples documenting some usages of the BCM .NET Client.

## Knowledge Base

#### DateTime serialization
The official format for DateTime serialization is `yyyy-MM-dd'T'HH:mm:ss.fff'Z'`. The BCM supports both this format and the default .NET DateTime serialization format `MM/dd/yyyy HH:mm:ss`

#### Unrecognized Token deserialization
Unrecognized Token objects in the serialized BCM are deserialized into a Token of type Word. E.g.: a new type of Token is introduced in the BCM, but an older client, who doesn't recognized this new type of Token, tries to deserialize it.

### Unrecognized MarkupData deserialization
Unrecognized MarkupData objects in the serialized BCM are deserialized into a MarkupData of type UnknownMarkupData. This is to preserve the data of newly introduced MarkupData objects when deserializing BCM using older clients. Elements of type UnknownMarkupData should be ignored when manipulating BCM in memory.