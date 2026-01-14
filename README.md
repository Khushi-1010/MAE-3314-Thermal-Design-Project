# Thermal Design Toolkit — Heat Exchanger & Transient Furnace Heating

This repository contains two thermal-engineering design models implemented in MATLAB:
1) **Forced Convection Heat Exchanger Design** (internal tube flow + external crossflow)
2) **Transient Furnace Heating Model** for a moving metal strip (lumped capacitance)

Rather than treating this as coursework code, the repo is structured like a small **thermal design & analysis project**, including design assumptions, governing equations, correlation selection, and sensitivity trends.

---

## Project Motivation (Thermal Engineering Context)

These models replicate the type of thermal analysis used in:
- industrial heat exchanger sizing
- thermal processing / furnace line design
- quick-turn thermal feasibility studies
- early-stage system design sizing and trade studies
---

## Problem 1 — Forced Convection Heat Exchanger Design (Tube + Crossflow)

### Objective
Determine the **required tube length** to heat flowing water from **15°C → 35°C**, while exposed to a hot gas stream in external crossflow.

### Physics Modeled
- Internal forced convection inside a thin tube (water)
- External forced convection across a cylinder (hot gas in crossflow)
- Overall heat transfer via convection resistances

### Correlations Used
- Internal convection `h_i`: **Dittus–Boelter** (turbulent internal flow)
- External convection `h_o`: **Churchill–Bernstein** (crossflow over cylinder)

### Outputs
- Overall heat transfer coefficient `U`
- Tube length `L` required to achieve temperature rise
- Design sensitivity plots:
  - Tube Length vs Gas Velocity
  - Tube Length trends vs tube diameter
  - Tube Length trends vs gas ambient temperature

📌 Script: `src/hx_forced_convection.m`  
📊 Results saved in: `results/`

---

## Problem 2 — Transient Furnace Heating of Moving Metal Strip

### Objective
Model transient heating of a metal strip moving through a furnace and determine:
- heating time required for **300°C → 600°C**
- furnace length required for a specified belt/strip velocity
- required strip speeds for higher furnace temperatures

### Physics Modeled
- transient energy balance using **lumped capacitance**
- convection-dominated heating environment

### Validation Check
- **Biot number check** confirms lumped-capacitance validity:
  - `Bi < 0.1` → temperature uniform through thickness is a valid assumption.

### Outputs
- Temperature-time response `T(t)`
- Heating time and furnace length sizing
- Comparison plots for different furnace temperatures

📌 Script: `src/furnace_transient.m`  
📊 Results saved in: `results/`

---

## Design Insights (Engineering Takeaways)

### Heat Exchanger Sizing
- Increasing external gas velocity increases `Re`, increases `Nu`, increases `h_o`, and reduces required tube length.
- Tube diameter influences both internal and external convection regimes → non-linear design tradeoffs.
- `h_o` typically dominates overall resistance under certain conditions (design lever is often external flow).

### Furnace Heating
- Heating rate is governed by the thermal time constant `τ = (ρ V c_p)/(hA)`
- Higher furnace temperature shifts the exponential response faster → allows higher strip speed for same target temperature.

---

## How to Run

### Requirements
- MATLAB R2019b+ recommended
- No external toolboxes required

### Run scripts
```matlab
run("src/hx_forced_convection.m")
run("src/furnace_transient.m")

