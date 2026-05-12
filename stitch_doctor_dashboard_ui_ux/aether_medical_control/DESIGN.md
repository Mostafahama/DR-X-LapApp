# Design System Specification: The Liquid Control Tower

## 1. Overview & Creative North Star
**The Creative North Star: "The Clinical Prism"**

This design system transcends the traditional, flat "dashboard" aesthetic. It is a high-performance environment designed for medical professionals who require the speed of a "Control Tower" with the clarity of "Liquid Glass." 

We break the standard ERP "template" look by treating the interface as an optical instrument. Instead of rigid boxes and heavy lines, we use **refractive layering**, **chromatic depth**, and **intentional asymmetry**. The layout should feel like information suspended in a clear, sterile, and high-tech medium. Elements do not sit *on* a page; they float within an atmosphere of light and data.

---

## 2. Colors: The Aqueous Palette

Our color strategy moves away from "filling containers" toward "tinting light." We use a spectrum of slates and high-precision blues to maintain a clinical, trustworthy environment.

### Primary & Action
*   **Primary (`#0050cb`):** Used for core branding and critical action paths.
*   **Primary Container (`#0066ff`):** Our signature "Clinical Blue." Use this for high-visibility highlights and active states.
*   **Surface Tint (`#0054d6`):** Applied to glass layers to give them a subtle blue "refraction" at the edges.

### Semantic Status
*   **Success (`tertiary` - #006645):** Emerald Green. High legibility against glass.
*   **Urgent (`error` - #ba1a1a):** Crimson. Reserved for life-critical alerts.
*   **Pending (`on_secondary_fixed_variant` - #3a485b):** A sophisticated Amber/Slate hybrid for non-critical states.

### The "No-Line" Rule
**Explicit Instruction:** Prohibit the use of 1px solid borders for sectioning. 
Boundaries are defined solely through background shifts. A `surface-container-low` sidebar sits against a `surface` background. If an edge needs more definition, use a tonal shift or the "Liquid Glass" effect—never a dark stroke.

### The Glass & Gradient Rule
Main CTAs and Hero elements should utilize a subtle linear gradient: `primary` to `primary_container` (135° angle). This provides a "soul" to the UI, mimicking the way light hits a high-end medical lens.

---

## 3. Typography: Bilingual Precision

We pair **Inter** (English) and **Cairo** (Arabic) to ensure that high-density medical data remains legible at a glance.

*   **Display (Inter, 3.5rem - 2.25rem):** Used for "At-a-Glance" metrics (e.g., Patient Heart Rate, Total Admissions). High tracking (-0.02em) for a tech-forward feel.
*   **Headline (Inter, 2rem - 1.5rem):** Editorial-style headers for major sections. Use `on_surface` color.
*   **Title (Inter/Cairo, 1.375rem - 1rem):** Section titles within glass cards. 
*   **Body (Inter/Cairo, 1rem - 0.75rem):** Standardized medical records and data entry.
*   **Label (Inter, 0.75rem - 0.6875rem):** Micro-data, status tags, and table headers. Always uppercase with 0.05em letter spacing for the "Control Tower" aesthetic.

---

## 4. Elevation & Depth: The Layering Principle

In this system, depth is the primary communicator of hierarchy.

### Tonal Layering
Stack `surface-container` tiers to create natural lift.
1.  **Base Layer:** `surface` (#f7f9fb).
2.  **Section Layer:** `surface-container-low` (#f2f4f6).
3.  **Interactive Card Layer:** `surface-container-lowest` (#ffffff).

### The Liquid Glass Effect (Glassmorphism)
For floating sidebars, modals, and hovering tooltips:
*   **Background:** `rgba(255, 255, 255, 0.6)` or `primary_container` at 10% opacity.
*   **Backdrop Blur:** 12px to 20px.
*   **The Ghost Border:** A 1px border using `white/20` (top/left) and `outline_variant/10` (bottom/right) to simulate a light source hitting a glass edge.
*   **Inner Glow:** `box-shadow: inset 0 1px 1px rgba(255,255,255,0.4)`.

### Ambient Shadows
Avoid black shadows. Use `on_surface` at 4-6% opacity with a 32px blur and 16px Y-offset. This mimics natural light passing through medical-grade acrylic.

---

## 5. Components: High-Density High-Tech

### Buttons
*   **Primary:** A gradient-filled container (`primary` to `primary_container`) with `on_primary` text. No border. `md` roundedness (0.375rem).
*   **Liquid Secondary:** A glass-effect button with a `white/20` border and `backdrop-blur`.
*   **Ghost Tertiary:** No container, `primary` text. Use for low-emphasis actions in dense tables.

### ERP Tables (The Data Grid)
*   **Header:** `surface-container-high` background, `label-md` typography.
*   **Rows:** **Forbid divider lines.** Separate rows using a 4px vertical gap where the `surface` background shows through, or use alternating `surface-container-low` and `surface-container-lowest` tints.
*   **Cells:** High-density padding (8px vertical).

### High-Density Cards
Cards must not have shadows unless they are "active." Instead, use `surface-container-lowest` with a `white/20` ghost border. Overlapping cards (asymmetric layout) is encouraged to suggest a "stacked files" metaphor.

### Input Fields
*   **Default:** `surface-container-low` background. No border.
*   **Focus:** `primary` ghost border (20% opacity) and an inner glow of the primary color at 5%.

---

## 6. Do’s and Don’ts

### Do
*   **Do** use asymmetrical spacing. A wider left margin than right margin creates an editorial, intentional feel.
*   **Do** use translucency for navigation. The sidebar should allow the "glow" of background content to peek through.
*   **Do** use "Clinical Blue" sparingly for emphasis. The majority of the UI should feel white, slate, and airy.

### Don't
*   **Don't** use 100% black text. Use `on_surface` (#191c1e) for better optical comfort.
*   **Don't** use sharp 90-degree corners. Always adhere to the `md` (0.375rem) or `lg` (0.5rem) roundedness scale to maintain the "liquid" feel.
*   **Don't** use standard drop shadows. If it looks like a generic web shadow, it’s too heavy. If you can clearly see where the shadow ends, it’s too sharp.