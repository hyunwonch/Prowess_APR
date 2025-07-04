module lut (
    input   [7:0] index,
    input         enable,
    output  logic [15:0] value
);
    always_comb begin
        value = 0;
        if(enable == 1) begin
            case (index)
                0: value = 1;
                1: value = 16'h4dbc;
                2: value = 16'h4dbc;
                3: value = 16'h679f;
                4: value = 16'h4db7;
                5: value = 16'h3e2c;
                6: value = 16'h33cf;
                7: value = 16'h2c68;
                8: value = 16'h26db;
                9: value = 16'h228a;
                10: value = 16'h1f16;
                11: value = 16'h1c42;
                12: value = 16'h19e7;
                13: value = 16'h17e9;
                14: value = 16'h1634;
                15: value = 16'h14b9;
                16: value = 16'h136d;
                17: value = 16'h1249;
                18: value = 16'h1145;
                19: value = 16'h105c;
                20: value = 16'h0f8b;
                21: value = 16'h0ecd;
                22: value = 16'h0e21;
                23: value = 16'h0d84;
                24: value = 16'h0cf3;
                25: value = 16'h0c6f;
                26: value = 16'h0bf4;
                27: value = 16'h0b83;
                28: value = 16'h0b1a;
                29: value = 16'h0ab8;
                30: value = 16'h0a5c;
                31: value = 16'h0a07;
                32: value = 16'h09b6;
                33: value = 16'h096b;
                34: value = 16'h0924;
                35: value = 16'h08e1;
                36: value = 16'h08a2;
                37: value = 16'h0866;
                38: value = 16'h082e;
                39: value = 16'h07f8;
                40: value = 16'h07c5;
                41: value = 16'h0795;
                42: value = 16'h0766;
                43: value = 16'h073a;
                44: value = 16'h0710;
                45: value = 16'h06e8;
                46: value = 16'h06c2;
                47: value = 16'h069d;
                48: value = 16'h0679;
                49: value = 16'h0658;
                50: value = 16'h0637;
                51: value = 16'h0618;
                52: value = 16'h05fa;
                53: value = 16'h05dd;
                54: value = 16'h05c1;
                55: value = 16'h05a6;
                56: value = 16'h058d;
                57: value = 16'h0574;
                58: value = 16'h055c;
                59: value = 16'h0544;
                60: value = 16'h052e;
                61: value = 16'h0518;
                62: value = 16'h0503;
                63: value = 16'h04ef;
                64: value = 16'h04db;
                65: value = 16'h04c8;
                66: value = 16'h04b5;
                67: value = 16'h04a3;
                68: value = 16'h0492;
                69: value = 16'h0481;
                70: value = 16'h0470;
                71: value = 16'h0460;
                72: value = 16'h0451;
                73: value = 16'h0442;
                74: value = 16'h0433;
                75: value = 16'h0425;
                76: value = 16'h0417;
                77: value = 16'h0409;
                78: value = 16'h03fc;
                79: value = 16'h03ef;
                80: value = 16'h03e2;
                81: value = 16'h03d6;
                82: value = 16'h03ca;
                83: value = 16'h03be;
                84: value = 16'h03b3;
                85: value = 16'h03a8;
                86: value = 16'h039d;
                87: value = 16'h0392;
                88: value = 16'h0388;
                89: value = 16'h037e;
                90: value = 16'h0374;
                91: value = 16'h036a;
                92: value = 16'h0361;
                93: value = 16'h0357;
                94: value = 16'h034e;
                95: value = 16'h0345;
                96: value = 16'h033c;
                97: value = 16'h0334;
                98: value = 16'h032c;
                99: value = 16'h0323;
                100: value = 16'h031b;
                101: value = 16'h0313;
                102: value = 16'h030c;
                103: value = 16'h0304;
                104: value = 16'h02fd;
                105: value = 16'h02f5;
                106: value = 16'h02ee;
                107: value = 16'h02e7;
                108: value = 16'h02e0;
                109: value = 16'h02da;
                110: value = 16'h02d3;
                111: value = 16'h02cc;
                112: value = 16'h02c6;
                113: value = 16'h02c0;
                114: value = 16'h02ba;
                115: value = 16'h02b4;
                116: value = 16'h02ae;
                117: value = 16'h02a8;
                118: value = 16'h02a2;
                119: value = 16'h029c;
                120: value = 16'h0297;
                121: value = 16'h0291;
                122: value = 16'h028c;
                123: value = 16'h0287;
                124: value = 16'h0281;
                125: value = 16'h027c;
                126: value = 16'h0277;
                127: value = 16'h0272;
                128: value = 16'h026d;
                129: value = 16'h0268;
                130: value = 16'h0264;
                131: value = 16'h025f;
                132: value = 16'h025a;
                133: value = 16'h0256;
                134: value = 16'h0251;
                135: value = 16'h024d;
                136: value = 16'h0249;
                137: value = 16'h0244;
                138: value = 16'h0240;
                139: value = 16'h023c;
                140: value = 16'h0238;
                141: value = 16'h0234;
                142: value = 16'h0230;
                143: value = 16'h022c;
                144: value = 16'h0228;
                145: value = 16'h0224;
                146: value = 16'h0221;
                147: value = 16'h021d;
                148: value = 16'h0219;
                149: value = 16'h0216;
                150: value = 16'h0212;
                151: value = 16'h020f;
                152: value = 16'h020b;
                153: value = 16'h0208;
                154: value = 16'h0204;
                155: value = 16'h0201;
                156: value = 16'h01fe;
                157: value = 16'h01fa;
                158: value = 16'h01f7;
                159: value = 16'h01f4;
                160: value = 16'h01f1;
                161: value = 16'h01ee;
                162: value = 16'h01eb;
                163: value = 16'h01e8;
                164: value = 16'h01e5;
                165: value = 16'h01e2;
                166: value = 16'h01df;
                167: value = 16'h01dc;
                168: value = 16'h01d9;
                169: value = 16'h01d6;
                170: value = 16'h01d4;
                171: value = 16'h01d1;
                172: value = 16'h01ce;
                173: value = 16'h01cc;
                174: value = 16'h01c9;
                175: value = 16'h01c6;
                176: value = 16'h01c4;
                177: value = 16'h01c1;
                178: value = 16'h01bf;
                179: value = 16'h01bc;
                180: value = 16'h01ba;
                181: value = 16'h01b7;
                182: value = 16'h01b5;
                183: value = 16'h01b2;
                184: value = 16'h01b0;
                185: value = 16'h01ae;
                186: value = 16'h01ab;
                187: value = 16'h01a9;
                188: value = 16'h01a7;
                189: value = 16'h01a5;
                190: value = 16'h01a2;
                191: value = 16'h01a0;
                192: value = 16'h019e;
                193: value = 16'h019c;
                194: value = 16'h019a;
                195: value = 16'h0198;
                196: value = 16'h0196;
                197: value = 16'h0193;
                198: value = 16'h0191;
                199: value = 16'h018f;
                200: value = 16'h018d;
                201: value = 16'h018b;
                202: value = 16'h0189;
                203: value = 16'h0188;
                204: value = 16'h0186;
                205: value = 16'h0184;
                206: value = 16'h0182;
                207: value = 16'h0180;
                208: value = 16'h017e;
                209: value = 16'h017c;
                210: value = 16'h017a;
                211: value = 16'h0179;
                212: value = 16'h0177;
                213: value = 16'h0175;
                214: value = 16'h0173;
                215: value = 16'h0172;
                216: value = 16'h0170;
                217: value = 16'h016e;
                218: value = 16'h016d;
                219: value = 16'h016b;
                220: value = 16'h0169;
                221: value = 16'h0168;
                222: value = 16'h0166;
                223: value = 16'h0164;
                224: value = 16'h0163;
                225: value = 16'h0161;
                226: value = 16'h0160;
                227: value = 16'h015e;
                228: value = 16'h015d;
                229: value = 16'h015b;
                230: value = 16'h015a;
                231: value = 16'h0158;
                232: value = 16'h0157;
                233: value = 16'h0155;
                234: value = 16'h0154;
                235: value = 16'h0152;
                236: value = 16'h0151;
                237: value = 16'h014f;
                238: value = 16'h014e;
                239: value = 16'h014c;
                240: value = 16'h014b;
                241: value = 16'h014a;
                242: value = 16'h0148;
                243: value = 16'h0147;
                244: value = 16'h0146;
                245: value = 16'h0144;
                246: value = 16'h0143;
                247: value = 16'h0142;
                248: value = 16'h0140;
                249: value = 16'h013f;
                250: value = 16'h013e;
                251: value = 16'h013d;
                252: value = 16'h013b;
                253: value = 16'h013a;
                254: value = 16'h0139;
                255: value = 16'h0138;
            endcase
        end
    end
endmodule
