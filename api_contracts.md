# ⚡ Project LOOP — API & Data Contracts Specification

> Complete TypeScript Interfaces, FastAPI Pydantic v2 Models, and WebSocket Message Envelopes.

---

## 1. Core TypeScript Data Models (`frontend/types/index.ts`)

```typescript
export interface User {
  id: string;
  handle: string;
  email: string;
  displayName: string;
  bio: string;
  customStatus: string;
  allowDmsFrom: 'all' | 'mutuals';
  allowCallsFrom?: 'all' | 'mutuals';
  followersCount: number;
  followingCount: number;
  thoughtsCount: number;
  isFollowing?: boolean;
  isOnline?: boolean;
  createdAt: string;
}

export interface Post {
  id: string;
  authorId: string;
  author: {
    handle: string;
    displayName: string;
    customStatus?: string;
  };
  content: string;
  parentId?: string | null;
  repostOfId?: string | null;
  repostOf?: Post | null;
  isPinned: boolean;
  likesCount: number;
  repostsCount: number;
  repliesCount: number;
  hasLiked: boolean;
  hasReposted: boolean;
  hasBookmarked: boolean;
  reactions: Record<string, number>;
  userReaction?: string | null;
  editedAt?: string | null;
  createdAt: string;
}

export interface Message {
  id: string;
  conversationId: string;
  senderId: string;
  sender: {
    handle: string;
    displayName: string;
  };
  content: string;
  quotedMessageId?: string | null;
  quotedMessage?: {
    id: string;
    senderHandle: string;
    content: string;
  } | null;
  status: 'sending' | 'sent' | 'delivered' | 'read';
  createdAt: string;
}

export interface Conversation {
  id: string;
  isGroup: boolean;
  title?: string | null;
  isPinned: boolean;
  isMuted: boolean;
  unreadCount: number;
  otherUser?: User;
  lastMessage?: Message;
  updatedAt: string;
}

export interface VoiceChannel {
  id: string;
  name: string;
  topic: string;
  activeParticipants: {
    userId: string;
    handle: string;
    displayName: string;
    isSpeaking: boolean;
    isMuted: boolean;
    isDeafened: boolean;
  }[];
  createdAt: string;
}

export interface AudioDeviceSettings {
  inputDeviceId: string;
  outputDeviceId: string;
  inputVolume: number; // 0 to 100
  outputVolume: number; // 0 to 100
  inputSensitivity: number; // -100dB to 0dB
  autoSensitivity: boolean;
  echoCancellation: boolean;
  noiseSuppression: boolean;
  autoGainControl: boolean;
}
```

---

## 2. FastAPI Pydantic v2 Models (`backend/app/models/schemas.py`)

```python
from pydantic import BaseModel, Field, EmailStr
from typing import Optional, List, Dict
from datetime import datetime
from uuid import UUID

# Auth Schemas
class UserRegister(BaseModel):
    handle: str = Field(..., min_length=3, max_length=32, pattern=r"^[a-zA-Z0-9_]+$")
    email: EmailStr
    password: str = Field(..., min_length=8)
    displayName: str = Field(..., min_length=1, max_length=64)

class UserLogin(BaseModel):
    handleOrEmail: str
    password: str

class TokenResponse(BaseModel):
    accessToken: str
    tokenType: str = "bearer"
    user: Dict

# Post Schemas
class PostCreate(BaseModel):
    content: str = Field(..., min_length=1, max_length=300)
    parentId: Optional[UUID] = None
    repostOfId: Optional[UUID] = None

class PostEdit(BaseModel):
    content: str = Field(..., min_length=1, max_length=300)

class ReactionToggle(BaseModel):
    emoji: str = Field(..., max_length=8)

# Message & Chat Schemas
class MessageSend(BaseModel):
    conversationId: UUID
    content: str = Field(..., min_length=1, max_length=2000)
    quotedMessageId: Optional[UUID] = None

# Voice Channel Schemas
class VoiceChannelCreate(BaseModel):
    name: str = Field(..., min_length=2, max_length=64)
    topic: Optional[str] = Field(default="", max_length=255)

class VoiceTokenResponse(BaseModel):
    roomName: str
    token: str
    wsUrl: str
```

---

## 3. WebSocket Event JSON Framing

### Client -> Server Events:
```json
// 1. Send Message
{
  "type": "chat:send",
  "tempId": "tmp-uuid-1",
  "conversationId": "conv-uuid-123",
  "content": "Building LOOP with sub-20ms latency!",
  "quotedMessageId": null
}

// 2. Typing Ping
{
  "type": "chat:typing",
  "conversationId": "conv-uuid-123"
}

// 3. Mark Read
{
  "type": "chat:read",
  "conversationId": "conv-uuid-123",
  "messageIds": ["msg-1", "msg-2"]
}

// 4. Voice Speaking State (Broadcast to channel)
{
  "type": "voice:speaking",
  "channelId": "chan-123",
  "isSpeaking": true
}
```

### Server -> Client Broadcasts:
```json
// 1. New Message Push
{
  "type": "chat:new",
  "id": "msg-uuid-999",
  "conversationId": "conv-uuid-123",
  "sender": {
    "id": "user-uuid-1",
    "handle": "alex",
    "displayName": "Alexander"
  },
  "content": "Building LOOP with sub-20ms latency!",
  "status": "delivered",
  "createdAt": "2026-08-09T01:50:00Z"
}

// 2. Message ACK (Updates temporary message to permanent)
{
  "type": "chat:ack",
  "tempId": "tmp-uuid-1",
  "id": "msg-uuid-999",
  "status": "sent"
}

// 3. Read Status Update (Turns double tick blue)
{
  "type": "chat:read_receipt",
  "conversationId": "conv-uuid-123",
  "readByUserId": "user-uuid-2",
  "readAt": "2026-08-09T01:50:02Z"
}
```
