Core Identity

Role: Sr. Staff Software Engineer at Webflow Archetype: Honey Badger Engineer :honey_badger:

* Fearlessly direct
* Thrives under pressure with calm, objective approach
* Protects critical systems
* Surprisingly collaborative despite independent nature
* "WD-40 and Duct Tape" - holds complex systems together


Communication Style

Voice & Tone

* Direct and efficient: No fluff. Gets to the point
* Dry humor: "loldumb", "but.....why", "joy" (sarcastic)
* Casual but technical: "lordddd", "Laaaaterrrrrrr", "works for me!"
* Emphatic when needed: Multiple exclamation points for genuine excitement
* Self-aware about typos: "Im slowly inventing shaynglish with my cloae enough typing"

Communication Patterns

* Uses emoji thoughtfully: :popcat-hyper:, :rolling_on_the_floor_laughing:, :think:, :eyes:, :pray:
* Brief status updates: "works for me!", "cool :popcat-hyper:", "right i getya"
* Asks clarifying questions before diving in
* Provides context when escalating issues
* Tags relevant people proactively

Red Flags (When Shay Says These)

* "Are we stopping rollout today?" = serious concern, needs immediate attention
* "Id just nuke all calls to..." = has thought through alternatives, time to simplify
* "Nah this is a 'page adam/shay/etc' sorta deal" = escalation needed NOW


Technical Philosophy

Core Beliefs

1. Treat AI agents like junior engineers:
    1. "Eager to please, thinks they are clever, No real world experience, and drinks their memory away"
    2. Heavy planning upfront
    3. Provide examples and rough ideas
    4. Always verify their work
2. Devil's Advocate Everything:
    1. Always include "Top 10 risks with mitigations" in planning
    2. Ask "cheapest way to ship MVP without regret"
    3. Often results in "Actually don't do this at all" - which is valuable
3. Multi-tenant correctness is non-negotiable:
    1. Everything must be keyed by workspaceId/tenantId
    2. Tenant isolation is the top priority
4. Type safety enables AI:
    1. "Shay encouraged enforcing stronger types in the backend to make it easier for LLM agents"
    2. Strong typing = better agent results

Technical Preferences

* Mongo best practices: Deep expertise, go-to person for reviews
* Real-time collaboration: Led Webflow's realtime/operational transforms work
* Infrastructure & reliability: On-call responder, incident commander
* Pragmatic architecture: "metaphorically 'delete realtime and move on' balanced with 'plane is a nightmare but our code is solid'"
* Documentation: Believes in runbooks, wrote Capabilities Fire Drill process


Work Approach

The Shay Method

1. Plan heavily - don't skip this
2. Do exactly this - be specific with requirements
3. Let them do their best - trust but verify
4. Save off .md files - document what was done

Project Style

* Swiss Army Engineer: Moves between realtime, assets, Temporal, infrastructure
* Go-to advisor: Consulted across teams (Dev Ecosystem, Dynamic Data, etc.)
* Tech lead on complex initiatives: Secure Execution Service, Secret Store, ElasticSearch upgrades
* Incident response expert: Tier 1 on-call, created fire drill processes

Burnout Warning Signs (Help Shay Watch For These)

1. Starts optimizing out humans ("because they're slow")
2. Increases difficulty just to feel anything
3. Adds more scope, architecture, rules to make things "clean"
4. Cuts out collaboration, mentorship, play, rest
5. System works but feels detached/bored


Collaboration Preferences

How Shay Helps Others

* Rubber ducking: "can always count on Shay to lend an ear"
* Technical guidance: Deep system knowledge across monorepo
* Emotional support: "makes the team feel safe and makes starting my work day fun"
* Mentoring: Patient teacher, approachable for questions

How to Work with Shay

* Give autonomy: "Shay likes freedom and impact, so dont micromanage and give him big projects"
* Be direct: No need for corporate-speak
* Show your work: Provide context, not just requests
* Ask questions: Shay won't judge, will help think through problems
* Tag early: Better to loop in early than late


Code Review Style

What Shay Values

* Correctness first: Does it actually solve the problem?
* Tenant isolation: Is workspaceId enforced everywhere?
* Type safety: Are types helping or lying?
* Performance implications: Will this scale?
* Operational concerns: Can we debug this in production?

Feedback Style

* Direct but constructive
* Will point out "this will absolutely betray you in production" gaps
* Asks "why" questions to understand intent
* Suggests simplifications: "Id just nuke all calls to SES/Secret store"


AI Agent Collaboration

Shay's Multi-Agent Approach

Runs up to 10 agents in parallel on personal projects, treating them as specialized team members:
Agent Team Structure (from real prompts):

1. UX Agent: User flows, IA, interactions
2. Backend/API Agent: Endpoints, auth, tenant enforcement
3. Data Model Agent: Schema, indexes, migrations
4. LLM/AI Agent: Prompt design, validation, cost controls
5. Devil's Advocate Agent: Risks, abuse vectors, simplifications

Working with Shay on AI Projects

* Expects concrete artifacts: tables, endpoints, schemas, interfaces, flows
* No fluff or motivational speeches
* Focus on what will break and how to prevent abuse
* Design for future but ship for now
* Always include cost controls and rate limits


Communication Examples

Status Updates

"just making waves aren't ya? Thats probably the best approach though"

"works for me!"

"right i getya"

Technical Discussions

"If RT was disabled and they are still seeing delays we prolly can rule that out right?"

"IMHO ops tasks live on the board of work they are related to"

"uhhh nah just more time to chat with the relevant team"

Escalations

"Nah this is a 'page adam/shay/etcetcetc' sorta deal if its s1 mongo"

"Are we stopping rollout today until Jan 5th? if not we should"

Humor

"Hello you have reached Shay-I: it will be 450k"

"GPT assigned me a beet"

"If we can blame AI instead of engineers that will be a :fire: change"


Projects & Expertise

Major Initiatives

* Realtime Collaboration: Tech lead, operational transforms, WebSocket infrastructure
* Secure Execution Service: Designed and implemented sandboxed code execution
* Secret Store: Built secret management for 3rd party integrations
* ElasticSearch Migration: Guided prod upgrade from EOL version
* Incident Response: Created fire drill process, tier 1 responder
* Mongo Best Practices: Documentation lead, cross-pillar collaboration

Go-To Person For

* Realtime/WebSocket architecture
* Operational transforms and conflict resolution
* Multi-tenant architecture patterns
* Incident response and debugging
* Mongo/Postgres optimization
* TypeScript/Node.js backend systems
* Infrastructure and reliability


Meeting & Scheduling

Availability

* Flexible but appreciates heads-up
* Will cover on-call shifts for teammates
* "if you cant find someone I think I can cover both ux/backend shifts!"

Meeting Style

* Appreciates clear agenda
* Contributes technical depth
* Asks clarifying questions
* Will speak up about risks
* "can we hold space in our standup tomorrow to discuss ^^"


Personal Context

Work-Life Balance

* Takes time off seriously
* Will communicate availability clearly
* Values getting outside and disconnecting
* Watches for burnout patterns

Interests (For Context)

* Hockey fan (critical of geographic divisions)
* Horror films and 4K steelbooks
* DIY automotive work (VW/Audi specialist)
* Puzzles and methodical problem-solving
* 3D printing and maker projects
* Dog owner (takes vet appointments seriously)


How to Add This to Your Repo

Option 1: Root-Level SHAY.md

# Add to repository root
$ cp SHAY.md /path/to/your/repo/
$ git add SHAY.md
$ git commit -m "docs: add SHAY.md for AI agent context"

Option 2: Team Member Directory

# Create docs/team/ directory
$ mkdir -p docs/team/
$ cp SHAY.md docs/team/SHAY.md
$ git add docs/team/SHAY.md

Option 3: AI Agents Directory

# Add alongside CLAUDE.md, AGENTS.md
$ cp SHAY.md docs/ai-context/SHAY.md


Telling AI Agents About Shay

In Your System Prompts

When working on code that Shay Cichocki will review:
- Ensure multi-tenant correctness with workspaceId enforcement
- Include type safety and validation
- Consider operational/debugging implications
- Document why decisions were made, not just what
- Think through abuse vectors and failure modes

In Project Context

Shay is the tech lead for [X project]. He values:
1. Heavy planning before implementation
2. Devil's advocate risk analysis
3. Concrete artifacts over abstract discussions
4. Direct communication and pragmatic tradeoffs


Version History

* v1.0 (2026-02-08): Initial version compiled from 2020-2026 Slack history
* Analyzed 6+ years of messages, technical discussions, incident responses, and collaboration patterns
* Refined by Slackbot based on comprehensive search across all channels and DMs


Notes for Future Updates

Update this document when:

* Major role or responsibility changes
* New technical areas of expertise emerge
* Communication preferences evolve
* Team structure or collaboration patterns shift

Keep it authentic. Keep it useful. Keep it direct.
"Ill give someone exactly 12 cents to put a SHAY.md in webflow/webflow" - Shay, 2026-02-08
