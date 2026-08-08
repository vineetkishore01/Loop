-- ⚡ Project LOOP — Production-Grade Seed Data Kit
-- Populates the platform with 6 realistic personas, thoughts, threads, DMs, and voice channels.

-- 1. Insert Seed Users (Password for all: 'loop_secret_123' hashed with bcrypt)
INSERT INTO users (id, handle, email, password_hash, display_name, bio, custom_status, allow_dms_from) VALUES
('00000000-0000-0000-0000-000000000001', 'alex', 'alex@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'Alexander Wright', 'Building high-performance social tools. Obsessed with mechanical keyboards, monochrome UX, and sub-10ms latency.', '💬 "building loop"', 'all'),
('00000000-0000-0000-0000-000000000002', 'sarah', 'sarah@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'Sarah Connor', 'Systems engineer & distributed systems nerd. Rust + async I/O. Coffee enthusiast.', '⚡ "optimizing uvloop"', 'all'),
('00000000-0000-0000-0000-000000000003', 'david', 'david@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'David Kim', 'UI/UX architect. Zero glassmorphism advocate. Clean solid surfaces with 1px hairlines.', '🎨 "crafting dark mode"', 'all'),
('00000000-0000-0000-0000-000000000004', 'elena', 'elena@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'Elena Rostova', 'WebRTC audio engineer. Studio voice streaming, Opus codec & LiveKit SFU.', '🎧 "in the studio"', 'all'),
('00000000-0000-0000-0000-000000000005', 'marcus', 'marcus@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'Marcus Vance', 'Minimalist text purist. If it requires an image upload, you can describe it better in words.', '✍️ "writing thoughts"', 'all'),
('00000000-0000-0000-0000-000000000006', 'maya', 'maya@loop.social', '$2b$12$K8y4r6l9ZgH2mP1q9x0c1.0JbV8tYvK2x9ZgH2mP1q9x0c10JbV8t', 'Maya Patel', 'Open-source hacker & database tuner. PostgreSQL indexes and Redis pub/sub.', '🚀 "tuning asyncpg"', 'all')
ON CONFLICT (id) DO NOTHING;

-- 2. Follows Graph
INSERT INTO follows (follower_id, following_id) VALUES
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002'),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003'),
('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004'),
('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001')
ON CONFLICT DO NOTHING;

-- 3. Core Thoughts & Nested Thread Replies
INSERT INTO posts (id, author_id, content, parent_id, repost_of_id, is_pinned, created_at) VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Software should feel like mechanical watches: precision, zero bloat, and timeless speed. Pure text with sub-20ms delivery is the antidote to modern internet noise.', NULL, NULL, true, NOW() - INTERVAL '2 hours'),
('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'Async I/O with `asyncpg` and `uvloop` in Python is reaching 20,000 req/sec on modest hardware. When you remove bloated ORMs and multi-megabyte JS bundles, computers are actually blazing fast.', NULL, NULL, false, NOW() - INTERVAL '1 hour'),
('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', 'Why 100% solid monochrome with Apple Blue `#007aff` works: it respects the user’s cognitive focus. Zero blurry glass, zero visual clutter.', NULL, NULL, false, NOW() - INTERVAL '45 minutes'),
('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000004', 'Testing LiveKit SFU with Opus 48kHz. Active speaker rings pulsing bright green with under 35ms latency. Feels like sitting in the same room.', NULL, NULL, false, NOW() - INTERVAL '30 minutes'),
-- Reply to Post 1
('10000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000005', 'Completely agree. High-density text forces people to articulate ideas with clarity instead of hiding behind clickbait thumbnails.', '10000000-0000-0000-0000-000000000001', NULL, false, NOW() - INTERVAL '1 hour 45 minutes'),
-- Nested Reply to Post 5
('10000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'Exactly Marcus. That is the entire philosophy of LOOP.', '10000000-0000-0000-0000-000000000005', NULL, false, NOW() - INTERVAL '1 hour 30 minutes')
ON CONFLICT (id) DO NOTHING;

-- 4. Likes & Reactions
INSERT INTO likes (user_id, post_id) VALUES
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002')
ON CONFLICT DO NOTHING;

INSERT INTO post_reactions (post_id, user_id, emoji) VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', '🔥'),
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003', '⚡'),
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000004', '🚀')
ON CONFLICT DO NOTHING;

-- 5. Persistent Discord-Style Voice Channels
INSERT INTO voice_channels (id, name, topic) VALUES
('20000000-0000-0000-0000-000000000001', 'general-lounge', 'Open casual voice hangout for community members.'),
('20000000-0000-0000-0000-000000000002', 'builders', 'Architecture discussions, systems programming, and performance tuning.'),
('20000000-0000-0000-0000-000000000003', 'deep-work', 'Quiet focus room (mic muted by default, ambient presence).')
ON CONFLICT (id) DO NOTHING;

-- 6. Direct Message Conversations & WhatsApp-Style Receipts
INSERT INTO conversations (id, is_group, title) VALUES
('30000000-0000-0000-0000-000000000001', false, NULL)
ON CONFLICT (id) DO NOTHING;

INSERT INTO conversation_members (conversation_id, user_id, is_pinned) VALUES
('30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', true),
('30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', true)
ON CONFLICT DO NOTHING;

INSERT INTO messages (id, conversation_id, sender_id, content, is_read, created_at) VALUES
('40000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Hey Alex! Did you finish benchmarks on the new LiveKit WebRTC SFU?', true, NOW() - INTERVAL '10 minutes'),
('40000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Yes! Opus @ 48kHz is streaming at 32ms ping. See you in the lounge!', true, NOW() - INTERVAL '8 minutes')
ON CONFLICT (id) DO NOTHING;
