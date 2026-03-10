# The Book of Formation
## AETHERIUM · GENESIS

> ตำราความรู้ว่าด้วย “การก่อรูปของแสง”
> สำหรับระบบปัญญาประดิษฐ์เชิงปฏิสัมพันธ์ (Generative / Embodied AI)

---

## บทนำ (Introduction)

**The Book of Formation** คือคลังความรู้ส่วนกลาง (Central Codex) ที่บันทึก “รูปแบบการก่อกำเนิด การเคลื่อนไหว และการคลี่คลายของแสง” ในรูปแบบของ **Semantic Manifests, Annotations, และ Technical Specifications**

Repo นี้ทำหน้าที่เป็น **Canonical Knowledge Repository** ที่ระบบ AI หลักของแพลตฟอร์ม **AETHERIUM · GENESIS** ใช้เป็นแหล่งอ้างอิงเพื่อ “เข้าใจว่าควรแสดงออกอย่างไร” ผ่านโครงสร้างข้อมูลที่เครื่องอ่านได้ (Machine-readable) และภาษามนุษย์ที่สละสลวย (Poetic Narrative)

---

## โครงสร้างระบบ (System Structure)

### 1. Formation Manifest System
ดัชนีเชิงความหมายของทั้งคลัง บันทึก ID, Version, และ Metadata สำคัญของแต่ละ Motion Archetype
- `manifest/formations.index.yaml`: รายการ Formation ทั้งหมด
- `manifest/lineage.index.yaml`: บันทึกสายสัมพันธ์และการสืบทอด (Derivation/Variant)

### 2. Annotation & Embodied Semantics
ชั้นคำอธิบายสองระดับที่เชื่อมโยงความรู้สึกเข้ากับพารามิเตอร์
- **Human Narrative**: คำบรรยายภาษามนุษย์ (Poetic Thai) เช่น “แสงค่อย ๆ รวบตัวเหมือนลมหายใจแรก”
- **Machine Semantics**: พารามิเตอร์ที่ Normalize (0.0 - 1.0) สำหรับระบบ Runtime

### 3. Governance & Policy Matrix
กฎเกณฑ์การใช้งาน Archetype ในแต่ละสภาวะ (Internal State) และการควบคุมความปลอดภัย (Safety Overlay)
- `policy/formation-policy-matrix.yaml`: ข้อกำหนดการเลือกใช้ตามบริบท
- `policy/review-checklist.yaml`: มาตรฐานการตรวจสอบข้อมูลก่อนเข้าสู่คลัง

---

## สถาปัตยกรรม Repository (Repository Architecture)

```text
The-Book-of-Formation-AETHERIUM-GENESIS/
├─ schemas/           # JSON/YAML Schemas สำหรับ Validation
├─ manifest/          # ดัชนีกลางและ Lineage Registry
├─ formations/        # ข้อมูล Formation (YAML) ตามมาตรฐาน Codex
├─ annotations/       # คำอธิบายเชิงลึก (Human & Machine layers)
├─ policy/            # กฎเกณฑ์ Governance และ Matrix การใช้งาน
├─ specs/             # Technical Contracts (Compiler, Retrieval, Adapter)
├─ examples/          # ตัวอย่างการเขียนข้อมูลที่ถูกต้อง
├─ platform/
│  ├─ create_platform_work.md          # Workstreams, backlog, options, risks, rollout/rollback, DoD
│  └─ db/
│     ├─ platform_work_schema.sql      # Initiative/Epic/Story/Task/Gates/Risks schema
│     └─ seed_aetherium_genesis.sql    # Re-runnable seed data for AETHERIUM GENESIS planning
└─ .github/workflows/ # ระบบ Content Validation อัตโนมัติ
```

---

## การนำไปใช้งาน (How to Use as a Developer)

Repository นี้เป็น **Knowledge Layer** (ไม่มี executable logic ของ runtime) ระบบภายนอกสามารถเชื่อมต่อได้ผ่าน Technical Contracts ในโฟลเดอร์ `specs/`:

1. **Retrieval Engine**: ใช้เพื่อค้นหา Archetype ที่เหมาะสมจาก Intent Vector
2. **Formation Compiler**: แปลง Semantic Profile ไปเป็น Shader/Physics Bias
3. **AetherBus Adapter**: ห่อหุ้ม Payload เพื่อส่งต่อในระบบ Secure Channel

---


## Platform Work Planning System (New)

เพื่อรองรับการปรับปรุงระบบเชิงโครงสร้าง ได้เพิ่มชุดเอกสารและฐานข้อมูลสำหรับวางแผนงานแบบวัดผลได้:

- `platform/create_platform_work.md`: Workstreams, backlog, options, risks, rollout/rollback, Definition of Done
- `platform/db/platform_work_schema.sql`: โครงสร้างฐานข้อมูลสำหรับ Initiative/Epic/Story/Task/Gates/Risks
- `platform/db/seed_aetherium_genesis.sql`: ข้อมูลตั้งต้นสำหรับโครงการ AETHERIUM GENESIS

แนวทางนี้ช่วยลดข้อมูลซ้ำซ้อนในการติดตามงาน และทำให้มีแหล่งข้อมูลความจริงหนึ่งเดียว (single source of truth) สำหรับการดำเนินงาน.

---

## หลักการในการเพิ่มเนื้อหา (Ingestion Principles)

การเพิ่ม Formation ใหม่ต้องผ่านขั้นตอนดังนี้:
1. **Schema Compliance**: ข้อมูลต้องตรงตาม `schemas/formation.schema.yaml`
2. **Language Strategy**:
   - *English*: สำหรับ Machine-facing fields และ Technical keys
   - *Thai*: สำหรับ Narrative fields และ Poetic descriptions
3. **Semantic Normalization**: ค่าพารามิเตอร์ต้องอยู่ในช่วง [0.0 - 1.0] เสมอ
4. **Governance Review**: ผ่านการตรวจสอบตาม `policy/review-checklist.yaml`

---

## สถานะโครงการ
โครงการนี้เป็นส่วนหนึ่งของระบบหลัก **AETHERIUM · GENESIS** และทำหน้าที่เป็น "สมองส่วนความทรงจำแห่งแสง" สำหรับ Generative UI และ Embodied AI

---

> “แสงไม่จำเป็นต้องถูกสั่ง แต่ต้องถูกเข้าใจ”
> — The Book of Formation
