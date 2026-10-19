---
title: 'You need to tell the story of where the AI money goes'
date: '2026-10-19T12:04:15-03:00'
description: 'A bill tells you how much. It never tells you who, why, or what you got for it. That gap is why I started Costura.'
authors: ['Cauê Braz']
image: ''
image_alt: ''
draft: false
---

Picture the end of the month. The AI bill comes in and it is bigger than last month.
Someone asks why. The honest answer, in most companies I have talked to, is a shrug.

Not because people are careless. Because the bill does not say. It says a total, maybe a
split by provider, and then it stops. Everything that would let you act on it lives
somewhere else: in a console, in a spreadsheet, in the head of the engineer who set up a
key eighteen months ago.

I think this is the real problem with AI spend right now. Not that it is high. That it
has no story.

## How we got here so fast

Cloud spend took a decade to become a discipline. Tags, showback, chargeback, a whole
FinOps profession grew up around one question: whose money is this.

AI spend skipped the decade. In the FinOps Foundation's
[own survey](https://data.finops.org/), the share of teams managing AI costs went from
31% to 98% in two years. The spend itself went from a rounding error to
[$37 billion](https://menlovc.com/perspective/2025-the-state-of-generative-ai-in-the-enterprise/)
in 2025, and nearly half of that is raw model usage and coding tools. One CIO told a16z,
["what I spent in 2023 I now spend in a week."](https://a16z.com/ai-enterprise-2025/)

And it did not arrive through procurement. It arrived through API keys and seats that
anyone with a corporate card can create in a minute. Marketing has keys. Sales has keys.
The CI pipeline has keys. The FinOps Foundation
[says it plainly](https://www.finops.org/wg/finops-for-ai-overview/): groups that never
owned a technology budget are now spending directly on AI.

So the money moved faster than the habit of explaining it. That is not a failure of
anyone in particular. It is just where we are.

## Why the total says nothing

Here is what makes AI bills different from almost every other bill a company pays.

The same vendor sells the same unit at prices a hundred times apart. On
[Anthropic's price list](https://platform.claude.com/docs/en/about-claude/pricing), as I
write this in October 2026, a million output tokens cost fifty cents on the smallest
model and fifty dollars on the largest.
[OpenAI's list](https://developers.openai.com/api/docs/pricing) has the same spread.
Then there are discounts for cached prompts, discounts for batch jobs, surcharges for
speed, and a new tokenizer that quietly counts
[about 30% more tokens](https://platform.claude.com/docs/en/about-claude/pricing) for
the same text.

So when the bill goes up 40%, it could be more work. Or one team switched models. Or a
cache stopped hitting. Or a prompt got longer. The total looks identical in every case,
and the fix is completely different in each one.

Coding agents make this vivid. Anthropic publishes the
[cost of Claude Code](https://code.claude.com/docs/en/costs): around $13 per developer
per active day on average. Fine. But read their list of why a bill spikes. It is not a
list of prices. It is "long sessions that were never cleared" and "Opus left as the
default model". Behaviors. People. The kind of thing a chart will show you as a red
bar and never explain.

Stephen Few wrote twenty years ago that a dashboard
["quickly tells you what's happening, but not why it's happening."](https://www.perceptualedge.com/articles/ie/dashboard_confusion.pdf)
Every AI spend chart I have seen is that dashboard.

## The part nobody owns

There is a quieter problem underneath the loud one.

Some of the money has no owner, by construction. Providers will tell you so if you read
their documentation. Anthropic's usage data has rows with
[no API key attached](https://platform.claude.com/docs/en/manage-claude/usage-cost-api).
Keys created a while ago carry
[no record of who created them](https://platform.claude.com/docs/en/api/organization/api_keys/list).
A service key
[keeps working after the person who made it is gone](https://platform.claude.com/docs/en/manage-claude/workspaces).
I do not think any of that is unreasonable on the provider's side. But it means that
every organization has a slice of spend that belongs to a key, and the key belongs to
nobody.

Then there is the spend that never touched a company key at all. MIT's
[study of AI in business](https://mlq.ai/media/quarterly_decks/v0.1_State_of_AI_in_Business_2025_Report.pdf)
found that under half of companies bought an official subscription, while employees at
nine in ten use personal AI tools for work. IBM's
[breach report](https://newsroom.ibm.com/2025-07-30-ibm-report-13-of-organizations-reported-breaches-of-ai-models-or-applications,-97-of-which-reported-lacking-proper-ai-access-controls)
put a price on it: one in five organizations in the study had a breach tied to shadow
AI, and most had no policy to even detect it.

I am not making a security argument here, though there is one. I am making a simpler
point. You cannot tell a story about money when part of it has no character in it. The
first job of the story is to name the keys that have no owner and go find one.

## Why the tools did not fix this

You would think this is a solved problem. Every provider has a usage page. There are
FinOps platforms with AI connectors. Why does the shrug persist.

Because what the providers give you is dimensions, not a story. One lets you group cost
by project but not by model. Another groups by workspace but not by key. The coding
tools report seats and activity but
[not a dollar amount](https://docs.github.com/en/rest/copilot/copilot-user-management).
None of them know that the Cursor seat, the Claude Code session and the API key all
belong to the same person. If you want cost per person across providers, you build that
join yourself, every month, and you hope the numbers you end up with match the invoice.

The industry knows this. In the same FinOps survey, the top three AI challenges were
visibility into AI costs, allocating them to business units, and knowing whether they
return anything. The most requested feature was granular monitoring of AI spend. And the
billing standard meant to normalize all of this, FOCUS, still lists
[no LLM provider](https://focus.finops.org/) among the vendors that produce it.

Nothing about the FinOps playbook is wrong. Allocation, anomaly management, reconciling to
the invoice, unit economics: the Foundation
[wrote it all down](https://www.finops.org/framework/capabilities/allocation/) for the
cloud, and it applies. What is missing is the layer that takes token data from six
vendors in six shapes and turns it into sentences a person can read.

## What the story sounds like

I keep saying story, so let me be concrete. At the end of a month, I want to read six
sentences.

1. Who spent it. By person, not by key. "Alice spent $412 this month across the API,
   Cursor and Claude Code."
2. On what. "Two thirds of the increase is the Opus model. The rest is three new seats."
3. Why it moved, with a cause and a share. "Spend rose 38% because the `ci-agents` key
   switched to Opus on Tuesday. That is 71% of the increase."
4. What has no owner. "This key has no owner and no limit. It spent $140 in the last
   thirty days."
5. Whether it adds up. "Our ledger matches Anthropic's own report. OpenAI differs by
   $12.40, and here is where."
6. What it bought. "That workflow costs ninety cents a run and saves an hour."

If any of those sentences cannot be written, that is the finding. Not the number. The
missing sentence.

Amazon dropped slides in favor of
[six-page narrative memos](https://www.aboutamazon.com/news/company-news/2017-letter-to-shareholders)
because a narrative forces you to connect the facts. A bill is a slide. The six sentences
are the memo.

## Why I started Costura

I built [Costura](https://costura.ai/) because I wanted to read those six sentences every
month and nothing on the market would write them for me without also asking me to hand
over the keys to my whole organization.

That is the serious reason. There are two others, and I would rather say them out loud.
I built it for fun, because this is the kind of problem I enjoy taking apart on a
weekend. And I built it to learn, because nothing teaches you how a provider bills
like writing the code that reads the bill, line by line, until the totals match. Once
it worked, keeping it to myself made no sense. It is open source so that another team
can read its six sentences without starting from zero. If one other person uses it,
that was worth it.

Costura connects to each provider with a read-only key, pulls the billing data into one
ledger, and rolls everything up to a person: API keys, Cursor seats, Claude Code
sessions, one e-mail. Anomalies come with the cause and its share of the change, in one
sentence. Keys with no owner get their own list. Every month it checks itself against
the provider's own report and against the invoice, because a story that does not add up
is just a nicer-looking guess.

It is open source and runs on your infrastructure. Provider admin keys can read every
dollar and every key in your company, and I did not want mine on someone else's server.
Nothing phones home.

It also does not try to be everything. It will not trace individual requests, it will
not block a key at a limit, and it will not sit next to your cloud bill in one FinOps
suite. Those are good tools and they exist. Costura answers one question, at the end of
the month, in plain language: where did the money go, why did it move, and who should
hear about it.

The provider hands you a number. Your team deserves a story. The difference between the
two is the difference between a bill and a decision.
