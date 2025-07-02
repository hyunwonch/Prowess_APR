# Top folder for TSMC 28nm technology

This folder includes all the necessary files for the physical design

---

## 🧮 Folder structure
    - cdl
    - db
    - gds
    - lef
    - lib
    - mem/active
    - module
    - techfile

## Technology
    - **Standard Cells**
        - `tcbn28hpcplusbwp30p140hvttt0p9v25c`
        - `tcbn28hpcplusbwp30p140lvttt0p9v25c`
        - `tcbn28hpcplusbwp30p140tt0p9v25c`
    - **IO Cells**
        - `tphn28hpcpgv2od3tt0p9v2p5v25c`
        - `tphn28hpcpgv18tt0p9v1p8v25c`

## 📌 To-Do
    - [ ] Figure out which pads need to use
    - [ ] Figure out how to pass LVS with internal VDD
    - [ ] Figure out how to make PG pin for the internal VDD
        - [ ] What is difference between analog pad and digital pad and all different kinds of pad
        - [ ] Need to study aboud ESD and how to avoid it
        - [ ] Need to ask what would be potential danger on the pad
    - [ ] Figure out what/how to use seal ring
    - [ ] Need to get a script for filling
    - [ ] Need to ask what is the difference between CLK_GEN_CORE_m1_fix & CLK_GEN_CORE_new.lef
    - [ ] Need to find where is gds for CLK_GEN