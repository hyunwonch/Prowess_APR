// //////////////////////////////////////////////////////////////////////////////
// //                                                                          //
// //   Modulename :  ISA.svh  Hyunwon Chung (hyunwon@umich.edu) 11/26/2024    //
// //                                                                          //
// //  Description :  This file contains global definitions for all            //
// //                 PROWESS ISA related things. Any extensions added         //
// //                 in the future should be appended here                    //
// //                                                                          //
// //////////////////////////////////////////////////////////////////////////////

// `ifndef __ISA_SVH__
// `define __ISA_SVH__


// // Between PL and Execution Unit
// LOAD_INST_TO_PE
// LOAD_CONFIG_TO_SW
// LOAD_CONFIG_TO_DMA
// PRELOAD_INST_TO_PE
// PRELOAD_CONFIG_TO_SW
// PRELOAD_CONFIG_TO_DMA
// SEND_START_TO_PE
// SEND_START_TO_SW
// SEND_START_TO_DMA
// WFI_PE
// WFI_CPU
// JAL
// JALR

// // For Branch Core -> RISC_V Compatible



// // Between Scheduler and PL
// UPDATE_LUT
// UPDATE_KERNEL
// UPDATE_BRANCH
// SEND_KERNEL_RESULT


// `endif // __ISA_SVH__
