# Authentication Overview

Communication between Trados and apps is secured through multiple measures, ensuring that both the communication channel is tamper-proof and encrypted to protect against eavesdropping, but also to protect against unauthorized access.

Firstly, this is achieved by requiring that all endpoints on the app provide HTTPS using TLS 1.2, but also that Trados is available on HTTPS. This secures the communication both ways.

Secondly, the requests from Trados to the apps are authenticated with JWS Bearer tokens, that can be validated against a public key that is exposed in Trados Cloud Platform API and is cycled at regular intervals.