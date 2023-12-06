FROM node:20-slim as base

RUN corepack enable

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY package.json pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm fetch --frozen-lockfile

FROM base as dev
ENV NODE_ENV=development
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm install --frozen-lockfile

# FROM base AS prod
# ENV NODE_ENV=production
# RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm install --prod --frozen-lockfile

# COPY vite.config.js ./
# COPY svelte.config.js ./
# COPY src/ ./src
# COPY static/ ./static

# RUN pnpm build
# CMD [ "pnpm", "preview" ]
