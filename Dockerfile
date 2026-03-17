FROM node:20-bullseye-slim

ENV NODE_ENV=production \
    TZ=Europe/Paris \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    fonts-liberation fonts-noto-color-emoji \
    libatk-bridge2.0-0 libatk1.0-0 libcups2 libdrm2 libgbm1 \
    libgtk-3-0 libnspr4 libnss3 libxcomposite1 libxdamage1 \
    libxfixes3 libxkbcommon0 libxrandr2 xdg-utils libasound2 \
    tzdata ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev && npm cache clean --force

COPY src/     ./src/
COPY scripts/ ./scripts/
COPY main.js  ./

RUN mkdir -p logs debug

CMD ["node", "main.js"]
