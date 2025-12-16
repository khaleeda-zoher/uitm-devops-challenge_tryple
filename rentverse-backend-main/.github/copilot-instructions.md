# Copilot instructions — Rentverse Backend

Purpose: Help AI coding assistants make small, safe, and correct changes to the Rentverse Express backend.

- Repo root: the backend lives in `rentverse-backend-main`.
- Entry point: `index.js` (start script) and Express app configuration in `src/app.js`.
- DB schema: `prisma/schema.prisma` (Prisma + PostgreSQL). After schema changes run `pnpm db:generate` and `pnpm db:migrate`.

Quick start (local):
```bash
cd rentverse-backend-main
pnpm install
cp .env.example .env    # update DATABASE_URL and JWT_SECRET
pnpm db:generate
pnpm db:migrate
pnpm db:seed
pnpm dev
```

Important scripts (see `package.json`):
- `pnpm dev` — development (nodemon)
- `pnpm start` — production (node index.js)
- `pnpm db:generate`, `pnpm db:migrate`, `pnpm db:seed`, `pnpm db:studio`
- `pnpm format`, `pnpm lint`, `pnpm lint:fix`

Architecture notes (what to read first):
- `src/` — main app code. See `src/app.js` for middleware, swagger, and route mounting.
- `src/routes/` — route definitions (auth, users, properties, bookings). Follow route → controller → service pattern if present.
- `src/config/` — environment and database connection helpers.
- `prisma/` — data model (`schema.prisma`) and seed script (`prisma/seed.js`).
- `templates/` — EJS templates for generated PDFs (example: `templates/rental-agreement.ejs`).
- `uploads/` — local upload folders; Cloudinary integration used in code (check `cloudinary` usage in services).

Conventions & patterns specific to this repo:
- Uses `pnpm` (see `packageManager` in `package.json`). Prefer `pnpm` for installs and scripts.
- JWT-based auth: token expected in `Authorization: Bearer <token>` header.
- Prisma client must be re-generated after modifying `schema.prisma`.
- File uploads often handled with `multer` and then uploaded to Cloudinary; avoid changing upload flow without checking `templates/` and `uploads/` interactions.
- Spatial/GeoJSON endpoints use raw SQL / PostGIS in properties route (high-performance). See README geojson example.

Testing & CI:
- There are no unit tests configured (`test` script prints an error). Rely on manual API checks via Swagger UI at `/docs`.

When changing database models:
- Add migration via `pnpm db:migrate` and run `pnpm db:seed` if seed changes are required.
- Update code references to new fields (routes/services/controllers) and re-run `pnpm db:generate`.

When updating API surface:
- Update route files in `src/routes/` and the Swagger configuration in `src/config/swagger.js` (if present) so `/docs` stays in sync.

Files to inspect for any change:
- [rentverse-backend-main/src/app.js](rentverse-backend-main/src/app.js)
- [rentverse-backend-main/index.js](rentverse-backend-main/index.js)
- [rentverse-backend-main/package.json](rentverse-backend-main/package.json)
- [rentverse-backend-main/prisma/schema.prisma](rentverse-backend-main/prisma/schema.prisma)
- [rentverse-backend-main/prisma/seed.js](rentverse-backend-main/prisma/seed.js)
- [rentverse-backend-main/templates/rental-agreement.ejs](rentverse-backend-main/templates/rental-agreement.ejs)

Safety & review guidance for PRs created by an AI:
- Keep changes small and well-scoped — prefer single-file or single-feature PRs.
- Run `pnpm format` and `pnpm lint` locally before proposing changes.
- Don't change DB model names or column types without a migration and human review.
- If adding new secrets/config, ensure `.env.example` is updated and no secrets are committed.

If any instruction here is ambiguous, ask for the maintainer to point to the exact route or file to modify.

— end
