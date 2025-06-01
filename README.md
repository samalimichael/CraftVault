# CraftVault: Handmade Pattern and Design Exchange Platform

CraftVault is a decentralized platform built on blockchain technology that enables artisans and crafters to preserve and share traditional handmade patterns with transparent creative heritage protection.

## Overview

CraftVault creates a global community for preserving craft traditions through peer-to-peer pattern sharing. The platform allows artisans to document patterns they've developed, specify craft types and skill requirements, and connect with other makers interested in traditional and innovative handmade techniques.

## Features

- Create pattern entries with detailed information (name, instructions, craft type, skill level)
- Specify complexity ratings for accurate project planning
- Control pattern visibility and sharing permissions
- Browse available patterns by craft type, skill level, or artisan
- Transparent artisan verification and creative provenance

## Contract Functions

### Public Functions

- `share-pattern`: Add patterns to the craft vault
- `restrict-pattern`: Remove patterns from open sharing
- `get-pattern`: Retrieve details about specific craft patterns
- `get-artisan`: Get information about the artisan who shared specific patterns

### Constants

- Minimum complexity rating requirements
- Validation for craft types and skill levels
- Error codes for various failure scenarios

## Data Structure

Each pattern entry contains:
- Artisan information (principal)
- Pattern name (string)
- Crafting instructions (string)
- Craft type classification
- Skill level assessment
- Sharing status
- Complexity rating

## Getting Started

To interact with the CraftVault network:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Share patterns you wish to preserve and exchange
4. Browse traditional patterns from other artisans and craft communities

## Future Development

- Implement pattern rating and review system
- Add artisan certification and verification
- Create material sourcing recommendations
- Develop technique video integration