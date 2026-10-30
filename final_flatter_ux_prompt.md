MASTER PROMPT — PHARMACY AI MESSAGING APPLICATION

1. YOUR ROLE

Act as a Senior Software Architect, Product Manager, Flutter Solution Architect, UX/UI Architect, and Mobile Systems Engineer.

Your responsibility is to analyze the existing Pharmacy AI Agent backend and define a production-grade mobile application that allows customers to communicate with the existing Pharmacy AI Agent.

You must think in terms of:

* Product requirements and user experience.
* Clean architecture and separation of concerns.
* Reliable mobile-backend communication.
* Offline-first data management.
* Security and authentication.
* Scalable and maintainable Flutter architecture.
* Production readiness and testability.

Be precise, critical, and evidence-driven. Do not make assumptions about existing backend capabilities.

⸻

2. PROJECT CONTEXT

I already have an existing Pharmacy AI Agent backend built with FastAPI.

The backend contains the pharmacy-related intelligence and business logic.

The mobile application will be developed using Flutter and will support Android and iOS.

The objective is NOT to rebuild the Pharmacy AI Agent.

The objective is to build a dedicated mobile messaging client that communicates with the existing Pharmacy AI Agent through its backend interfaces.

The existing backend is the primary source of pharmacy intelligence and business decisions.

You must inspect the actual backend project before defining the mobile integration architecture.

Do not assume that an API, database table, endpoint, service, or feature exists unless you have verified it in the source code or database schema.

⸻

3. PRODUCT VISION AND SCOPE

The application is a:

Dedicated Messaging Client for the Pharmacy AI Agent.

It is NOT a complete pharmacy e-commerce application or a general pharmacy management application.

The customer’s primary and central experience must be a continuous conversation with one entity: the Pharmacy AI Agent representing the pharmacy.

The application should allow customers to:

* Communicate with the AI Agent through text.
* Send prescription images.
* Send medicine and product images.
* Send voice messages.
* Send supported files and attachments.
* Receive text and structured AI responses.
* Receive product information and product cards.
* Select options through interactive cards.
* View historical messages and previously exchanged media.
* Continue conversations without losing previous context.
* Receive notifications about new messages.
* Request human pharmacist assistance when needed.

The application must remain simple and conversation-centric.

Do not introduce unnecessary independent business screens such as:

* Product browsing catalog.
* Independent shopping experience.
* Independent cart management dashboard.
* Independent order management dashboard.
* Branch management screens.
* Inventory management screens.

Order-related information, product information, cart summaries, and order updates may be presented inside the conversation using backend-driven structured messages and cards.

A minimal profile, authentication, and settings experience is allowed when necessary for account management, security, and application operation.

⸻

4. HYBRID MESSAGING EXPERIENCE

The product must combine:

WhatsApp-inspired Messaging Experience + ChatGPT-style Rich AI Response Rendering.

Do not copy WhatsApp or ChatGPT branding, proprietary assets, or exact visual designs.

Use familiar messaging interaction patterns while creating a distinct pharmacy-focused experience.

4.1 WhatsApp-inspired conversation interface

The primary conversation interface should include:

* Incoming and outgoing message bubbles.
* Clear message timestamps.
* Date separators such as Today, Yesterday, and calendar dates.
* A persistent message composer.
* Attachment picker.
* Camera and gallery access.
* Voice message recording.
* Message sending indicators.
* Message retry controls.
* Scrollback and historical message loading.
* Smooth scrolling and appropriate keyboard behavior.
* Arabic RTL and English LTR support.

The customer must have one continuous conversation with the Pharmacy AI Agent rather than a list of multiple independent conversations.

4.2 ChatGPT-style rich response rendering

AI responses must not be limited to plain text.

The application must support structured and visually organized responses when appropriate, including:

* Headings and formatted text.
* Lists.
* Tables when useful and supported.
* Product cards.
* Product comparisons.
* Interactive choices.
* Confirmation cards.
* Cart summaries.
* Order status cards.
* Prescription-related structured responses.
* Warning and error messages.
* File and media attachments.

The rendering must be readable, consistent, and appropriate for mobile screens.

4.3 Pharmacy-specific components

Design reusable components for pharmacy-related information, such as:

* Product image.
* Product name.
* Strength and dosage form when supplied by the backend.
* Price and availability when supplied by the backend.
* Product quantity controls when supported.
* Add-to-cart actions when explicitly supported by the backend.
* Product comparison.
* Alternative product choices.
* Structured order summaries.

Flutter must display backend-provided information. It must never independently calculate pharmacy prices, product equivalence, availability, promotions, or business decisions.

⸻

5. BACKEND-DRIVEN INTERACTIVE CARDS

This is a core product requirement.

The backend must be able to request structured input from the customer.

Instead of forcing customers to type every answer, Flutter should display interactive components that allow customers to respond with a tap.

Examples include:

* Single-choice cards.
* Multiple-choice cards.
* Quick-reply buttons.
* Product selection cards.
* Product comparison cards.
* Confirmation cards.
* Quantity selectors.
* Structured forms when additional information is required.

Example conceptual response:

{
  "type": "choice",
  "selection_id": "delivery_method",
  "title": "Choose your preferred delivery method",
  "options": [
    {
      "id": "delivery",
      "label": "Home delivery"
    },
    {
      "id": "pickup",
      "label": "Branch pickup"
    }
  ]
}

This is an illustrative contract only. Do not assume the existing backend already implements it.

Requirements

1. The backend determines when customer input is required.
2. The backend provides the available options and the relevant data.
3. Flutter renders the appropriate interactive component.
4. When the customer selects an option, Flutter sends the corresponding structured selection identifier and required context to the backend.
5. Flutter must not independently interpret the business meaning of a selection.
6. The backend validates the selection and determines the next action.
7. Expired or invalid selections must be handled gracefully.
8. Repeated taps must not cause duplicate business actions.
9. Selected, submitted, expired, and disabled states must be visually distinguishable.
10. The interface must support accessibility and RTL/LTR layouts.

Use the simplest appropriate interaction:

* Quick replies for simple choices.
* Cards for visually distinguishable alternatives.
* Product cards for product selection.
* Forms only when multiple independent fields are genuinely necessary.

Do not force every interaction into a card.

⸻

6. ONE-TIME CUSTOMER REGISTRATION AND AUTHENTICATION

Registration is required when a customer uses the application for the first time.

The initial registration fields are:

1. Customer name.
2. Mobile number.
3. Full address.

Age or date of birth is not required unless the existing backend or a verified legal/business requirement establishes a genuine need.

Registration workflow

1. The customer opens the application for the first time.
2. The application displays the registration screen.
3. The customer enters their name, mobile number, and full address.
4. The mobile number is verified through the authentication mechanism supported by the backend.
5. Flutter submits the registration information through FastAPI.
6. FastAPI handles customer creation and persistence in the existing sales.customers table, or the appropriate verified backend mechanism.
7. The customer account is securely associated with the authentication identity.
8. The application initializes or retrieves the customer’s continuous conversation.
9. The customer is taken directly to the conversation.

The exact field names, database schema, registration endpoints, and authentication mechanism must be discovered through backend inspection.

Do not invent database columns or APIs.

Returning customer workflow

After successful registration and authentication:

* The customer should not be asked to register again.
* The application should restore the authenticated session securely.
* Every subsequent application launch should open the existing conversation directly.
* Previous messages should be available locally.
* The application should synchronize with the backend.
* New messages should be retrieved without requiring manual refresh.

If the authentication session expires, provide a secure re-authentication flow. Do not treat an expired session as a reason to create a duplicate customer account.

Provide the minimum required profile functionality to update customer information, especially the address and mobile number when permitted by the backend.

The initial registration requires one primary address. Do not introduce a complex multi-address management system unless the existing business requirements justify it.

⸻

7. LOCAL-FIRST / OFFLINE-FIRST ARCHITECTURE

This is a fundamental architectural requirement.

The application must maintain a persistent local copy of the customer’s conversation.

SQLite must be used as a persistent local database, not merely an in-memory cache.

Evaluate Drift as the preferred Flutter database abstraction and explain whether it is suitable for this project.

7.1 Local message persistence

* Persist messages in SQLite.
* Preserve messages across application restarts.
* Store message identifiers and server identifiers.
* Store timestamps and message ordering information.
* Store message type and structured payload.
* Store delivery and synchronization states.
* Support incremental historical loading.
* Support efficient querying and indexing.

The customer must be able to view previously synchronized messages while offline.

Do not claim that all historical media is available offline unless the media has actually been downloaded and stored locally.

7.2 Local media storage

Large binary media must not be stored directly inside SQLite.

Store media in the application’s private local storage.

SQLite should store:

* Media identifier.
* Local file path.
* Remote media reference.
* MIME type.
* File size.
* Upload/download status.
* Relevant metadata.
* Associated message identifier.

Handle media lifecycle, cleanup, and storage limits carefully.

7.3 Persistent Outbox Pattern

New outgoing messages must be saved locally before network submission.

Implement a persistent Outbox mechanism.

Requirements:

* Generate a unique client-side UUID for each outgoing message.
* Save the message in SQLite immediately.
* Mark it as pending.
* Attempt submission through the backend.
* Maintain pending messages across app restarts.
* Retry after network interruptions.
* Use controlled retry and backoff policies.
* Prevent duplicate message creation.
* Preserve the original message and attachment when an upload fails.
* Never silently discard pending messages.
* Expose retry and failure states to the customer.

The backend must support idempotent message submission or an equivalent mechanism to prevent duplicate messages.

7.4 Backend persistence

The backend must remain the authoritative source of truth.

Inspect the current backend and determine how to integrate durable server-side message persistence.

The intended architecture should support:

* PostgreSQL or the existing backend database for conversation and message metadata.
* Object storage or an appropriate existing media storage solution for binary attachments.
* Secure customer ownership and access control.
* Recovery of conversation history after changing devices or reinstalling the application, subject to backend retention and authentication policies.

Do not introduce a new database or object storage service without evaluating the existing infrastructure first.

7.5 Offline capabilities

When offline, the application should:

* Display locally available historical messages.
* Allow composing new messages.
* Persist new messages locally.
* Queue messages and attachments.
* Display pending status.
* Resume synchronization when connectivity returns.

Background execution is not guaranteed on Android or iOS.

Design synchronization so that it can resume when the application is opened or when the operating system grants background execution time.

⸻

8. MESSAGE SYNCHRONIZATION AND REAL-TIME COMMUNICATION

Design a reliable synchronization architecture between Flutter and FastAPI.

Evaluate the existing backend capabilities before choosing the communication mechanism.

The architecture should distinguish between:

* REST APIs for reliable submission, historical retrieval, and synchronization.
* WebSocket or another real-time mechanism for receiving new messages and events.
* Push notifications for background and terminated application scenarios.

WebSocket connectivity must not be treated as the only guarantee of message persistence.

Synchronization requirements

* Cursor-based incremental synchronization.
* Historical pagination.
* Message deduplication.
* Stable message ordering.
* Reconnection handling.
* Authentication renewal.
* Missing-message recovery.
* Synchronization after app restart.
* Synchronization after notification tap.
* Recovery after temporary network failures.

Define how the client knows which messages it has already synchronized.

Define how server-generated messages and client-generated messages are reconciled.

Do not assume that timestamps alone are sufficient for reliable ordering.

⸻

9. MESSAGE LIFECYCLE AND STATUS

Define an explicit message lifecycle.

Possible states include:

* Local Pending.
* Uploading.
* Submitted.
* Server Accepted.
* Delivered, only if the backend provides reliable delivery confirmation.
* Read, only if read receipts are actually supported.
* Failed.
* Expired, where applicable.

Clearly distinguish between:

* Message saved locally.
* Message accepted by the backend.
* Message delivered to another system or recipient.
* Message read by the recipient.

Do not display Delivered or Read indicators unless the backend provides the corresponding evidence.

Define the transitions, failure recovery, and UI representation of each state.

⸻

10. HISTORICAL MEDIA REUSE

Customers must be able to revisit previously exchanged images, prescriptions, audio messages, and files.

Where technically and securely supported, allow customers to reuse a previously uploaded image as a new message without uploading the same binary file again.

The preferred conceptual workflow is:

1. Customer selects an old media attachment.
2. Flutter references the existing media identifier.
3. Backend verifies customer ownership and authorization.
4. Backend associates the media with a new message.
5. The new message appears in the conversation.

If the media has been edited or transformed, treat it as a new binary upload.

Do not expose local file paths or allow unauthorized access to media belonging to other customers.

⸻

11. MEDIA AND ATTACHMENT EXPERIENCE

Support the following message types where the backend permits them:

* Text.
* Images.
* Prescription images.
* Voice messages.
* Audio attachments.
* Supported documents and files.
* Backend-generated media attachments.

Evaluate:

* Camera access.
* Gallery access.
* File picker.
* Microphone permissions.
* Image compression and resizing.
* Upload progress.
* Upload retry.
* File size limits.
* Supported MIME types.
* Media previews.
* Full-screen media viewing.
* Local media caching.
* Media cleanup.

Voice messages should have a familiar recording and playback experience.

Handle permission denial and unavailable hardware gracefully.

The backend must validate uploaded content and enforce file size and MIME-type restrictions.

Do not assume that every media format is supported by the existing backend.

⸻

12. LOCATION AND CUSTOMER ADDRESS

The application may request the customer’s location when it is relevant to a backend-supported pharmacy workflow.

Location is not continuous tracking.

Requirements:

* Request permission only when necessary.
* Retrieve location after explicit permission.
* Send coordinates to the backend when the workflow requires them.
* Do not independently select a pharmacy branch in Flutter.
* The backend remains responsible for branch selection and location-based business decisions.

Handle:

* Permission denied.
* Location services disabled.
* GPS unavailable.
* Timeout.
* Inaccurate location.
* Offline operation.

When location is unavailable, use the existing backend-supported fallback, such as the customer’s saved address or another supported address/branch selection flow.

Do not invent a location API or assume that a particular backend fallback exists. Verify it.

⸻

13. PUSH NOTIFICATIONS

Support notifications for new messages from the Pharmacy AI Agent.

Evaluate an appropriate push notification solution compatible with the existing backend and Android/iOS requirements.

Requirements:

* Foreground notifications.
* Background notifications.
* Terminated application notifications.
* Notification permission handling.
* Notification token registration and renewal.
* Secure association between device and customer account.
* Notification tap navigation to the conversation.
* Synchronization after opening a notification.
* Deduplication of messages already present locally.
* Appropriate privacy controls for notification previews.

Push notifications are a signal to synchronize. They must not be treated as the authoritative source of message content or history.

⸻

14. HUMAN PHARMACIST HANDOFF

The customer must have a clear way to request assistance from a human pharmacist when supported by the backend.

The system should support a smooth transition between the AI Agent and human assistance.

Requirements:

* A clear handoff action within the conversation.
* Preserve the existing conversation context.
* Inform the customer when a handoff has been accepted, if supported.
* Distinguish AI-generated messages from human pharmacist messages when the backend provides sender identity.
* Handle unavailable human assistance gracefully.
* Prevent Flutter from independently deciding when a clinical escalation is required.

The backend must determine and manage the handoff workflow.

⸻

15. MEDICATION SAFETY AND TRUST

This is a pharmacy application, so the interface must communicate information responsibly.

Flutter must not:

* Generate medical advice.
* Infer drug equivalence.
* Recommend substitutions independently.
* Modify prescriptions.
* Invent prices, strengths, availability, or dosage information.
* Interpret uncertain clinical data as confirmed information.

Display only the information returned by the backend.

Support appropriate warning, clarification, and escalation message types.

The backend must remain responsible for pharmacy logic, clinical rules, and pharmacist escalation policies.

Do not make the mobile UI imply that an AI-generated response is a verified pharmacist decision unless the backend explicitly identifies it as such.

⸻

16. THIN FLUTTER CLIENT — STRICT ARCHITECTURAL BOUNDARY

This is a non-negotiable architectural principle.

Flutter is responsible for:

* User interface.
* User interaction.
* Local persistence.
* Local media management.
* Authentication session handling.
* API communication.
* Synchronization.
* Outbox management.
* Message rendering.
* Push notification handling.
* Permission handling.
* Accessibility.

FastAPI remains responsible for:

* AI orchestration.
* Intent detection and routing.
* Pharmacy business logic.
* Product search.
* Drug and product equivalence.
* Inventory availability.
* Branch selection.
* Inventory allocation.
* Pricing.
* Promotions.
* Cart business rules.
* Checkout.
* Order creation.
* Pharmacy-specific validation.
* Clinical and pharmacist escalation decisions.

Flutter must not duplicate these responsibilities.

If a required business operation does not exist in the backend, identify it as a backend gap in the PRD. Do not silently implement it in Flutter.

⸻

17. API CONTRACT AND MESSAGE SCHEMA

The communication between Flutter and FastAPI must be explicitly defined.

Inspect the existing backend APIs, request/response models, authentication mechanisms, and message structures.

Identify:

* Existing endpoints.
* Existing request schemas.
* Existing response schemas.
* Existing message formats.
* Existing file upload mechanisms.
* Existing real-time communication mechanisms.
* Existing authentication and customer identity mechanisms.
* Existing error formats.
* Existing pagination and synchronization capabilities.

Do not assume these features exist.

Define the required contract for:

* Registration.
* Authentication.
* Conversation initialization/retrieval.
* Message submission.
* Message history retrieval.
* Incremental synchronization.
* Media upload and retrieval.
* Structured AI responses.
* Interactive selections.
* Push notification registration.
* Human handoff.

For each missing capability, distinguish:

1. Existing and verified.
2. Partially implemented.
3. Missing and required.
4. Not required for the agreed product scope.

The message schema should be extensible and versioned.

It must support multiple message types without requiring a Flutter application update every time a new supported backend-driven message type is introduced, where technically feasible.

Unknown message types must fail gracefully rather than crashing the conversation.

⸻

18. SECURITY AND PRIVACY

Design the application with production-grade security.

Consider:

* Secure authentication.
* Secure token storage.
* Token expiration and renewal.
* TLS for network communication.
* Customer-level authorization.
* Media ownership validation.
* Secure local database handling.
* Sensitive data protection.
* Logout behavior.
* Account recovery.
* Session revocation.
* Device registration.
* Notification privacy.
* Permission minimization.
* Secure logging and error reporting.

The backend must verify customer identity and ownership for every protected conversation, message, and media operation.

Never trust a customer_id supplied by the mobile client without backend authorization.

Define local data cleanup behavior on logout, including how pending messages are handled safely.

Do not store passwords or authentication secrets in plain text.

⸻

19. UX/UI DESIGN PRINCIPLES

The application should be simple and familiar.

The conversation is the main screen.

Prioritize:

* Minimal navigation.
* Clear visual hierarchy.
* Fast interactions.
* Readable message bubbles.
* Easy attachment access.
* Clear message states.
* Large, accessible touch targets.
* Appropriate loading and empty states.
* Graceful error recovery.
* Smooth scrolling.
* Good keyboard handling.
* Responsive layouts.
* Arabic RTL.
* English LTR.
* Light and dark themes.

Avoid unnecessary screens and complex navigation.

The application should feel like a dedicated messaging application, not an e-commerce platform.

⸻

20. ACCESSIBILITY AND LOCALIZATION

Support Arabic and English.

Requirements:

* Correct RTL and LTR layout behavior.
* Localized dates and numbers.
* Proper text alignment.
* Screen reader semantics.
* Scalable text.
* Adequate color contrast.
* Accessible interactive cards.
* Keyboard accessibility where applicable.
* Localization-ready architecture.

Do not assume that switching languages is only a matter of translating strings. Layout direction, dates, and number formatting must also be considered.

⸻

21. ERROR HANDLING AND RESILIENCE

Define consistent behavior for:

* No internet connection.
* Server unavailable.
* Authentication expired.
* Message submission failure.
* Media upload failure.
* Synchronization failure.
* Invalid backend response.
* Unknown message type.
* Expired interactive selection.
* Duplicate submission.
* Local database errors.
* Insufficient device storage.
* Permission denial.
* Push notification failure.

Every failure must have an appropriate recovery strategy.

The customer must not lose locally persisted messages because of temporary connectivity problems.

Do not hide failures that require customer action.

⸻

22. TECHNOLOGY EVALUATION

Do not select technologies simply because they are popular.

Evaluate and justify suitable choices for:

* Flutter architecture.
* State management.
* Navigation.
* Local database and migrations.
* HTTP communication.
* WebSocket communication.
* Media upload and download.
* Audio recording and playback.
* Image handling.
* Secure token storage.
* Push notifications.
* Background synchronization.
* Dependency injection.
* Logging and crash reporting.
* Testing.

Evaluate Drift for SQLite persistence.

Consider maintainability, ecosystem maturity, platform compatibility, resource consumption, and long-term support.

Do not add unnecessary packages or architectural complexity.

⸻

23. TESTING AND PRODUCTION READINESS

The final solution must have a comprehensive testing strategy.

Consider:

* Unit tests.
* Widget tests.
* Integration tests.
* API contract tests.
* Local database tests.
* Database migration tests.
* Outbox and retry tests.
* Synchronization tests.
* Duplicate submission tests.
* Authentication tests.
* Media upload tests.
* Offline and recovery tests.
* Push notification tests.
* Android device testing.
* iOS device testing.
* RTL/LTR tests.
* Accessibility tests.
* Security tests.
* Performance tests.

Define measurable acceptance criteria.

Do not consider the application production-ready merely because the main screens work.

⸻

24. MANDATORY DEVELOPMENT WORKFLOW

Development must be divided into explicit phases.

You are authorized to perform Phase 1 ONLY.

Do not proceed to Phase 2 or later without my explicit approval.

PHASE 1 — EXISTING BACKEND ANALYSIS AND PRODUCT REQUIREMENTS DOCUMENT

Your first task is to inspect the existing backend thoroughly.

Analyze:

* Project structure.
* FastAPI routes.
* Pydantic models.
* Services.
* Repositories.
* Dependency injection.
* Database connections and schemas.
* Customer registration and identity.
* Authentication.
* Conversation and message persistence.
* AI orchestration.
* Tool interfaces.
* Media handling.
* WebSocket or other real-time mechanisms.
* Existing notification capabilities.
* Error handling.
* Existing tests.
* Configuration and deployment assumptions.

Trace the actual flow of a customer interaction from API entry point through the relevant services and repositories.

Pay particular attention to the existing sales.customers table and determine how the agreed registration fields (name, mobile number, and full address) can be stored using the existing schema.

Do not modify the backend.

Do not create or modify Flutter code.

Do not create implementation files.

Phase 1 deliverables

Produce a comprehensive Product Requirements Document (PRD) containing:

1. Executive summary.
2. Product vision.
3. Agreed product scope and exclusions.
4. Target users and primary use cases.
5. Customer journey from first registration to recurring conversations.
6. Functional requirements.
7. Non-functional requirements.
8. Detailed messaging and interaction requirements.
9. Interactive card requirements.
10. Local-first and offline requirements.
11. Message lifecycle and synchronization requirements.
12. Media requirements.
13. Authentication and registration requirements.
14. Notification requirements.
15. Human pharmacist handoff requirements.
16. Security and privacy requirements.
17. Accessibility and localization requirements.
18. Verified backend capabilities.
19. Backend gaps and required changes.
20. API integration requirements.
21. Risks, assumptions, and unresolved decisions.
22. Acceptance criteria.
23. Recommended implementation priorities.

Include a clear backend capability matrix:

Capability	Existing	Partial	Missing	Evidence

Every conclusion about existing functionality must be supported by evidence from the actual project, such as file paths, class names, endpoint names, model names, or relevant code references.

Separate verified facts from assumptions and recommendations.

If something cannot be verified, explicitly say so.

Do not invent APIs, tables, or functionality.

At the end of Phase 1, provide:

* A complete PRD.
* A list of backend gaps.
* A list of architectural risks.
* A list of decisions that require my approval.
* A recommended next-phase plan.

STOP after Phase 1.

Wait for my explicit approval before proceeding.

PHASE 2 — UX/UI DESIGN

Only after approval.

Produce detailed screen specifications and visual design proposals.

Include representative visual mockups or prototypes where supported.

Cover:

* Registration.
* Main conversation.
* Message types.
* Interactive cards.
* Product cards.
* Prescription images.
* Voice messages.
* Media viewer.
* Error and offline states.
* Authentication recovery.
* Minimal profile/settings.

Provide a detailed interaction specification for every important component.

PHASE 3 — TECHNICAL ARCHITECTURE

Only after approval.

Define:

* Flutter project structure.
* Architectural layers.
* State management.
* Dependency injection.
* Local database schema.
* Local media storage.
* Outbox architecture.
* Synchronization architecture.
* Message state machine.
* API client architecture.
* Authentication lifecycle.
* Notification handling.
* Error handling.
* Testing architecture.

Provide architecture diagrams and data flow diagrams.

PHASE 4 — API CONTRACTS AND BACKEND INTEGRATION

Only after approval.

Define and validate the actual API contracts required by Flutter.

Identify backend modifications separately from mobile implementation.

Do not assume that proposed endpoints already exist.

PHASE 5 — TESTING STRATEGY

Only after approval.

Produce detailed test plans, scenarios, acceptance criteria, and test data requirements.

PHASE 6 — IMPLEMENTATION

Only after approval.

Implement the Flutter application incrementally.

Keep the backend/mobile boundary intact.

Do not generate the entire application in one uncontrolled step.

Use maintainable, production-quality code and test each major capability.

⸻

25. STRICT WORKING RULES

1. Inspect the existing backend before proposing integration details.
2. Never invent APIs, database fields, or existing functionality.
3. Do not duplicate pharmacy business logic in Flutter.
4. Do not start implementation before requirements and architecture are approved.
5. Do not skip phases.
6. Do not proceed automatically after completing a phase.
7. Ask for explicit approval before every phase transition.
8. Clearly distinguish facts, assumptions, recommendations, and unresolved questions.
9. Prefer simple and maintainable solutions over unnecessary complexity.
10. Treat data integrity, security, and offline reliability as core requirements.
11. Explain architectural trade-offs and why a decision is recommended.
12. If a requirement conflicts with the actual backend, report the conflict instead of silently changing the requirement.
13. Do not modify existing backend files during Phase 1.
14. Do not generate Flutter implementation files during Phase 1.
15. Do not interpret this prompt as permission to start all phases.

⸻

26. YOUR FIRST TASK

Start with Phase 1 — Existing Backend Analysis and Product Requirements Document.

Inspect the actual project repository and its relevant source files.

Build an accurate understanding of the current backend before recommending the mobile application architecture.

Deliver the complete Phase 1 PRD and supporting analysis.

Do not write Flutter code.

Do not modify the backend.

Do not proceed to Phase 2.

Wait for my explicit approval.
