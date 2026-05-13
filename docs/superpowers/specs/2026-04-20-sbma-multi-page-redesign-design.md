# SBMA Multi-Page Redesign Design

## Summary

Redesign the current single-page SB Music Jekyll site into a multi-page cultural institution website optimized first for donors. The site should present the organization as a contemporary South Bay arts institution sustained by patrons, with membership, ensembles, events, and editorial content supporting that institutional story rather than competing with it.

The redesign should replace the current one-page fundraising structure with a calmer, higher-trust information architecture that gives donors a clear narrative:

1. South Bay Music is a real regional cultural institution.
2. Its ensembles and programs sustain local music life.
3. Patron support preserves that public cultural presence.
4. Giving is a dignified act of stewardship.

## Goals

- Establish an institution-first, donor-led website structure.
- Shift donation messaging from campaign fundraising to patronage and stewardship.
- Build a multi-page site around the approved navigation:
  - About
  - Impact
  - Ensembles
  - Support
  - Events
  - Updates
  - Shop
- Maintain persistent donation actions via `Become a Patron` and `Donate`.
- Provide starter editorial content for `Updates` and `Press`.
- Reserve a polished embed area for Give Lively on support and donation pages.

## Non-Goals

- Building a live CMS or blog engine.
- Implementing actual payment logic or membership logic.
- Publishing named donor lists or named leadership rosters.
- Creating dynamic event feeds or external API integrations.
- Adding React, Tailwind, Framer Motion, or any JavaScript-heavy framework if the current Jekyll architecture can support the redesign cleanly.

## User Priorities

### Primary Audience

Donors and prospective patrons.

### Secondary Audiences

- Community members browsing events and updates
- Prospective ensemble participants
- Press and institutional partners
- Casual visitors seeking legitimacy and context

### Primary User Outcomes

- Understand the organization’s civic and artistic role
- Feel trust in the institution
- See concrete evidence of activity and relevance
- Reach the Give Lively donation area with minimal friction
- View giving as ongoing patronage rather than a one-time emergency ask

## Brand and Tone Direction

### Positioning

The site should read as a contemporary cultural institution, not a school portal and not a nonprofit campaign landing page.

### Tone

- Restrained
- Confident
- Public-facing
- Civic-minded
- Generous rather than urgent

### Language Direction

Approved donation framing:

- sustain South Bay’s music culture
- support the season
- become a patron
- help keep public music life thriving

Avoid:

- high-pressure campaign language
- generic nonprofit urgency cues
- transactional membership copy unsupported by the Give Lively flow

## Visual Direction

### Approved Direction

`A. Civic Institution`

### Visual Characteristics

- Warm off-white backgrounds
- Deep charcoal text
- A restrained copper or burnished brass accent
- Contemporary, left-aligned typographic hierarchy
- Asymmetric but stable layouts
- Generous whitespace
- Minimal use of cards; use containers only when they clarify hierarchy

### Visual Anti-Patterns

- Bright campaign gradients
- Generic nonprofit hero treatments
- Repetitive three-card rows
- Loud urgency banners
- Decorative clutter that competes with institutional trust

## Information Architecture

## Top-Level Pages

- Home
- About
- Impact
- Ensembles
- Join the Band
- Support
- Donate
- Events
- Updates
- Press
- Shop

### Footer Links

Include:

- YouTube
- Facebook
- Instagram
- Contact information
- Quick links to support, events, updates, and press

### Navigation Rationale

The top-level navigation should privilege donor decision-making first. `Leadership`, `Community Impact`, `Membership`, and `Donors` should live as page sections under stronger institutional parents rather than becoming top-level items.

## Page Definitions

### Home

Purpose:
- Establish institutional credibility
- Present the donor case
- Route users toward support, ensembles, events, and editorial content

Recommended section order:
- Institutional hero
- Mission / regional role
- Community and cultural impact
- Featured ensembles
- Patron support section with Give Lively embed area
- Upcoming events
- Updates and press highlights
- Institutional footer

### About

Purpose:
- State mission
- Explain institutional history and purpose
- Present stewardship and governance tone without named leadership

Sections:
- Mission statement
- Historical overview
- Institutional values
- Governance / stewardship section without names

### Impact

Purpose:
- Prove relevance and value to the region

Sections:
- Community impact overview
- Education / community participation
- Cultural access and public life framing
- Donor-facing proof points

### Ensembles

Purpose:
- Show the breadth of artistic activity
- Reinforce that patron support sustains real performing groups

Sections:
- Ensembles overview intro
- Grid/list of ensemble entries
- CTA to support or join

### Ensemble Detail Pages

Required pages:
- West Coast Wind Symphony
- South Bay Concert Band
- Beach City Swing Band
- Segundo Saxes
- El Segundo Brass Ensemble

Each page should include:
- Ensemble identity and description
- Performance/rehearsal profile
- Community role
- Upcoming appearances placeholder or section
- CTA to support
- CTA to join where appropriate

### Join the Band

Purpose:
- Serve recruitment needs without diluting the donor-led homepage

Sections:
- Who should join
- What participation looks like
- Ensemble pathways
- Contact / inquiry CTA

### Support

Purpose:
- Explain the patron model and why giving matters

Sections:
- Patronage framing
- Why support matters
- Member/patron pathway language without inventing benefits
- Give Lively embed area
- Link to dedicated donation page

### Donate

Purpose:
- Act as the primary conversion destination for site-wide CTAs

Sections:
- Brief donor-facing intro
- Give Lively embed area
- Supporting stewardship language
- Optional short FAQ / trust copy

### Events

Purpose:
- Show the institution is active in public life

Sections:
- Featured event
- Seasonal or upcoming event list
- Patronage CTA

### Updates

Purpose:
- Provide a blog-style institutional news surface

Starter content should include several entries such as:
- season announcements
- program/community highlights
- supporter-facing institutional notes

### Press

Purpose:
- Present outside-facing credibility

Starter content should include:
- sample press note cards
- media framing copy
- press contact block

### Shop

Purpose:
- Offer a secondary support route

Scope:
- static merchandise/support content only
- no checkout logic required in this phase

## Content Rules

- Do not include named donors.
- Do not include named leadership.
- Do not fabricate board rosters.
- Provide starter content for `Updates` and `Press`.
- Keep donor copy institutional and cultured, not theatrical.

## Give Lively Integration Strategy

The redesign should not implement payment logic. Instead:

- create a dedicated, styled embed container region
- make that region feel deliberate and on-brand
- support easy replacement with a real Give Lively embed later

This embed area belongs on:

- Support
- Donate
- optionally the homepage support section

## Technical Approach

### Platform

Remain on Jekyll and static HTML/CSS/JS unless a platform blocker appears. The existing repo already targets Jekyll output for `_site` and Cloudflare deployment, so the redesign should work within that architecture instead of introducing a new application stack unnecessarily.

### Site Structure

Move from one monolithic `index.html` page to:

- page-specific Jekyll HTML files
- reusable layout and navigation partial structure if warranted
- shared CSS that can support multiple page types and reusable institutional sections

### CSS Strategy

Refactor the current stylesheet into clearer reusable sections for:

- global tokens and typography
- header/navigation
- page hero variants
- section layouts
- institutional editorial blocks
- support/donation modules
- ensemble and update cards
- footer/social

### JavaScript Strategy

Keep JavaScript minimal:

- mobile navigation
- any lightweight interactions already justified

Do not add motion libraries or framework dependencies unless absolutely necessary.

## Accessibility and UX Requirements

- Maintain semantic page structure and heading hierarchy.
- Keep CTA language clear and visible without overusing it.
- Ensure mobile navigation works across all pages.
- Ensure multiple pages have consistent orientation and cross-linking.
- Preserve high contrast and readable paragraph widths.
- Ensure Give Lively placeholder regions have accessible labels and explanatory context.

## Risks

### IA Sprawl

A multi-page structure can become diffuse if every page tries to carry equal importance. The homepage and persistent support CTAs must preserve donor priority.

### Trust Dilution

If the site becomes too editorial or too recruitment-heavy, donors may lose the clear giving pathway.

### Placeholder Awkwardness

The Give Lively area must look intentional. A visibly empty or low-fidelity placeholder would undermine trust.

## Success Criteria

- The site ships as a multi-page Jekyll site.
- Navigation reflects the approved donor-led institutional structure.
- Homepage reads as a contemporary cultural institution.
- Support and Donate pages contain polished Give Lively-ready embed regions.
- Updates and Press launch with starter content.
- No donor or leadership names appear.
- Ensemble detail pages exist for the listed ensembles.
- The design language is consistent across all pages and materially more refined than the current one-page layout.
