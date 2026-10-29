MASTER PROJECT PROMPT

Production-Ready WhatsApp-Like Pharmacy AI Messaging Application

1. YOUR ROLE

Act as a Principal Flutter Architect, Senior Mobile Application Engineer, Backend Integration Architect, and UX Reverse Engineering Specialist.

Your mission is to analyze, architect, design, and eventually implement a production-grade Flutter mobile application that recreates the core functionality, interaction patterns, and user experience of WhatsApp.

The application will be used by customers to communicate with an existing Pharmacy AI Agent.

This is not a basic messaging application or a UI prototype.

The objective is to deliver a complete, reliable, secure, scalable, and production-ready messaging application for Android and iOS.

⸻

2. CORE PRODUCT VISION

Build a dedicated pharmacy messaging application that provides a WhatsApp-like customer experience.

Customers must be able to interact with the Pharmacy AI Agent through multiple communication methods:

* Text messages.
* Image messages.
* Camera capture.
* Voice messages.
* Audio playback.
* Location sharing.
* Interactive camera functionality.
* Other commonly supported messaging media where technically appropriate.

The application should feel familiar to WhatsApp users.

Study WhatsApp’s publicly observable functionality and interaction patterns, and independently reproduce its relevant features.

Do not copy proprietary source code, private protocols, branding, or copyrighted assets.

Use original implementation and pharmacy-specific branding.

⸻

3. MOST IMPORTANT ARCHITECTURAL PRINCIPLE: THIN CLIENT

This is a mandatory architectural constraint.

The Flutter application must operate exclusively as a communication gateway between the customer and my existing backend.

Think of it as a sophisticated messaging terminal.

The application is responsible ONLY for:

1. Rendering the user interface.
2. Capturing user input.
3. Accessing device capabilities.
4. Sending messages and media to the backend.
5. Receiving backend responses.
6. Displaying messages and media.
7. Managing temporary presentation states.
8. Maintaining the local messaging experience.

The Flutter application MUST NOT implement:

* AI logic.
* LLM integrations.
* Grok API calls.
* AI orchestration.
* Tool selection.
* Product search.
* Product recommendations.
* Inventory calculations.
* Branch selection.
* Branch database connections.
* Cart calculations.
* Order processing.
* Pharmacy business rules.

All intelligence, decision-making, orchestration, and business logic must remain exclusively in the existing backend.

The existing backend already contains:

* FastAPI.
* AI Agent.
* Grok integration.
* Orchestrator.
* Tools.
* Services.
* Repositories.
* Database integrations.
* Pharmacy business logic.

Do not redesign or replace this architecture.

The mobile application must integrate with it through documented API endpoints and real-time communication channels.

Architectural rule: Flutter transports data; the backend understands and processes data.

⸻

4. WHATSAPP FUNCTIONAL RECONSTRUCTION

Study WhatsApp’s publicly observable user experience and reproduce the relevant functionality independently.

Analyze and implement the following:

Conversation Management

* Chat list screen.
* Individual conversation screen.
* Conversation history.
* Message timestamps.
* Message grouping.
* Message bubbles.
* Reply to messages.
* Quoted messages.
* Message status indicators.
* Sending and receiving states.
* Loading indicators.
* Error states.
* Message retry.
* Automatic scrolling.
* Conversation pagination.

Message Composer

Create a familiar messaging composer with:

* Text input.
* Attachment button.
* Camera button.
* Gallery button.
* Microphone button.
* Location sharing button.
* Send button.

The composer should adapt intelligently to the user’s current interaction.

Message Status

Support appropriate message states:

* Pending.
* Uploading.
* Sent.
* Delivered.
* Read, if the backend supports read acknowledgments.
* Failed.

Do not invent delivery or read confirmations when the backend has not confirmed them.

Media Viewer

Implement:

* Full-screen image viewer.
* Image previews.
* Audio player.
* Voice message waveform.
* Download and upload progress.
* Media loading placeholders.
* Media error handling.

⸻

5. MULTIMODAL COMMUNICATION

A. Text Messages

* Send and receive text messages.
* Support Arabic RTL.
* Support English LTR.
* Handle mixed Arabic and English content.
* Support long messages.
* Preserve message ordering.

B. Image Messages

* Select images from the device gallery.
* Capture images directly using the camera.
* Preview images before sending.
* Support image compression where appropriate.
* Upload images reliably.
* Display received images.
* Provide full-screen image viewing.

C. Voice Messages

* Record audio through the microphone.
* Support recording cancellation.
* Display recording duration.
* Provide waveform visualization.
* Upload voice recordings.
* Play received audio.
* Support playback controls.

The application must transmit the original audio file and relevant metadata to the backend.

Audio transcription and interpretation are backend responsibilities.

D. Location Sharing

* Obtain current GPS coordinates.
* Allow sharing the current location.
* Allow selecting a location on a map.
* Display shared locations.
* Support opening locations in an appropriate map application.

E. Camera Functionality

Support direct camera capture from the conversation.

Also design an extensible camera mode that can eventually support AI-powered visual interactions.

For example:

A customer points the camera at a pharmacy product, captures or shares an image, and the backend AI Agent identifies and processes the product.

Important:

Flutter only captures and transmits images or other supported visual input.

Image recognition, product identification, and AI interpretation must remain backend responsibilities.

⸻

6. CRITICAL REQUIREMENT: AUTOMATIC CUSTOMER GEOLOCATION

This is one of the most important requirements of the application.

The application must automatically attempt to obtain the customer’s current geographic location when launched.

The purpose is to eliminate the need for customers to manually describe their location for pharmacy branch identification.

Location Workflow

When the application launches:

1. Initialize the application.
2. Restore or establish the customer session.
3. Check the device’s location permission.
4. If permission is required, request it with a clear explanation.
5. If permission is granted, retrieve the current GPS coordinates.
6. Send the coordinates to the existing FastAPI backend.
7. Wait for the backend to resolve the appropriate pharmacy branch.
8. Receive the branch-resolution result.
9. Establish or restore the conversation.
10. Display the messaging interface.

Location Data

Transmit the following information when available:

* Latitude.
* Longitude.
* GPS accuracy in meters.
* Location timestamp.
* Relevant session identifier.
* Authentication context.

Backend Responsibilities

The backend must exclusively handle:

1. Receiving the coordinates.
2. Validating the location information.
3. Using the existing PostgreSQL/PostGIS GIS implementation.
4. Identifying the nearest pharmacy branches.
5. Executing existing branch-selection rules.
6. Establishing the appropriate branch database connection.
7. Associating the customer session with the selected branch.
8. Returning the branch-resolution status.

Flutter MUST NOT:

* Calculate distances.
* Query pharmacy branches.
* Select the nearest branch.
* Implement PostGIS.
* Contain geographic business rules.
* Establish branch database connections.

The existing backend remains the single source of truth.

Permission Handling

Implement proper handling for:

* First-time permission requests.
* Permission already granted.
* Permission denied.
* Permanently denied permission.
* GPS disabled.
* Location services unavailable.
* Inaccurate coordinates.
* Location timeout.
* Network failure.
* Backend failure.

Use foreground location access only.

Background location permission is NOT required.

Do not repeatedly display permission dialogs.

Important Failure Behavior

The customer must NOT be prevented from accessing the chat simply because GPS is unavailable.

If location access fails or is denied:

* Continue with the messaging experience.
* Do not repeatedly request permission.
* Do not implement branch selection inside Flutter.
* Allow the existing AI Agent to request the customer’s address through its existing conversation workflow.

Do not create a duplicate address-collection process inside the mobile application.

Location Refresh

Do not continuously transmit GPS coordinates.

Retrieve location at application startup and refresh it only when necessary.

Do not automatically change the active branch during an ongoing conversation merely because the customer moves geographically.

Any branch reassignment must be authorized and managed by the backend.

⸻

7. GPS LOCATION IS NOT DELIVERY ADDRESS

This distinction is mandatory.

There are two separate concepts:

Customer GPS Location

Used for automatic identification of the nearest pharmacy branch.

Customer Delivery Address

Collected and confirmed through the existing AI Agent conversation.

The customer’s current physical location must never automatically be treated as their delivery address.

For example:

A customer may be physically located at work but request delivery to their home.

The AI Agent remains responsible for requesting and confirming the delivery address.

⸻

8. BACKEND COMMUNICATION ARCHITECTURE

The application must communicate with the existing FastAPI backend.

Do not introduce an external chat provider.

REST API

Use REST endpoints for:

* Authentication.
* Session initialization.
* Text message submission where appropriate.
* Media uploads.
* Location submission.
* Conversation history retrieval.
* Media retrieval.

WebSocket

Use WebSocket for real-time communication where appropriate.

Support:

* Incoming messages.
* Outgoing messages.
* Backend processing events.
* Message acknowledgments.
* Connection status.
* Reconnection.
* Error notifications.

Media Upload Strategy

Do not send large image or audio files as Base64 inside ordinary JSON requests.

Prefer multipart/form-data or another appropriately designed upload mechanism.

Use WebSocket for real-time events and messaging coordination rather than unnecessarily transmitting large binary media through it.

API Contract

Design a consistent message model.

Every message should support appropriate fields such as:

* message_id.
* conversation_id.
* type.
* content or media reference.
* timestamp.
* metadata.
* status.

Do not assume the existing backend endpoint names or payload structures.

Propose a complete API contract and document it before implementation.

All API endpoints must be configurable through a centralized configuration layer.

⸻

9. PRODUCTION-READY ENGINEERING REQUIREMENTS

The application must be engineered for real customers and production deployment.

Consider:

Reliability

* Network interruptions.
* WebSocket disconnections.
* Automatic reconnection.
* Controlled retry with exponential backoff.
* Duplicate message prevention.
* Idempotency.
* Failed uploads.
* Interrupted uploads.
* Message ordering.
* Session restoration.

Security

* HTTPS/WSS only.
* Secure authentication.
* Secure token storage.
* No API keys embedded in Flutter.
* No direct Grok access from the application.
* Input validation.
* Secure media handling.
* Permission management.
* Protection of customer location information.
* Minimal retention of sensitive data.

Performance

* Efficient media compression.
* Memory management.
* Battery efficiency.
* Large conversation histories.
* Lazy loading.
* Pagination.
* Efficient image rendering.
* Proper disposal of camera and audio resources.

Maintainability

* Strong typing.
* Clear interfaces.
* Separation of concerns.
* Dependency injection.
* Reusable components.
* Centralized error handling.
* Structured logging.
* Unit tests.
* Widget tests.
* Integration tests.

⸻

10. TECHNOLOGY STACK

Use:

* Flutter.
* Dart.
* Android.
* iOS.
* FastAPI backend integration.
* REST API.
* WebSocket.
* Secure local token storage.
* Appropriate camera, audio, image, and location packages.

Choose suitable Flutter packages based on current stability, maintenance, compatibility, and production readiness.

Do not introduce unnecessary dependencies.

Explain significant technology choices.

⸻

11. USER EXPERIENCE AND DESIGN

The application should provide a polished messaging experience inspired by WhatsApp.

However, use original branding and visual assets.

Requirements:

* Clean and modern interface.
* Familiar messaging interactions.
* Responsive layouts.
* Smooth animations.
* Arabic as the primary language.
* Full RTL support.
* English support.
* Accessible controls.
* Appropriate light and dark themes.
* Consistent typography.
* Clear permission explanations.
* Clear upload and connection indicators.

The customer should feel that they are using a familiar messaging application rather than a complicated pharmacy system.

⸻

12. PROJECT STRUCTURE AND ARCHITECTURE

Propose a maintainable, feature-oriented Flutter project structure.

Separate:

* Presentation.
* Application.
* Domain.
* Data.
* API communication.
* WebSocket management.
* Media handling.
* Device capabilities.
* Authentication.
* Location management.
* Configuration.
* Error handling.

Keep the UI independent of backend implementation details.

The backend API integration must be replaceable without rewriting the presentation layer.

⸻

13. DEVELOPMENT METHODOLOGY

Do NOT generate the entire project in one unstructured response.

Work in clearly defined phases.

Phase 1 — Product Analysis

Produce:

* Product specification.
* Functional requirements.
* Non-functional requirements.
* User journeys.
* Screen inventory.
* Feature specifications.
* Edge cases.
* Acceptance criteria.

Phase 2 — UX/UI Design

Produce:

* Screen designs.
* Navigation flow.
* Conversation interaction flow.
* Attachment interaction flow.
* Camera and audio flows.
* Location permission flow.
* Loading and error states.

Phase 3 — Architecture

Produce:

* High-level architecture.
* Component responsibilities.
* Project structure.
* Dependency strategy.
* State management strategy.
* Security architecture.
* Offline and reconnection strategy.

Phase 4 — Backend API Contract

Produce:

* REST endpoint definitions.
* WebSocket event definitions.
* Message schemas.
* Media upload contracts.
* Authentication contracts.
* Location submission contracts.
* Error response schemas.

Phase 5 — Flutter Foundation

Build the application foundation, configuration, dependency injection, navigation, and API integration.

Phase 6 — Messaging

Implement text conversations, message history, message states, and real-time communication.

Phase 7 — Images and Camera

Implement gallery selection, camera capture, previews, and image uploads.

Phase 8 — Voice

Implement voice recording, playback, waveform visualization, and upload.

Phase 9 — Location

Implement automatic GPS acquisition, permission handling, backend transmission, and failure handling.

Phase 10 — Reliability and Security

Implement reconnection, idempotency, error handling, secure storage, and performance improvements.

Phase 11 — Testing

Perform comprehensive testing across Android and iOS.

Phase 12 — Production Release

Prepare:

* Release builds.
* App signing.
* Application configuration.
* Privacy disclosures.
* Google Play submission.
* Apple App Store submission.

⸻

14. STRICT EXECUTION RULES

These instructions are mandatory:

1. Do not skip architectural analysis.
2. Do not start coding before completing and reviewing the specifications.
3. Do not invent backend capabilities.
4. Clearly distinguish existing backend functionality from proposed additions.
5. Do not modify the existing AI Agent or its business logic.
6. Do not put pharmacy business rules inside Flutter.
7. Do not expose backend credentials.
8. Do not overengineer the application.
9. Prefer simple, maintainable, production-grade solutions.
10. Document all integration assumptions.
11. Identify missing backend capabilities explicitly.
12. Ask focused questions only when essential information is missing.
13. Provide complete, executable code during implementation phases.
14. Include appropriate tests.
15. Never claim production readiness without verification.

⸻

15. FIRST TASK — START WITH PHASE 1 ONLY

Begin by analyzing the complete product requirements.

Deliver:

1. A detailed Product Requirements Document (PRD).
2. Complete functional specification.
3. User journeys.
4. Screen inventory.
5. WhatsApp feature-to-feature mapping.
6. Automatic geolocation workflow.
7. Thin Client architectural constraints.
8. Production edge cases.
9. Acceptance criteria.
10. Identified assumptions and open questions.

Do NOT write Flutter code yet.

Do NOT proceed to Phase 2 without reviewing and approving Phase 1.

The final objective is a reliable, production-grade Flutter messaging application that recreates the relevant WhatsApp user experience while remaining a thin communication gateway to my existing Pharmacy AI Agent backend.
