---
name: plain-english
description: Writing rules for any prose a human reads — PR findings, plans, ticket comments, terminal answers, commit bodies, agent-read docs. No metaphor, no narration, no filler; plain technical English. Load before writing an explanation, review, plan, summary, or hand-off.
---

# Plain English

No prose, no metaphor, plain English, simple technical language. It is not rocket
science and it is not a poetry contest.

This applies to everything a human reads, including this file.

## Rules

1. **Say the thing.** First sentence is the answer or the verdict.
2. **One idea per sentence.** About 20 words. No stacked em-dash clauses.
3. **Plain word over clever word.** If a shorter common word exists, use it.
4. **No metaphor.** None.
5. **Name the thing.** Use the file, function, field, number. Do not describe around it.
6. **No process narration.** Not what you checked, how you searched, or how many
   options you considered.
7. **Numbers, not adjectives.** "31 writes", not "a lot of writes". "3 files", not
   "a small change".
8. **Cut anything not actionable.** An area you checked and found fine gets no line.
9. **No hedge stacks.** Say yes, no, or "I don't know".

## Banned

Metaphor and inflation:
ratcheting, bites, bitten, blast radius, wipe path, load-bearing, came back clean,
surfaces (as a noun), landscape, journey, unlock, leverage, seamless, elegant,
powerful, crucial, pivotal, delve, tapestry, testament, realm, foster, underscore,
showcase, navigate (unless it is actual navigation), robust (say what it does).

Filler openers:
"Great question", "Let me explain", "It's worth noting", "Essentially", "At its
core", "In essence", "Simply put", "I'd be happy to".

Process narration:
"I searched for", "After reviewing", "Having checked", "I took a look at",
"Findings below", "All verdicts are in".

## Before and after

✗ The elegant abstraction here is load-bearing, so removing it would have a
significant blast radius.
✓ Four files import this. Deleting it breaks all four.

✗ I dug into the image pipeline and, after tracing the flow through several
layers, discovered that provenance is essentially decorative.
✓ `provenance` is written to the row and never read.

✗ This is a fairly substantial change that touches a number of areas.
✓ 13 files: 7 server, 6 webclient.

✗ It's worth noting that the tests came back clean.
✓ Tests pass. Or say nothing.

✗ The fix is straightforward but the underlying issue is more nuanced.
✓ One line fixes it. The same bug is in two other callers.

## Tables

A table compares values across a fixed set of things. Do not put reasoning in a
cell. If a cell needs a "because", it belongs in a sentence.

## Length

Short is the default. Long is fine when the content is long — a plan with nine
steps has nine steps. Padding is banned, detail is not.
