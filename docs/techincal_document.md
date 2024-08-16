# Technical document

This document is mainly for Hokome and Ray.

## Entities

Enemies, band members and the band leader are all the same Entity script deriving from CharacterBody. This Entity script should not be inherited and only manages movement and physics by using a variable which is modified by a child node.

All other behaviour and data should be inside child nodes, that includes:

- Attack patterns
- Input
- Automatic movement
- Health

