## Goal

Primary goal of this project is to create a "TI-RADS Calculator" application using Flutter. 

---

## ACR TI-RADS Overview

### What is ACR TI-RADS?

ACR TI-RADS (Thyroid Imaging Reporting and Data System)

* Developed by the **American College of Radiology (ACR)** in **2017**.
* Provides a **standardized scoring and management system** for thyroid nodules detected on ultrasound.
* Similar in philosophy to BI-RADS for breast lesions or O-RADS for ovarian lesions.
* Aims to **reduce unnecessary biopsies** while **ensuring detection of clinically significant malignancies**.

### How the Scoring Works

1. You assess **five ultrasound categories**:

   * **Composition** (choose one): e.g., cystic, solid
   * **Echogenicity** (choose one): e.g., hyperechoic, hypoechoic
   * **Shape** (choose one): e.g., taller-than-wide
   * **Margin** (choose one): e.g., irregular, smooth
   * **Echogenic foci** (choose one or more): e.g., microcalcifications

2. Each feature is assigned **points (0 to 3)**.

3. The **total points** determine the **TI-RADS Level**.