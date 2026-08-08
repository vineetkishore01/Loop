# ⚡ Project LOOP — API & Data Contracts Specification

> Complete TypeScript Interfaces, FastAPI Pydantic v2 Models, and WebSocket Message Envelopes for the Mutual Friend System.

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
  friendsCount: number;
  thoughtsCount: number;
  friendshipStatus: 'none' | 'pending_sent' | 'pending_received' | 'friends';
  isOnline?: boolean;
  createdAt: string;
}

export interface FriendRequest {
  id: string;
  sender: User;
  receiver: User;
  status: 'pending' | 'accepted' | 'declined';
  createdAt: string;
}

export interface Post {
  id: string;
  authorId: string;
  author: {
    id: string;
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
  friend?: User;
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

# Friend Requests
class FriendRequestCreate(BaseModel):
    targetUserId: UUID

class FriendRequestAction(BaseModel):
    requestId: UUID
    action: str = Field(..., pattern=r"^(accept|decline|cancel)$")

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
