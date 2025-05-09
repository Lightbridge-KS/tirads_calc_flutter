## Goal

Primary goal of this project is to create a "TIRADS Calculator" application using Flutter. 

There will be multiple steps involved in this task that might not follow linear path. Please be patient. 

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

   * **Composition** (e.g., cystic, solid)
   * **Echogenicity** (e.g., hyperechoic, hypoechoic)
   * **Shape** (e.g., taller-than-wide)
   * **Margin** (e.g., irregular, smooth)
   * **Echogenic foci** (e.g., microcalcifications)

2. Each feature is assigned **points (0 to 3)**.

3. The **total points** determine the **TI-RADS Level**.