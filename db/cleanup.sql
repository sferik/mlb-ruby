DROP TABLE "drafts";

BEGIN TRANSACTION;
CREATE TABLE "leagues_new" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "name" VARCHAR(50) NOT NULL);
INSERT INTO "leagues_new" SELECT "id", "name" FROM "leagues";
DROP TABLE "leagues";
ALTER TABLE "leagues_new" RENAME TO "leagues";
COMMIT;

BEGIN TRANSACTION;
CREATE TABLE "divisions_new" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "league_id" INTEGER NOT NULL, "name" VARCHAR(50) NOT NULL);
INSERT INTO "divisions_new" SELECT "id", "league_id", "name" FROM "divisions";
DROP TABLE "divisions";
ALTER TABLE "divisions_new" RENAME TO "divisions";
CREATE INDEX "index_divisions_league_id" ON "divisions" ("league_id");
COMMIT;

BEGIN TRANSACTION;
CREATE TABLE "players_new" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "team_id" INTEGER, "name" VARCHAR(100) NOT NULL, "position" VARCHAR(50), "number" INTEGER NOT NULL);
INSERT INTO "players_new" SELECT "id", "team_id", "name", "position", "number" FROM "players";
DROP TABLE "players";
ALTER TABLE "players_new" RENAME TO "players";
CREATE INDEX "index_players_team_id" ON "players" ("team_id");
COMMIT;

BEGIN TRANSACTION;
CREATE TABLE "teams_new" ("id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, "league_id" INTEGER NOT NULL, "division_id" INTEGER NOT NULL, "name" VARCHAR(50), "logo_url" VARCHAR(255), "manager" VARCHAR(100) NOT NULL, "ballpark" VARCHAR(100), "mascot" VARCHAR(100), "founded" INTEGER NOT NULL, "wins" INTEGER NOT NULL, "losses" INTEGER NOT NULL);
INSERT INTO "teams_new" SELECT "id", "league_id", "division_id", "name", "logo_url", "manager", "ballpark", "mascot", "founded", "wins", "losses" FROM "teams";
DROP TABLE "teams";
ALTER TABLE "teams_new" RENAME TO "teams";
CREATE INDEX "index_teams_division_id" ON "teams" ("division_id");
CREATE INDEX "index_teams_league_id" ON "teams" ("league_id");
CREATE INDEX "index_teams_name" ON "teams" ("name");
COMMIT;

VACUUM;
