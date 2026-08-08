# ⚡ Project LOOP — Master Design & Architecture Specification

> **The Vision**: The definitive **pure-text social platform with Discord-grade real-time voice & chat**, combining the absolute best of **Discord, X (Twitter), WhatsApp, and Telegram** in a precision minimalist design with **Modern Apple Blue (`#007aff`) for primary accents and Bright Apple Green (`#30d158`) for live voice/mic activity**. No photos, no videos, no algorithmic manipulation, no floaty fluff—just sharp text, sub-20ms chat delivery, and crystal-clear <40ms voice channels with automatic reconnection.

---

## 1. The Best of Discord, X, WhatsApp & Telegram (Feature Matrix)

```mermaid
flowchart TD
    subgraph Giants ["The 4 Best-of-Breed Foundations"]
        X["𝕏 / Twitter\n• Chronological Following & Discover feeds\n• 1-Click Reposts & Quote thoughts\n• Threaded replies with connector hairlines\n• Bookmarks, Pin to profile & Edit post window"]
        Discord["Discord\n• 1-Tap Persistent Voice Channels & Lounges (Sub-40ms LiveKit SFU)\n• Auto-Reconnect with ICE Restart & Connection Quality Meter\n• Voice Activity Detection (VAD) & Active Speaker Bright Green Glow Rings\n• Sub-20ms WebSocket DMs & Group chats\n• Live presence, custom text statuses & emoji reactions"]
        Telegram["Telegram\n• Broadcast Channels / Public Circles\n• Search history inside any DM conversation\n• 'Saved Messages' personal private scratchpad\n• Keyboard-first shortcuts & instant navigation"]
        WhatsApp["WhatsApp\n• Read receipts & delivery ticks (✓, ✓✓, ✓✓ blue)\n• In-reply-to quote preview bubbles in chat\n• DM privacy (Allow all vs. Mutuals only)\n• Pin conversations & mute/archive chats"]
    end

    subgraph ProductCore ["LOOP's Unified Engine"]
        Voice["🎙️ 1-Tap Discord Voice Channels\nDrop in/out freely, LiveKit SFU + Opus 48kHz (Sub-40ms latency, persistent bottom dock)"]
        Speed["⚡ Sub-20ms WebSocket Chat\nInstant optimistic updates for feed, likes, and messages"]
        Palette["⚡ Global Command Palette (Cmd+K)\nJump to any user, chat, bookmark, or action in 1 keystroke"]
        Design["🎨 Monochrome Precision + Apple Blue (#007aff) & Bright Green (#30d158)\nSolid layered dark surfaces with 1px crisp hairline borders"]
    end

    Giants --> ProductCore
```

---

## 2. Complete Essential Feature Catalog

### A. The Feed & Stream (Best of X + Telegram Channels)
1. **Dual Feed Engine**:
   - `Following`: 100% pure chronological stream of thoughts from people you follow (zero ads, zero algorithmic insertion).
   - `Discover`: Real-time global pulse of latest thoughts across the community.
2. **Micro-Post Composer (≤300 chars)**:
   - Live Apple Blue circular progress ring as you type.
   - Hotkey publish: `Cmd + Enter` / `Ctrl + Enter`.
   - Rich text formatting: Bold (`**`), Italic (`*`), Inline Code (`` `code` ``), and Blockquotes (`>`).
3. **Post Interactions**:
   - **Like / Heart**: Tactile numeric slide ticker (`tabular-nums`) with vibrant Pink/Red (`#ff375f`) glow.
   - **Repost / Echo**: 1-Tap repost directly to your followers.
   - **Quote Thought**: Repost with your own commentary attached above the original card.
   - **Threaded Nested Replies**: Clean vertical connector hairlines with indented responses.
   - **Bookmark / Save**: 1-Click save to your private `Bookmarks` tab.
   - **Post Edit Window**: Edit typos within 15 minutes of posting (displays a subtle `(edited)` label).
   - **Pin to Profile**: Pin up to 3 of your best thoughts to the top of your profile.
   - **Emoji Micro-Reactions**: Add instant reactions (`🔥`, `⚡`, `❤️`, `👀`, `🧠`, `🚀`) below any post.

---

### B. Discord-Style 1-Tap Voice Channels & Lounges (LiveKit SFU + Opus)
*No complex phone ringing, incoming call popups, or accept/decline flows. Users simply join and leave persistent voice channels freely, exactly like Discord.*

1. **1-Tap Voice Channel Drop-in**:
   - Click any voice channel (e.g. `🔊 #general-lounge`, `🔊 #builders`, `🔊 #chill`) to immediately connect to the audio room.
   - Channel participant list shows who is currently inside with **Bright Green (`#30d158`) active speaking rings**.
2. **Seamless Auto-Reconnection & Fast ICE Restart**:
   - If the user's Wi-Fi drops, switches to cellular, or encounters network jitter, the WebRTC engine initiates an **instant ICE Restart within <500ms** without dropping the audio session.
   - Connection State Indicator: Live ping meter in milliseconds (`🟢 18ms`, `🟡 110ms`, `🔴 Reconnecting...`).
   - Silent JWT Token Refresh: Background token rotation so multi-hour voice sessions never disconnect.
3. **Persistent Floating Voice Dock (Global)**:
   - When connected, a sleek dock floats at the bottom of the screen across all routes:
     `🟢 In Voice: #general (18ms ping) · 🎙️ Mute (M) · 🎧 Deafen (D) · 🔴 Disconnect (Esc)`
   - Browse the feed, write posts, or chat in DMs while talking in real-time with zero audio interruption.
4. **Voice Activity Detection (VAD) & Active Speaker Detection**:
   - **Bright Green Glowing Rings (`#30d158`)**: Avatars pulse with a high-visibility Apple Green glow when actively speaking.
   - **Push-to-Talk (PTT)**: Optional configurable hotkey (e.g. hold `Space` or `Caps Lock` to speak).
5. **Per-User Volume Sliders & Noise Suppression**:
   - Right-click / hover any participant in a voice channel to adjust their individual volume from **0% to 200%**.
   - **Opus Codec @ 48kHz** (32–64 kbps), browser-native acoustic echo cancellation, noise suppression, and auto-gain control.
   - Discontinuous Transmission (DTX) drops bandwidth to 0 kbps when silent.
6. **Discord-Style Audio Earcons**:
   - Subtle tactile chimes when joining a channel, disconnecting, muting, or unmuting.

---

### C. Discord-Fast Direct Messages & Chat (Best of Discord + WhatsApp + Telegram)
1. **Sub-20ms Real-Time WebSocket Engine**:
   - Built on native FastAPI WebSockets + Redis Pub/Sub for instantaneous message dispatch.
   - Messages appear with a smooth `4px translateY` slide and zero UI freeze.
2. **Delivery & Read Receipts (WhatsApp Style)**:
   - `✓` Sent to server.
   - `✓✓` Delivered to recipient's active socket.
   - `✓✓` (Modern Apple Blue) Read by recipient.
3. **Live Typing Indicators & Presence (Discord Style)**:
   - Rhythmic 3-dot breathing animation: *"Sarah is typing..."*.
   - Live **Bright Green status dot (`#30d158`)** (`online` / `offline`) + custom status snippet (e.g. `💬 "building loop"`, `⚡ "deep work"`).
4. **In-Chat Quoted Replies**:
   - Click or swipe reply on any message to pin a quote bubble above your input.
5. **Emoji & Micro-Reactions**:
   - Add instant reactions (`🔥`, `⚡`, `❤️`, `👀`, `🧠`, `🚀`) below any chat message.
6. **In-Chat Message Search**:
   - Search through the message history of any specific 1-on-1 or group conversation with live keyword highlighting.
7. **Pinned Chats, Mute & Archive**:
   - Pin your top 5 friends to the top of your conversation list.
   - Mute notifications or archive inactive conversations.
8. **"Saved Messages" (Telegram Style)**:
   - Dedicated private scratchpad conversation with yourself to jot down notes, draft thoughts, and store links.

---

### D. Profiles, Circles & Follows (Best of X + Telegram Broadcasts)
1. **User Identity (`/@handle`)**:
   - Display name, `@handle`, bio (≤280 chars), custom status, joined date.
   - Stats Bar: `Following`, `Followers`, `Thoughts`.
   - 1-Tap Solid **Modern Apple Blue `Follow` / `Following` toggle**.
2. **Profile Tabs**:
   - `Thoughts`: Root posts authored by this user (including pinned posts at top).
   - `Replies`: Public thread replies and discussions.
   - `Likes`: Posts liked by this user (public or private toggle).
   - `Bookmarks`: Private saved thoughts (visible only to account owner).
3. **Public Broadcast Circles / Channels (Telegram Style)**:
   - Users can create a dedicated text broadcast channel where only they can post, and subscribers receive updates in real-time.
4. **Tethered Hover Cards (Linear Style)**:
   - Hovering over any `@handle` for >180ms opens a floating card with bio, stats, and a 1-tap `Follow` button without navigating away.

---

### E. Search, Command Palette & Settings
1. **Global Command Palette (`Cmd + K`)**:
   - Jump to any user (`@alex`), join a voice channel (`🔊 #general`), open a chat (`#sarah`), navigate tabs, or trigger a new post in 1 keystroke.
2. **Live Search**:
   - Search users by name/handle, voice channels, and community posts by keyword or hashtag (`#minimalism`).
3. **Privacy & Security Settings**:
   - DM Privacy: `Allow all users` vs. `Mutual followers only`.
   - Online Presence: Toggle whether others can see when you are active.

---

## 3. Minimalist Design System: Solid Monochrome + Apple Blue & Bright Green

### 3.1 Palette & Semantic Tokens (`globals.css`)
No blurry glassmorphism. Surfaces are **solid, dark, and layered** with precision 1px borders and targeted high-visibility accents:

```css
:root {
  /* Solid Surface Layering (Pitch Black -> Deep Charcoal) */
  --bg-canvas: #060608;             /* Viewport base background */
  --bg-surface-0: #0b0b0e;          /* Floating nav rail & sidebar */
  --bg-surface-1: #111115;          /* Post cards & chat bubbles */
  --bg-surface-2: #18181d;          /* Composer, popovers & elevated inputs */
  --bg-surface-hover: #22222a;      /* Hover state on interactive rows */
  --bg-surface-active: #2b2b35;     /* Pressed button state */

  /* Precision Hairline Borders */
  --border-subtle: rgba(255, 255, 255, 0.07);
  --border-medium: rgba(255, 255, 255, 0.14);
  --border-strong: rgba(255, 255, 255, 0.28);
  --border-focus: #007aff;          /* Apple Blue focus ring */

  /* High-Scannability Typography */
  --text-high: #f4f4f6;             /* Primary text: crisp off-white */
  --text-medium: #a1a1aa;           /* Secondary text: silver guidance */
  --text-subtle: #71717a;           /* Tertiary text: timestamps, handles */
  --text-muted: #474750;            /* Disabled states, subtle placeholders */

  /* Modern Apple Blue Accent Suite (Primary Actions, CTAs, Badges) */
  --apple-blue: #007aff;            /* Primary action blue */
  --apple-blue-hover: #0066d6;      /* Hover state for primary buttons */
  --apple-blue-subtle: rgba(0, 122, 255, 0.12); /* Badge & selection background */
  --apple-blue-glow: 0 0 16px rgba(0, 122, 255, 0.25);

  /* Modern Bright Green Accent Suite (Live Voice, Active Mic, Online Presence) */
  --bright-green: #30d158;          /* Apple Bright Green for mic/voice */
  --bright-green-glow: 0 0 16px rgba(48, 209, 88, 0.35); /* Active speaker avatar ring */
  --bright-green-subtle: rgba(48, 209, 88, 0.12); /* In-voice status chip */

  /* Auxiliary Semantic Accents */
  --status-danger: #ff453a;         /* Apple Red for Disconnect & Muted mic */
  --status-warning: #ff9f0a;        /* Apple Amber for Deafened state */
  --reaction-heart: #ff375f;        /* Apple Pink for active Like hearts */

  /* Typography & Layout Metrics */
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
}
```

### 3.2 Power-User Keyboard Navigation
| Shortcut | Action | Scope |
| :--- | :--- | :--- |
| **`j` / `k`** | Move focus down / up to the next post card | Global Feed |
| **`n`** | Open global quick-post modal | Global |
| **`c`** | Focus chat / jump to conversations | Global |
| **`m`** | Toggle microphone Mute / Unmute (when in voice channel) | Voice Dock |
| **`d`** | Toggle Deafen / Undeafen (when in voice channel) | Voice Dock |
| **`Esc`** | Disconnect voice / Close modal / collapse split-pane | Modals & Voice |
| **`/`** | Focus search input | Global |
| **`Cmd + K` / `Ctrl + K`** | Open command palette (Jump to user, voice channel, call) | Global |
| **`Cmd + Enter`** | Submit post or reply | Composers |
| **`Enter`** | Send message (Shift+Enter for newline) | Chat input |
| **`l`** | Like the currently highlighted post | Feed |
| **`r`** | Reply to the currently highlighted post | Feed |

---

## 4. Containerized Infrastructure (`docker-compose.yml`)

The platform is 100% self-contained across 5 Docker containers:

```yaml
version: '3.8'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    container_name: loop_frontend
    ports:
      - "3000:3000"
    environment:
      - NEXT_PUBLIC_API_URL=http://localhost:8000/api/v1
      - NEXT_PUBLIC_WS_URL=ws://localhost:8000/ws
      - NEXT_PUBLIC_LIVEKIT_URL=ws://localhost:7880
    depends_on:
      backend:
        condition: service_healthy
    restart: unless-stopped

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: loop_backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql+asyncpg://loop_user:loop_password@db:5432/loop_db
      - REDIS_URL=redis://redis:6379/0
      - LIVEKIT_API_KEY=devkey
      - LIVEKIT_API_SECRET=secret_dev_key_for_livekit_voice_service_32bytes
      - LIVEKIT_URL=http://livekit:7880
      - JWT_SECRET=loop_dev_secret_key_change_in_production_32bytes
      - JWT_ALGORITHM=HS256
      - ACCESS_TOKEN_EXPIRE_MINUTES=10080
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
      livekit:
        condition: service_started
    healthcheck:
      test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"]
      interval: 5s
      timeout: 3s
      retries: 5
    restart: unless-stopped

  livekit:
    image: livekit/livekit-server:latest
    container_name: loop_livekit
    command: --dev --bind 0.0.0.0
    ports:
      - "7880:7880"                # LiveKit WebSocket Signaling
      - "50000-50050:50000-50050/udp" # WebRTC SFU Audio Stream
    environment:
      - LIVEKIT_KEYS=devkey: secret_dev_key_for_livekit_voice_service_32bytes
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    container_name: loop_db
    environment:
      - POSTGRES_USER=loop_user
      - POSTGRES_PASSWORD=loop_password
      - POSTGRES_DB=loop_db
    volumes:
      - loop_postgres_data:/var/lib/postgresql/data
      - ./backend/init.sql:/docker-entrypoint-initdb.d/init.sql
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U loop_user -d loop_db"]
      interval: 5s
      timeout: 3s
      retries: 5
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    container_name: loop_redis
    ports:
      - "6379:6379"
    volumes:
      - loop_redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s
      timeout: 3s
      retries: 5
    restart: unless-stopped

volumes:
  loop_postgres_data:
  loop_redis_data:
```

---

## 5. PostgreSQL Database Schema (Full Relational DDL)

```sql
create extension if not exists "pgcrypto";

-- 1. Users table (Auth & Identity)
create table users (
    id uuid primary key default gen_random_uuid(),
    handle varchar(32) unique not null check (handle ~ '^[a-zA-Z0-9_]{3,32}$'),
    email varchar(255) unique not null,
    password_hash varchar(255) not null,
    display_name varchar(64) not null,
    bio varchar(280) default '',
    custom_status varchar(64) default '',
    allow_dms_from varchar(16) default 'all' check (allow_dms_from in ('all', 'mutuals')),
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);
create index idx_users_handle on users(handle);

-- 2. Follows Graph
create table follows (
    follower_id uuid not null references users(id) on delete cascade,
    following_id uuid not null references users(id) on delete cascade,
    created_at timestamptz default now(),
    primary key (follower_id, following_id)
);
create index idx_follows_following on follows(following_id);

-- 3. Posts & Thread Replies
create table posts (
    id uuid primary key default gen_random_uuid(),
    author_id uuid not null references users(id) on delete cascade,
    content text not null check (char_length(content) >= 1 and char_length(content) <= 300),
    parent_id uuid references posts(id) on delete cascade,       -- NULL for top-level post, UUID for reply
    repost_of_id uuid references posts(id) on delete cascade,   -- NULL unless pure repost
    is_pinned boolean default false,
    edited_at timestamptz,
    created_at timestamptz default now()
);
create index idx_posts_author_created on posts(author_id, created_at desc);
create index idx_posts_parent_id on posts(parent_id) where parent_id is not null;
create index idx_posts_created_at on posts(created_at desc);

-- 4. Likes
create table likes (
    user_id uuid not null references users(id) on delete cascade,
    post_id uuid not null references posts(id) on delete cascade,
    created_at timestamptz default now(),
    primary key (user_id, post_id)
);
create index idx_likes_post on likes(post_id);

-- 5. Bookmarks
create table bookmarks (
    user_id uuid not null references users(id) on delete cascade,
    post_id uuid not null references posts(id) on delete cascade,
    created_at timestamptz default now(),
    primary key (user_id, post_id)
);
create index idx_bookmarks_user on bookmarks(user_id, created_at desc);

-- 6. Post Emoji Reactions
create table post_reactions (
    id uuid primary key default gen_random_uuid(),
    post_id uuid not null references posts(id) on delete cascade,
    user_id uuid not null references users(id) on delete cascade,
    emoji varchar(8) not null,
    created_at timestamptz default now(),
    unique (post_id, user_id, emoji)
);
create index idx_post_reactions_post on post_reactions(post_id);

-- 7. Conversations (Direct Messages & Channels)
create table conversations (
    id uuid primary key default gen_random_uuid(),
    is_group boolean default false,
    title varchar(64),
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);
create index idx_conversations_updated on conversations(updated_at desc);

-- 8. Conversation Members
create table conversation_members (
    conversation_id uuid not null references conversations(id) on delete cascade,
    user_id uuid not null references users(id) on delete cascade,
    is_pinned boolean default false,
    is_muted boolean default false,
    joined_at timestamptz default now(),
    last_read_at timestamptz default now(),
    primary key (conversation_id, user_id)
);
create index idx_conv_members_user on conversation_members(user_id);

-- 9. Direct Messages
create table messages (
    id uuid primary key default gen_random_uuid(),
    conversation_id uuid not null references conversations(id) on delete cascade,
    sender_id uuid not null references users(id) on delete cascade,
    content text not null check (char_length(content) >= 1 and char_length(content) <= 2000),
    quoted_message_id uuid references messages(id) on delete set null,
    is_read boolean default false,
    edited_at timestamptz,
    created_at timestamptz default now()
);
create index idx_messages_conv_created on messages(conversation_id, created_at asc);

-- 10. Voice Channels (Discord-Style Persistent Audio Rooms)
create table voice_channels (
    id uuid primary key default gen_random_uuid(),
    name varchar(64) not null,
    topic varchar(255) default '',
    created_at timestamptz default now()
);

create table voice_channel_participants (
    channel_id uuid not null references voice_channels(id) on delete cascade,
    user_id uuid not null references users(id) on delete cascade,
    joined_at timestamptz default now(),
    primary key (channel_id, user_id)
);
create index idx_voice_participants_channel on voice_channel_participants(channel_id);
```

---

## 6. Real-Time WebSocket & Voice Channel Protocols

### 6.1 Sub-20ms Text Chat Dispatch (Redis Pub/Sub)
```mermaid
sequenceDiagram
    autonumber
    actor Alice as Alice (Client A)
    participant WS as FastAPI WebSocket Server
    participant Redis as Redis Pub/Sub Bus
    actor Bob as Bob (Client B)

    Alice->>WS: JSON: { "type": "chat:send", "temp_id": "tmp-1", "conversation_id": "conv-123", "content": "Hey Bob!" }
    WS->>WS: Authenticate user & asyncpg persist to PostgreSQL
    WS->>Redis: PUBLISH channel "chat:conv-123" payload
    Redis-->>WS: Broadcast to connected socket subscribers
    WS-->>Bob: Push JSON: { "type": "chat:new", "id": "msg-999", "conversation_id": "conv-123", "sender": { "handle": "alice" }, "content": "Hey Bob!" }
    WS-->>Alice: Ack JSON: { "type": "chat:ack", "temp_id": "tmp-1", "id": "msg-999", "status": "sent" }
```

### 6.2 Discord-Style Voice Channel Flow (LiveKit SFU)
```mermaid
sequenceDiagram
    autonumber
    actor User as User (Client)
    participant API as FastAPI Backend
    participant LiveKit as LiveKit SFU (WebRTC)
    participant Redis as Redis Pub/Sub

    User->>API: POST /api/v1/voice/channels/{id}/join
    API->>API: Add to voice_channel_participants & mint LiveKit JWT token
    API->>Redis: PUBLISH "voice:channel:{id}" { event: "user_joined", user_id: "..." }
    API-->>User: Return { room_name: "channel-123", token: "jwt_token" }
    User->>LiveKit: Connect WebRTC stream over UDP (Opus 48kHz)
    LiveKit<<-->>User: Bi-directional sub-40ms audio with active speaker detection
    Note over User,LiveKit: If network drops, client triggers instant ICE Restart in <500ms
```

---

## 7. Step-by-Step Build & Verification Sequence

1. **Scaffold Container Infrastructure**: Create `frontend/`, `backend/`, `init.sql`, and `docker-compose.yml` with all 5 services (`frontend`, `backend`, `livekit`, `db`, `redis`).
2. **Implement FastAPI Backend**:
   - AsyncPG connection pool & JWT authentication.
   - REST endpoints for Feed/Posts/Likes/Reposts/Bookmarks/Search.
   - Native WebSocket connection hub with Redis Pub/Sub.
   - Voice channel endpoints (`GET /voice/channels`, `POST /voice/channels/{id}/join`, `POST /voice/channels/{id}/leave`) with LiveKit token minting.
3. **Build Next.js 15 Monochrome + Apple Blue & Bright Green UI**:
   - `globals.css` with solid surface ladder, hairline tokens, Modern Apple Blue (`#007aff`), and Bright Apple Green (`#30d158`).
   - Spatial App Shell: Left floating icon rail, center focus stream, contextual right dock.
   - Micro-Composer with character counter ring and Apple Blue `Post` button (`Cmd+Enter`).
   - Post cards with vertical sliding numeric tickers, threaded replies, and emoji reactions.
   - Discord-fast split-pane DM interface with WhatsApp delivery ticks (`✓`, `✓✓`, blue `✓✓`), typing indicators, and presence.
   - User profile pages with tabbed timelines (`Thoughts`, `Replies`, `Likes`, `Bookmarks`).
   - Quick Command Palette (`Cmd+K`) and keyboard navigation (`j`/`k`, `n`, `c`, `m`, `d`, `Esc`, `/`).
4. **Implement Discord Voice Channels**:
   - `VoiceDock.tsx` persistent floating bottom dock with live ping, mute, deafen, and disconnect controls.
   - Voice channel list showing active participants and live **Bright Green speaking indicator rings**.
   - Fast auto-reconnect and ICE restart on network jitter / Wi-Fi drops.
   - WebRTC audio hook using `@livekit/components-react` with Opus codec @ 48kHz.
   - Per-user volume sliders (0–200%) and Push-to-Talk / VAD noise suppression.
5. **End-to-End Verification**:
   - Run `docker compose up --build` and verify all 5 containers pass healthchecks.
   - Test sub-20ms WebSocket message delivery between two separate browser windows.
   - Test joining a voice channel, verify live speaking glowing rings, mute/deafen hotkeys, and persistent audio while browsing the feed.
   - Test network interruption simulation (temporary socket disconnect) and verify automatic reconnection in <500ms.
   - Verify keyboard navigation and responsive design across desktop and mobile viewports.
