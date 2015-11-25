# CrowdControl-iOS

The iOS version of the Crowd Control app.

- [Andorid](https://github.com/Deaboy/CrowdControl-Android)
- [Parse cloud code](https://github.com/Deaboy/CrowdControl-Parse)
- [Senior design documents](https://github.com/Deaboy/CrowdControl-SeniorDesign)

## Documentation

To build the documentation, follow these steps:

1. Install Jazzy by cloning the open source repo and following the instructions on [https://github.com/Realm/jazzy](https://github.com/Realm/jazzy)
2. CD into the `<REPO ROOT>/Crowd Control` directory (where the .xcodeproj is located)
3. Run the following command:

   jazzy -c --swift-version 2.1 --min-acl internal 

Be careful not to commit the generated documents! The generated files will be placed in a directory called `docs`.

## Copyright

The code and resources in this repository are the sole proprerty of Johnathan Ackerman, Daniel Andrus, Charles Bonn, Evan Hammer, and Joseph Mowry. All rights reserved.

