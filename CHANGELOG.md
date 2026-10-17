# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/2.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.11.0] - 2025-12-30

### Added

- Add game data endpoints: Schedule, LiveFeed, Boxscore, Linescore, PlayByPlay
- Add Standings for league standings and team records
- Add Stats and Leaders for player/team statistics and league leaders
- Add HomeRunDerby for derby bracket, pool, and player performance data
- Add Draft for draft picks and prospect information
- Add FreeAgents for free agent tracking
- Add PostseasonSchedule and PostseasonSeries for playoff data
- Add Attendance for attendance records
- Add TeamStats, TeamLeaders, and TeamHistory endpoints
- Add metadata endpoints: GameTypes, GameStatuses, EventTypes, Positions, PitchTypes, PitchCodes, RosterTypes, and more
- Add WinProbability and ContextMetrics for advanced game analytics
- Add Jobs for umpires, official scorers, and datacasters
- Add Streaks for player hitting/pitching streaks

## [0.10.0] - 2025-04-30

### Added

- Add equalizer for object identity
- Add Seasons, Conferences, and Awards
- Add Players.find and Players.find_all

### Removed

- **Breaking:** Drop support for Ruby 3.1

## [0.9.0] - 2024-05-21

### Changed

- **Breaking:** Rewrite to use MLB Stats API

## [0.8.0] - 2024-05-06

### Changed

- **Breaking:** Rewrite

[Unreleased]: https://github.com/sferik/mlb-ruby/compare/v0.11.0...HEAD
[0.11.0]: https://github.com/sferik/mlb-ruby/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/sferik/mlb-ruby/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/sferik/mlb-ruby/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/sferik/mlb-ruby/compare/v0.7.0...v0.8.0
