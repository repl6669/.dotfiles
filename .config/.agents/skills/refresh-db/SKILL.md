---
name: refresh-db
description: Refreshes the database by running migrations and seeding in Docker
---

# Refresh Database

This skill runs `php artisan migrate:fresh --seed` inside the Docker container to refresh the database with fresh migrations and seed data.

## When to Use This Skill

Use this skill when the user:
- Asks to "refresh the database"
- Asks to "reseed the database"
- Asks to "migrate and seed"
- Needs to reset the database to a fresh state
- Has run new migrations and needs to apply them
- Wants to apply new seed data

## How to Execute

Run the following command in the project directory:

```bash
docker exec -it kokino-api-1 php artisan migrate:fresh --seed
```

Note: The container name may vary. Use `docker ps` to find the correct container name if needed.

## What It Does

1. Drops all tables in the database
2. Runs all migrations
3. Seeds the database with initial data
