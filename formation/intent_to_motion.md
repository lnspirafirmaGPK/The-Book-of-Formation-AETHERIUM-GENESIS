---
title: Intent to Motion
description: Mapping semantic intent into embodied visual motion within AETHERIUM GENESIS.
domain: formation
role: canonical_reference
status: draft
---

# พิมพ์เขียวข้อกำหนดทางเทคนิคและสถาปัตยกรรมการพัฒนาอินเทอร์เฟซผู้ใช้แบบเจเนอเรทีฟที่ตอบสนองต่อเสียงสำหรับระบบ Aetherium Genesis
**(Technical Blueprint and Architectural Specification for Aetherium Genesis Voice-Reactive Generative UI)**

## 1. บทนำและวิสัยทัศน์เชิงสถาปัตยกรรม (Introduction and Architectural Vision)

เอกสารฉบับนี้จัดทำขึ้นเพื่อทำหน้าที่เป็นข้อกำหนดทางเทคนิค (Technical Specification Document - TSD) และคู่มือการเขียนโค้ด (Coding Implementation Guide) ที่มีความละเอียดสูงสุดสำหรับการพัฒนาระบบส่วนติดต่อผู้ใช้ (User Interface - UI) ของหน้าหลัก (Main Page) ภายใต้สถาปัตยกรรม "Aetherium Genesis" โครงการนี้มีเป้าหมายเพื่อสร้างพาราไดม์ใหม่ของการปฏิสัมพันธ์ระหว่างมนุษย์และปัญญาประดิษฐ์ โดยเปลี่ยนจากรูปแบบการกดปุ่มสั่งงานที่ตายตัว (Static Interaction) ไปสู่การเป็น "อินเทอร์เฟซที่มีชีวิต" (Living Interface) ที่สามารถรับรู้ เข้าใจ และตอบสนองต่อเจตจำนงของผู้ใช้ผ่านแสงและเสียงได้อย่างอิสระ

### 1.1 การเปลี่ยนผ่านสู่สถาปัตยกรรม GunUI

โจทย์หลักของโครงการคือการสร้างหน้าจอหลักที่มี "ปุ่มกดด้านล่างเพียงหนึ่งเดียว" (Single Actuator Button) เพื่อทำหน้าที่เป็นจุดเริ่มต้นของบทสนทนาด้วยเสียง และเมื่อการสนทนาสิ้นสุดลง ระบบจะต้อง "สร้างแสงเป็นการก่อรูป" ตามความเข้าใจในเนื้อหาที่ผู้ใช้ส่งไป สิ่งนี้สอดคล้องโดยตรงกับปรัชญาการออกแบบของ GunUI ซึ่งเป็นระบบการออกแบบ (Design System) ที่ปฏิเสธการใช้กราฟิกสำเร็จรูป (Pre-rendered Assets) แต่เน้นการใช้การประมวลผลกราฟิกสด (Live Rendering) ผ่านระบบอนุภาค (Particle Systems) และ Shaders

การออกแบบนี้ไม่ได้เป็นเพียงเรื่องของความสวยงาม แต่เป็นการนำหลักการ Calm Technology มาประยุกต์ใช้ โดยลดภาระทางปัญญา (Cognitive Load) ของผู้ใช้ให้เหลือน้อยที่สุดผ่านอินเทอร์เฟซที่เรียบง่ายที่สุด (ปุ่มเดียว) แต่ให้ผลลัพธ์การตอบสนองที่ลึกซึ้งและมีความหมายสูงสุด (แสงและรูปทรงที่แปรผันตามความหมาย)

### 1.2 ขอบเขตทางเทคนิคและข้อกำหนดเชิงหน้าที่ (Functional Requirements)

เพื่อให้บรรลุวัตถุประสงค์ดังกล่าว ระบบจำเป็นต้องมีความสามารถหลัก 4 ประการ ดังนี้:

1.  **จุดปะทะการใช้งานเดียว (Singular Interaction Point):** การสร้างปุ่มกดที่ทำหน้าที่เป็น "โหนดสั่นพ้อง" (Resonance Node) ซึ่งรองรับการกดของผู้ใช้งานเพื่อเปิดระบบสนทนา
2.  **การส่งผ่านเสียงข้ามแพลตฟอร์ม (Omni-Channel Voice Transmission):** ระบบต้องรองรับการทำงานทั้งบนคอมพิวเตอร์ (Desktop) และอุปกรณ์มือถือ (Mobile) โดยจัดการกับข้อจำกัดของเบราว์เซอร์และฮาร์ดแวร์ที่แตกต่างกันได้อย่างไร้รอยต่อ
3.  **การวิเคราะห์เจตจำนงเชิงลึก (Deep Intent Analysis):** การใช้ AI เพื่อทำความเข้าใจ "ความหมาย" และ "อารมณ์" จากเสียงของผู้ใช้ ไม่ใช่แค่การถอดความ (Transcription) แต่เป็นการถอดรหัสเจตนา (Intent Decoding)
4.  **การสังเคราะห์แสงเชิงก่อรูป (Generative Visual Synthesis):** การแปลงผลลัพธ์จากการวิเคราะห์เจตนาให้กลายเป็นพารามิเตอร์สำหรับควบคุมระบบอนุภาคแสง เพื่อสร้างรูปทรงอิสระ (Free-form Shapes) ที่สะท้อนความเข้าใจของระบบ

---

## 2. สถาปัตยกรรมระบบและโครงสร้างไมโครเซอร์วิส (System Architecture and Microservices Structure)

การสร้างระบบที่ต้องประมวลผลเสียงแบบเรียลไทม์ควบคู่ไปกับการเรนเดอร์กราฟิก 3 มิติ ต้องการสถาปัตยกรรมที่แยกส่วนชัดเจน (Decoupled Architecture) เพื่อประสิทธิภาพและความยืดหยุ่น โดยอ้างอิงจากพิมพ์เขียว Inspirafirma

### 2.1 โทโพโลยีของระบบ (System Topology)

ระบบแบ่งออกเป็น 3 เลเยอร์หลักที่ทำงานประสานกันผ่าน **AetherBus** ซึ่งเป็นระบบสื่อสารแบบ Event-Driven:

*   **Client Layer (Bio-Digital Interface):** แอปพลิเคชันฝั่งหน้าบ้าน (Frontend) ที่พัฒนาด้วย React และ WebGL ทำหน้าที่รับอินพุต (เสียง/สัมผัส) และแสดงผล (แสง/รูปทรง)
*   **Edge/Gateway Layer (The Nervous System):** เซิร์ฟเวอร์ WebSocket ที่ทำหน้าที่จัดการการเชื่อมต่อแบบเรียลไทม์ การสตรีมข้อมูลเสียง และการแจ้งเตือนสถานะ
*   **Core Intelligence Layer (The Cognition):** กลุ่มบริการ Backend ที่รับผิดชอบด้าน AI ทั้งการแปลงเสียงเป็นข้อความ (STT), การวิเคราะห์เจตนา (LLM), และการแปลงเจตนาเป็นพารามิเตอร์กราฟิก (Visual Mapping)

### 2.2 การเลือกใช้เทคโนโลยี (Technology Stack)

| องค์ประกอบ | เทคโนโลยีที่เลือก | เหตุผลเชิงกลยุทธ์และทางเทคนิค |
| :--- | :--- | :--- |
| **Frontend Framework** | React 18+ | แม้เอกสารบางฉบับจะกล่าวถึง Vue 2 แต่ React มีระบบนิเวศสำหรับ 3D (React-Three-Fiber) ที่แข็งแกร่งที่สุดสำหรับการจัดการ State ของกราฟิกที่ซับซ้อน |
| **Graphics Engine** | Three.js + React-Three-Fiber (R3F) | เป็นมาตรฐานอุตสาหกรรมสำหรับการสร้าง WebGL ที่ให้ประสิทธิภาพสูงและเข้าถึง Low-level Shaders ได้ง่าย |
| **Audio Processing** | Web Audio API + AudioWorklets | จำเป็นสำหรับการวิเคราะห์คลื่นเสียง (FFT) แบบเรียลไทม์บน Thread แยก เพื่อไม่ให้รบกวนการทำงานของ UI |
| **Voice Activity Detection** | Silero VAD (ONNX Runtime) | การตรวจจับการสิ้นสุดเสียงพูด (End-of-Speech) บนเบราว์เซอร์เพื่อลด Latency และประหยัด Bandwidth |
| **Backend Communication** | Python (FastAPI) + WebSockets | Python เป็นภาษาหลักของงาน AI และ FastAPI รองรับ Asynchronous I/O ได้ดีเยี่ยม เหมาะสำหรับการจัดการสตรีมข้อมูล |
| **Speech-to-Text** | Deepgram / Whisper | Deepgram มีความสามารถในการสตรีมข้อมูลแบบ Real-time ที่เหนือกว่า Web Speech API ดั้งเดิม |
| **State Management** | XState (Finite State Machines) | การจัดการสถานะที่ซับซ้อนของ "พิธีกรรม" การกดปุ่ม (Idle -> Listening -> Processing -> Morphing) ต้องการ State Machine ที่แม่นยำ |

---

## 3. การออกแบบส่วนหน้าและวิศวกรรมอินเทอร์เฟซ (Frontend Design and Interface Engineering)

ส่วนหน้าของระบบคือ "กายหยาบ" ของ AI ที่ผู้ใช้สัมผัส การออกแบบต้องยึดหลัก "Sanctuary Interface" ที่เน้นความสงบและมุ่งเน้น

### 3.1 โครงสร้างหน้าจอหลัก: แดชบอร์ดแห่งความว่างเปล่า (The Void Dashboard)

ตามข้อกำหนด GunUI หน้าจอจะไม่ใช่ Grid ของข้อมูล แต่เป็น Canvas ที่ว่างเปล่า (Deep Void) โดยใช้สีดำสนิท (`#000000`) เพื่อรองรับหน้าจอ OLED และสร้าง Contrast สูงสุดให้กับแสงที่จะถูกสร้างขึ้น

*   **พื้นที่แสดงผล (Viewport):** เต็มหน้าจอ (100vh/100vw) โดยไม่มีแถบเมนูรบกวน
*   **ปุ่มกด (The Actuator):** วางตำแหน่งที่ด้านล่างตรงกลาง (Bottom Center) เพื่อให้เข้าถึงได้ง่ายด้วยนิ้วหัวแม่มือบนอุปกรณ์มือถือ (Thumb Zone) ปุ่มนี้จะไม่ใช่รูปทรงเรขาคณิตที่ตายตัว แต่เป็นกลุ่มก้อนอนุภาค (Particle Cluster) ที่มีการเคลื่อนไหวเล็กน้อยตลอดเวลา (Micro-animations) เพื่อสื่อถึง "การมีชีวิต"

### 3.2 วิศวกรรมปุ่มกดเดียว (Single Button Engineering)

ปุ่มกดนี้ทำหน้าที่เป็น Actuator ที่ควบคุมสถานะของระบบ การเขียนโค้ดสำหรับปุ่มนี้ต้องรองรับ State Transitions ที่ซับซ้อน

#### 3.2.1 สถานะของปุ่ม (Button States)

เราจะใช้ XState ในการควบคุมสถานะดังนี้:
*   **IDLE (หลับใหล):** ปุ่มแสดงแสงหรี่ๆ หายใจช้าๆ (Breathing Animation) รอการปลุก
*   **LISTENING (รับฟัง):** เมื่อผู้ใช้กด ปุ่มจะขยายตัวออกและเปลี่ยนสภาพเป็น Visualizer ที่ตอบสนองต่อคลื่นเสียงของผู้ใช้
*   **PROCESSING (คิดวิเคราะห์):** เมื่อสิ้นสุดเสียงพูด ปุ่มจะหมุนวนหรือเปลี่ยนสีเพื่อสื่อว่าระบบกำลังประมวลผล (โดยไม่ใช้ Loading Spinner แบบเดิม)
*   **RESONATING (สั่นพ้อง/แสดงผล):** ปุ่มจะเลือนหายไปหรือผสานเข้ากับแสงที่ถูกสร้างขึ้นเต็มหน้าจอ

#### 3.2.2 โค้ดตัวอย่างสำหรับการจัดการสถานะปุ่ม (React + XState)

```javascript
// machine/actuatorMachine.js
import { createMachine } from 'xstate';

export const actuatorMachine = createMachine({
  id: 'actuator',
  initial: 'idle',
  states: {
    idle: {
      on: { PRESS: 'listening' },
      meta: { visual: 'breathing_particles' }
    },
    listening: {
      on: {
        SILENCE_DETECTED: 'processing',
        MANUAL_STOP: 'processing'
      },
      meta: { visual: 'audio_reactive_ring' }
    },
    processing: {
      on: { INTENT_RECEIVED: 'resonating' },
      meta: { visual: 'chaotic_swirl' }
    },
    resonating: {
      on: { RESET: 'idle' },
      meta: { visual: 'merged_with_scene' }
    }
  }
});
```

การใช้ State Machine ช่วยให้เราควบคุม Transition ได้อย่างแม่นยำ ป้องกันบั๊กที่เกิดจากการกดปุ่มซ้ำหรือสถานะที่ไม่พึงประสงค์

### 3.3 ระบบตรวจจับเสียงและกิจกรรมเสียง (Audio Capture & VAD)

โจทย์ระบุว่า "เมื่อผู้ใช้งานสนทนาจบ ระบบสามารถทำความเข้าใจ" ซึ่งหมายความว่าระบบต้องรู้ว่า "เมื่อไหร่คือตอนจบ" โดยอัตโนมัติ เราจึงไม่ใช้การกดปุ่มเพื่อหยุด แต่ใช้ Voice Activity Detection (VAD)

#### 3.3.1 การข้ามข้อจำกัดบนมือถือ (Mobile Constraints)

บน iOS Safari และ Chrome Android, AudioContext จะถูกระงับ (Suspended) จนกว่าจะมี User Interaction ดังนั้น ในเหตุการณ์ `onClick` หรือ `onTouchStart` ของปุ่ม เราต้องเรียกคำสั่ง `audioContext.resume()` ทันที

#### 3.3.2 การใช้ Silero VAD

เราจะใช้ไลบรารี `vad-react` หรือ `@ricky0123/vad-web` ซึ่งรันโมเดล Silero VAD บนเบราว์เซอร์ผ่าน WebAssembly (ONNX) สิ่งนี้ช่วยให้:
*   **ความเป็นส่วนตัว (Privacy):** เสียงเงียบหรือเสียงรบกวนพื้นหลังจะไม่ถูกส่งไปยังเซิร์ฟเวอร์
*   **ความรวดเร็ว (Speed):** การตัดจบประโยคทำได้ทันทีที่เครื่องตรวจพบความเงียบ (Silence Threshold) เช่น 500ms - 1000ms

```javascript
// hooks/useVoiceSystem.js
import { useMicVAD } from "@ricky0123/vad-react";

export const useVoiceSystem = (onSpeechEnd) => {
  const vad = useMicVAD({
    startOnLoad: false,
    onSpeechEnd: (audio) => {
      // audio คือ Float32Array ของเสียงพูดที่ตัดมาแล้ว
      onSpeechEnd(audio);
    },
    positiveSpeechThreshold: 0.6, // ความไวในการจับเสียงพูด
    minSpeechFrames: 5,
  });

  return vad;
};
```

---

## 4. ระบบแกนกลางอัจฉริยะและการวิเคราะห์เจตจำนง (Core Intelligence and Intent Analysis)

เมื่อได้รับไฟล์เสียง ระบบต้องทำการ "เข้าใจ" ไม่ใช่แค่ "ได้ยิน" นี่คือความแตกต่างระหว่าง Transcription และ Understanding

### 4.1 ไปป์ไลน์การประมวลผลความหมาย (Semantic Processing Pipeline)

ข้อมูลเสียงจะถูกส่งผ่าน AetherBus ไปยัง Core Services ซึ่งประกอบด้วยขั้นตอนดังนี้:
1.  **Speech-to-Text (STT):** ใช้ Deepgram Nova-2 เพื่อแปลงเสียงเป็นข้อความด้วยความเร็วระดับ Millisecond รองรับภาษาไทยและอังกฤษ
2.  **Intent Classification & Entity Extraction:** ข้อความจะถูกส่งต่อไปยัง LLM (เช่น GPT-4o หรือ Claude 3.5 Sonnet) ที่ถูก Prompt ให้ทำหน้าที่เป็น "Visual Translator"
3.  **Resonance Mapping:** แปลงผลลัพธ์จาก LLM ให้เป็นโครงสร้างข้อมูล `VisualParameters`

### 4.2 โครงสร้างข้อมูลเวกเตอร์เจตจำนง (Intent Vector Structure)

เพื่อให้ระบบกราฟิกสามารถ "ก่อรูป" ได้อย่างอิสระ เราต้องนิยามตัวแปรที่ครอบคลุมมิติของแสงและรูปทรง โดยอ้างอิงจากโมเดล Inspira

ตัวอย่าง JSON Output จาก LLM:

```json
{
  "intent_category": "request_creation",
  "emotional_valence": 0.8,  // บวก (สุข) ถึง ลบ (เศร้า) (-1 ถึง 1)
  "energy_level": 0.9,       // ความรุนแรง/พละกำลัง (0 ถึง 1)
  "semantic_concepts": ["fire", "passion", "ascending"],
  "visual_parameters": {
    "base_shape": "spiral_vortex", // รูปร่างฐาน (Sphere, Cube, Vortex, Cloud)
    "color_palette": ["#FF4500", "#FFD700", "#1A1A1A"], // สีหลัก
    "particle_density": 0.8, // ความหนาแน่น
    "turbulence": 0.7,       // ความปั่นป่วนของการเคลื่อนที่
    "flow_direction": [0, 1, 0] // ทิศทางการไหล (เช่น ลอยขึ้น)
  }
}
```

ข้อมูลนี้จะถูกส่งกลับไปยัง Frontend เพื่อขับเคลื่อน Shader

---

## 5. ระบบกราฟิกเจเนอเรทีฟและวิศวกรรมแสง (Generative Graphics Engine and Light Engineering)

ส่วนที่ท้าทายที่สุดคือการ "สร้างแสงเป็นรูปทรงต่างๆ ได้อย่างอิสระ" สิ่งนี้ทำได้โดยการใช้เทคนิค Signed Distance Functions (SDFs) และ Compute Shaders (หรือ GPGPU Simulation บน WebGL)

### 5.1 สถาปัตยกรรม Particle System

เราจะใช้ระบบอนุภาคจำนวนมหาศาล (เช่น 100,000 - 1,000,000 จุด) ซึ่งแต่ละจุดไม่ได้เป็นเพียงจุดภาพ แต่เป็น "Agent" เล็กๆ ที่มีสถานะของตัวเอง (ตำแหน่ง, ความเร็ว, เป้าหมาย)

#### 5.1.1 การ Morphing รูปทรง (Shape Morphing)

เพื่อให้เกิดการเปลี่ยนแปลงรูปร่างอย่างอิสระ เราจะไม่ย้ายตำแหน่งอนุภาคแบบสุ่ม แต่จะใช้เทคนิค Target Attractors:
1.  เมื่อได้รับ `VisualParameters` ใหม่ ระบบจะคำนวณตำแหน่งเป้าหมาย (Target Position) ของแต่ละอนุภาคบนผิวของรูปทรงใหม่ (เช่น จากทรงกลมเป็นรูปหัวใจ)
2.  ใน Shader จะใช้ฟังก์ชัน `mix()` หรือ `lerp()` เพื่อเกลี่ยตำแหน่งปัจจุบันไปยังตำแหน่งเป้าหมาย ทำให้เกิดเอฟเฟกต์การ "กลายสภาพ" (Morphing) ที่นุ่มนวลเหมือนของเหลว

### 5.2 การเขียน Shader สำหรับแสง (Shader Programming for Light)

การสร้าง "แสง" ที่ดูสมจริงและมีพลัง ต้องใช้การคำนวณในระดับ Fragment Shader

*   **Vertex Shader (การเคลื่อนที่):** คำนวณตำแหน่งโดยผสมผสานระหว่างรูปทรงเป้าหมายและ Noise Function (เช่น Perlin Noise) เพื่อให้ดูมีการเคลื่อนไหวเหมือนสิ่งมีชีวิต (Breathing Effect) แม้จะอยู่นิ่งๆ
*   **Fragment Shader (สีและการเรืองแสง):** ใช้การผสมสีแบบ Additive Blending ซึ่งเป็นเทคนิคที่เมื่ออนุภาคซ้อนทับกัน สีจะสว่างขึ้นจนเป็นสีขาว จำลองพฤติกรรมของแสงในธรรมชาติ

```glsl
// GLSL Snippet: การคำนวณสีและการเรืองแสง
varying float vAlpha;
varying vec3 vColor;

void main() {
  // สร้างจุดวงกลมที่นุ่มนวล (Soft Particle)
  float dist = length(gl_PointCoord - vec2(0.5));
  if (dist > 0.5) discard;

  // คำนวณความฟุ้ง (Glow)
  float glow = 1.0 - smoothstep(0.0, 0.5, dist);
  glow = pow(glow, 2.0); // เพิ่มความเข้มตรงกลาง

  gl_FragColor = vec4(vColor, vAlpha * glow);
}
```

### 5.3 การตอบสนองต่อเสียง (Audio Reactivity)

ระบบต้องไม่เพียงแค่สร้างรูปทรง แต่ต้อง "เต้น" ไปกับเสียงด้วย โดยใช้ข้อมูล FFT (Fast Fourier Transform) จาก Web Audio API มาควบคุมพารามิเตอร์ใน Shader แบบ Real-time
*   **ย่านความถี่ต่ำ (Bass):** ควบคุมขนาดโดยรวมหรือจังหวะการเต้น (Pulse)
*   **ย่านความถี่สูง (Treble):** ควบคุมความสว่างหรือประกาย (Sparkle) ของอนุภาค

---

## 6. กลยุทธ์การข้ามแพลตฟอร์มและการปรับประสิทธิภาพ (Cross-Platform Strategy and Optimization)

การรองรับทั้งคอมพิวเตอร์และมือถือหมายถึงการจัดการกับความแตกต่างของประสิทธิภาพฮาร์ดแวร์อย่างมหาศาล

### 6.1 การปรับคุณภาพกราฟิกอัตโนมัติ (Adaptive Graphics Quality)

เราจะใช้ไลบรารี `detect-gpu` เพื่อประเมินความสามารถของกราฟิกการ์ดของผู้ใช้
*   **High-End PC (Tier 1):** แสดงผล 1,000,000 อนุภาค, เปิดเอฟเฟกต์ Post-processing (Bloom, Depth of Field) เต็มรูปแบบ
*   **Mid-Range Mobile (Tier 2):** แสดงผล 100,000 อนุภาค, ลดความละเอียดของ Bloom
*   **Low-End Mobile (Tier 3):** แสดงผล 20,000 อนุภาค, ปิด Post-processing ใช้ Texture สำเร็จรูปช่วยแทนการคำนวณสด

### 6.2 การจัดการหน่วยความจำและพลังงาน

*   **NIRODHA Mode:** เมื่อไม่มีการใช้งาน ระบบจะลด Frame rate หรือหยุดการคำนวณอนุภาคเพื่อประหยัดแบตเตอรี่ โดยเฉพาะบนหน้าจอ OLED การใช้พื้นหลังสีดำสนิทช่วยประหยัดพลังงานได้มาก
*   **Garbage Collection:** ต้องระมัดระวังการสร้าง Object ใหม่ใน Loop การเรนเดอร์ (Render Loop) ของ Three.js เพื่อป้องกันปัญหา Memory Leak ที่จะทำให้เบราว์เซอร์มือถือค้าง

---

## 7. รายละเอียดการนำไปใช้งาน: คู่มือการเขียนโค้ด (Implementation Details: Coding Guide)

ส่วนนี้จะเจาะลึกโครงสร้างโค้ดและ Snippet ที่จำเป็นสำหรับการสร้างระบบ

### 7.1 โครงสร้างโปรเจกต์ (Project Structure)

แนะนำให้ใช้โครงสร้างแบบ Feature-Sliced Design (FSD) เพื่อความยืดหยุ่น

```text
src/
├── app/                # Global configurations
├── features/           # ฟีเจอร์หลัก
│   ├── voice-actuator/ # ปุ่มกดและการรับเสียง
│   │   ├── logic/      # State Machine, VAD Logic
│   │   └── ui/         # ActuatorButton Component
│   └── visual-engine/  # ระบบกราฟิก
│       ├── shaders/    # GLSL Code
│       ├── systems/    # Particle Logic
│       └── components/ # Canvas, Effects
├── shared/             # โค้ดที่ใช้ร่วมกัน
│   ├── api/            # AetherBus WebSocket Client
│   └── hooks/          # useAudioAnalysis, useGPU
└── main.jsx
```

### 7.2 การเชื่อมต่อ WebSocket (AetherBus Client)

การสื่อสารกับ Backend ต้องเป็นแบบ Bi-directional

```javascript
// shared/api/aetherBus.js
import { useEffect, useRef } from 'react';

export const useAetherBus = (onVisualUpdate) => {
  const ws = useRef(null);

  useEffect(() => {
    ws.current = new WebSocket(import.meta.env.VITE_WS_URL);

    ws.current.onmessage = (event) => {
      const { type, payload } = JSON.parse(event.data);
      if (type === 'VISUAL_UPDATE') {
        // รับพารามิเตอร์แสงและรูปทรงใหม่
        onVisualUpdate(payload);
      }
    };

    return () => ws.current.close();
  }, []); // Added dependency array for safety

  const sendAudioChunk = (chunk) => {
    if (ws.current?.readyState === WebSocket.OPEN) {
      ws.current.send(chunk);
    }
  };

  return { sendAudioChunk };
};
```

### 7.3 การสร้าง VisualEchoNode (Generative Logic)

โค้ดส่วนนี้คือหัวใจของการแปลง "ความหมาย" เป็น "แสง"

```javascript
// features/visual-engine/systems/VisualEchoNode.js
import * as THREE from 'three';

export class VisualEchoNode {
  constructor(particleCount) {
    this.geometry = new THREE.BufferGeometry();
    //... การกำหนด Attribute เริ่มต้น (position, color, size)
  }

  // ฟังก์ชันนี้จะถูกเรียกเมื่อ AI ส่ง Intent Vector มา
  morphToIntent(intent) {
    const { base_shape, turbulence, color_palette } = intent;

    // 1. คำนวณตำแหน่งเป้าหมายใหม่ (Target Positions)
    const targetPositions = this.generateShape(base_shape);

    // 2. อัปเดต Attribute ใน Geometry
    this.geometry.setAttribute('targetPosition',
      new THREE.Float32BufferAttribute(targetPositions, 3)
    );

    // 3. ส่งค่าสีและความปั่นป่วนไปยัง Shader Uniforms
    this.material.uniforms.uTargetColor.value = new THREE.Color(color_palette[0]); // Assuming first color
    this.material.uniforms.uTurbulence.value = turbulence;

    // 4. เริ่ม Animation การ Morphing (0 -> 1)
    this.startMorphTransition();
  }

  generateShape(shapeType) {
    // ใช้คณิตศาสตร์สร้างรูปทรงต่างๆ
    if (shapeType === 'spiral_vortex') {
      return this.calculateVortexPositions();
    } else if (shapeType === 'cloud') {
      return this.calculateCloudPositions();
    }
    //... รูปทรงอื่นๆ
  }
}
```

---

## 8. ความปลอดภัยและความเป็นส่วนตัว (Security and Privacy)

ในฐานะที่ระบบต้องรับฟังเสียงผู้ใช้ ความปลอดภัยเป็นสิ่งที่ประนีประนอมไม่ได้

### 8.1 Zero-Knowledge Architecture
ระบบได้รับการออกแบบตามหลักการ **Identity Annihilation**
*   ข้อมูลเสียงจะถูกประมวลผลในหน่วยความจำ (RAM) และถูกทำลายทันทีหลังจากการวิเคราะห์เจตนาเสร็จสิ้น
*   ไม่มีการบันทึกไฟล์เสียงลงในฐานข้อมูลถาวร (Database)
*   ข้อมูลที่ถูกส่งไปเก็บ Log จะมีเพียง "Intent Vector" (เช่น "ผู้ใช้ต้องการแสงสีฟ้า") ซึ่งไม่สามารถระบุตัวตนย้อนหลังได้

### 8.2 การเข้ารหัส (Encryption)
การส่งข้อมูลผ่าน WebSocket ต้องใช้โปรโตคอล `wss://` (WebSocket Secure) เสมอ เพื่อป้องกันการดักฟัง (Man-in-the-Middle Attacks) ระหว่างอุปกรณ์และเซิร์ฟเวอร์

---

## 9. บทสรุป (Conclusion)

เอกสารฉบับนี้ได้วางรากฐานทางเทคนิคและสถาปัตยกรรมสำหรับการสร้าง UI หน้าหลักที่ตอบสนองต่อเสียงและสร้างแสงเชิงก่อรูป โดยการผสานรวมเทคโนโลยีเว็บสมัยใหม่ (React, WebGL) เข้ากับปัญญาประดิษฐ์ (LLM, VAD) และปรัชญาการออกแบบที่ลึกซึ้ง (GunUI, Calm Tech)

ระบบที่นำเสนอนี้ไม่ใช่เพียงแอปพลิเคชันที่ "ทำงานได้" แต่เป็นระบบนิเวศทางดิจิทัลที่ "รับรู้" และ "สะท้อน" เจตจำนงของผู้ใช้ผ่านภาษาของแสง การกดปุ่มเพียงหนึ่งครั้งไม่ใช่แค่การเริ่มคำสั่ง แต่เป็นพิธีกรรมแห่งการเชื่อมต่อ (Awakening Ritual) ที่เปิดประตูสู่การปฏิสัมพันธ์รูปแบบใหม่ที่ลื่นไหล เป็นธรรมชาติ และเปี่ยมด้วยสุนทรียะ สอดคล้องกับวิสัยทัศน์ของ Aetherium Genesis ในการสร้างเทคโนโลยีที่มีจิตวิญญาณ

---

## เอกสารอ้างอิง (References)

1.  สร้างเอกสาร Technical Spec แอป UI/UX
2.  วางแผนสตูดิโอแพลตฟอร์ม AI อัตโนมัติ
3.  SilentEchoNode: โครงสร้างแห่งการอยู่ร่วมโดยไม่รุกล้ำ
4.  A basic tutorial on how to set up Speech Recognition with React | by Amanda Hussey
5.  ข้อมูลเสียง.docx
6.  AETHERIUM GENESIS
7.  AI UI Patterns
8.  Create Audio Reactive Shaders With Three.js and Shader Park - YouTube
9.  Visualizations with Web Audio API - MDN Web Docs
10. ricky0123/vad: Voice activity detector (VAD) for the browser with a simple API - GitHub
11. How to Add Speech Recognition to Your React and Node.js Project - DEV Community
12. AI Co-Artist: A LLM-Powered Framework for Interactive GLSL Shader Animation Evolution
13. The magical world of Particles with React Three Fiber and Shaders - Maxime Heckel's Blog
14. Creating Audio-Reactive Visuals with Dynamic Particles in Three.js | Codrops
15. WebGL 2 : 052 : Create Particle Systems with TransformFeedback - YouTube
16. Design Systems: React Buttons with the Base + Variant Pattern - Bits and Pieces
17. React Speech-to-Text Button Component | KendoReact - Telerik.com
