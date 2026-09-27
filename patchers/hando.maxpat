{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            479.0,
            1391.0,
            948.0,
            988.0
        ],
        "openinpresentation": 1,
        "integercoordinates": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        14.0,
                        90.0,
                        22.0
                    ],
                    "text": "r hando_start",
                    "varname": "hando_rstart"
                }
            },
            {
                "box": {
                    "fontsize": 16.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1580.0,
                        14.0,
                        130.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        312.0,
                        15.0,
                        52.0,
                        24.0
                    ],
                    "text": "size",
                    "textcolor": [
                        0.831677258014679,
                        0.7060011029243469,
                        0.4390353858470917,
                        1.0
                    ],
                    "varname": "cmt_size"
                }
            },
            {
                "box": {
                    "fontsize": 16.0,
                    "format": 6,
                    "id": "obj-15",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        1480.0,
                        46.0,
                        61.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        353.0,
                        14.0,
                        61.0,
                        26.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_invisible": 1,
                            "parameter_longname": "number",
                            "parameter_modmode": 0,
                            "parameter_shortname": "number",
                            "parameter_type": 3
                        }
                    },
                    "textcolor": [
                        0.8313725490196079,
                        0.7058823529411765,
                        0.4392156862745098,
                        1.0
                    ],
                    "varname": "hando_box"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1480.0,
                        76.0,
                        75.0,
                        22.0
                    ],
                    "text": "prepend box",
                    "varname": "hando_pbox"
                }
            },
            {
                "box": {
                    "fontsize": 16.0,
                    "id": "obj-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        450.0,
                        900.0,
                        60.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        234.0,
                        504.0,
                        41.0,
                        24.0
                    ],
                    "text": "slew",
                    "varname": "cmt_slewp"
                }
            },
            {
                "box": {
                    "comment": "Z float 0..1 for vst~ parameters, far to near, 30 per second",
                    "id": "obj-63",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        920.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_zf"
                }
            },
            {
                "box": {
                    "comment": "Y float 0..1 for vst~ parameters, bottom to top, 30 per second",
                    "id": "obj-61",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        820.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_yf"
                }
            },
            {
                "box": {
                    "comment": "X float 0..1 for vst~ parameters, left to right, 30 per second",
                    "id": "obj-57",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        720.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_xf"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        720.0,
                        860.0,
                        222.0,
                        22.0
                    ],
                    "text": "unpack 0. 0. 0.",
                    "varname": "hando_cvfloat"
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        70.0,
                        58.0,
                        100.0,
                        33.0
                    ],
                    "text": "on / off: camera and tracking",
                    "varname": "cmt_on"
                }
            },
            {
                "box": {
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        150.0,
                        60.0,
                        22.0
                    ],
                    "text": "zl.reg",
                    "varname": "hando_onreg"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        110.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend enable",
                    "varname": "hando_penable"
                }
            },
            {
                "box": {
                    "id": "obj-42",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        20.0,
                        50.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        10.0,
                        30.0,
                        30.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_longname": "hando_on",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "hando_on",
                            "parameter_type": 2
                        }
                    },
                    "varname": "hando_on"
                }
            },
            {
                "box": {
                    "id": "obj-39",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        14.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 1",
                    "varname": "hando_onload"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        60.0,
                        380.0,
                        20.0
                    ],
                    "text": "stored calibration, sent to the page when it is ready",
                    "varname": "cmt_store"
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1340.0,
                        14.0,
                        130.0,
                        20.0
                    ],
                    "text": "loads the page",
                    "varname": "cmt_loader"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1100.0,
                        14.0,
                        200.0,
                        20.0
                    ],
                    "text": "camera resolution",
                    "varname": "cmt_res"
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        860.0,
                        14.0,
                        180.0,
                        20.0
                    ],
                    "text": "tracking loop",
                    "varname": "cmt_loop"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        720.0,
                        480.0,
                        118.0,
                        22.0
                    ],
                    "restore": {
                        "hando_on": [
                            1
                        ],
                        "hando_slewms": [
                            33
                        ],
                        "number": [
                            0.834
                        ]
                    },
                    "text": "autopattr @greedy 1",
                    "varname": "hando_autopattr"
                }
            },
            {
                "box": {
                    "fontsize": 16.0,
                    "id": "obj-4",
                    "linecount": 8,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        720.0,
                        280.0,
                        445.0,
                        149.0
                    ],
                    "text": "The zfilter 0.3 0.4 message box still holds the old values, so clicking it would bring the heavy smoothing back. Double-click it and change the text to zfilter 0.8 3. You can then try values from there:\n\nWobbles when your hand is still: lower the first number, e.g. zfilter 0.5 3.\nZ lags when you move: raise the second, e.g. zfilter 0.8 6.",
                    "varname": "cmt_usernote"
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2090.0,
                        100.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend calib",
                    "varname": "hando_pcalib"
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1950.0,
                        100.0,
                        110.0,
                        22.0
                    ],
                    "restore": [
                        -1.5920089697184139,
                        -2.2096225491607733
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "pattr hando_calib",
                    "varname": "hando_calib"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.11,
                        0.135,
                        0.16,
                        0.0
                    ],
                    "fontsize": 16.0,
                    "id": "obj-66",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        380.0,
                        860.0,
                        58.0,
                        26.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        277.0,
                        503.0,
                        58.0,
                        26.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                33
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_invisible": 1,
                            "parameter_longname": "hando_slewms",
                            "parameter_modmode": 0,
                            "parameter_shortname": "hando_slewms",
                            "parameter_type": 3
                        }
                    },
                    "varname": "hando_slewms"
                }
            },
            {
                "box": {
                    "comment": "gate signal: 1 while pointing, 0 when frozen",
                    "id": "obj-64",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        600.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_gate"
                }
            },
            {
                "box": {
                    "comment": "Z signal 0..1, far to near",
                    "id": "obj-60",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        250.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_z"
                }
            },
            {
                "box": {
                    "comment": "Y signal 0..1, bottom to top",
                    "id": "obj-58",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        135.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_y"
                }
            },
            {
                "box": {
                    "comment": "X signal 0..1, left to right",
                    "id": "obj-56",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        1060.0,
                        30.0,
                        30.0
                    ],
                    "varname": "hando_out_x"
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        600.0,
                        860.0,
                        40.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "hando_sgate"
                }
            },
            {
                "box": {
                    "id": "obj-52",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        250.0,
                        1000.0,
                        90.0,
                        22.0
                    ],
                    "text": "line~",
                    "varname": "hando_lz"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        135.0,
                        1000.0,
                        90.0,
                        22.0
                    ],
                    "text": "line~",
                    "varname": "hando_ly"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        20.0,
                        1000.0,
                        90.0,
                        22.0
                    ],
                    "text": "line~",
                    "varname": "hando_lx"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        250.0,
                        940.0,
                        90.0,
                        22.0
                    ],
                    "text": "pack 0. 33",
                    "varname": "hando_pz"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        940.0,
                        90.0,
                        22.0
                    ],
                    "text": "pack 0. 33",
                    "varname": "hando_py"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        940.0,
                        90.0,
                        22.0
                    ],
                    "text": "pack 0. 33",
                    "varname": "hando_px"
                }
            },
            {
                "box": {
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1060.0,
                        860.0,
                        80.0,
                        22.0
                    ],
                    "text": "print hando",
                    "varname": "hando_print"
                }
            },
            {
                "box": {
                    "disablefind": 0,
                    "id": "obj-3",
                    "maxclass": "jweb",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        240.0,
                        640.0,
                        480.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        50.0,
                        640.0,
                        480.0
                    ],
                    "rendermode": 0,
                    "url": "file://hando.html",
                    "varname": "hando_web"
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        720.0,
                        530.0,
                        91.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "alias": "",
                        "group": ""
                    },
                    "text": "maxmcp hando",
                    "varname": "hando_mcp"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-80",
                    "maxclass": "newobj",
                    "numinlets": 7,
                    "numoutlets": 7,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        780.0,
                        1350.0,
                        22.0
                    ],
                    "text": "route raw stats cv gate status calib",
                    "varname": "hando_route"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-81",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        20.0,
                        860.0,
                        320.0,
                        22.0
                    ],
                    "text": "unpack 0. 0. 0.",
                    "varname": "hando_cvunpack"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgcolor2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-88",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        60.0,
                        112.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        60.0,
                        14.0,
                        112.0,
                        22.0
                    ],
                    "text": "calibrate near",
                    "varname": "hando_mcalnear"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgcolor2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-90",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        306.0,
                        60.0,
                        104.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        182.0,
                        14.0,
                        104.0,
                        22.0
                    ],
                    "text": "calibrate far",
                    "varname": "hando_mcalfar"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgcolor2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-92",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        860.0,
                        60.0,
                        80.0,
                        22.0
                    ],
                    "text": "loop rvfc",
                    "varname": "hando_mrvfc"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgcolor2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.19607843137254902,
                        0.34901960784313724,
                        1.0,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-94",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        956.0,
                        60.0,
                        80.0,
                        22.0
                    ],
                    "text": "loop timer",
                    "varname": "hando_mtimer"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgcolor2": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.07058823529411765,
                        0.23921568627450981,
                        0.09803921568627451,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-96",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1100.0,
                        60.0,
                        79.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        446.0,
                        14.0,
                        96.0,
                        22.0
                    ],
                    "text": "res 1280 960",
                    "varname": "hando_m720"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgcolor2": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [
                        0.07058823529411765,
                        0.23921568627450981,
                        0.09803921568627451,
                        1.0
                    ],
                    "bgfillcolor_color1": [
                        0.3176470588235294,
                        0.5019607843137255,
                        0.23529411764705882,
                        1.0
                    ],
                    "bgfillcolor_color2": [
                        0.155775393210821,
                        0.174257207209253,
                        0.193751291175729,
                        1.0
                    ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "color",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "gradient": 1,
                    "id": "obj-98",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1212.0,
                        60.0,
                        88.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        552.0,
                        14.0,
                        88.0,
                        22.0
                    ],
                    "text": "res 640 480",
                    "varname": "hando_m480"
                }
            },
            {
                "box": {
                    "filename": "hando.loader.js",
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1340.0,
                        60.0,
                        106.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 hando.loader.js",
                    "textfile": {
                        "filename": "hando.loader.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    },
                    "varname": "hando_loader"
                }
            },
            {
                "box": {
                    "id": "obj-h100",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        580.0,
                        60.0,
                        104.0,
                        22.0
                    ],
                    "text": "zfilter 0.8 3.",
                    "varname": "hando_mzfilt"
                }
            },
            {
                "box": {
                    "id": "obj-h101",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        60.0,
                        65.0,
                        22.0
                    ],
                    "text": "filter 3. 12.",
                    "varname": "hando_mfilt"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        580.0,
                        14.0,
                        260.0,
                        33.0
                    ],
                    "text": "smoothing for Z / for X,Y: cutoff Hz, beta. Lower cutoff = steadier, higher beta = less lag",
                    "varname": "cmt_filter"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        436.0,
                        860.0,
                        110.0,
                        33.0
                    ],
                    "text": "slew ms (33 = one camera frame)",
                    "varname": "cmt_slew"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        180.0,
                        14.0,
                        340.0,
                        20.0
                    ],
                    "text": "Z range: point and hold still for 1 s, near then far",
                    "varname": "cmt_calib"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1720.0,
                        100.0,
                        120.0,
                        22.0
                    ],
                    "text": "route start ready",
                    "varname": "hando_rready"
                }
            },
            {
                "box": {
                    "fontface": 0,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-67",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        1104.0,
                        940.0,
                        20.0
                    ],
                    "text": "outlets, all 0..1. 1-4 signals: X, Y, Z, gate (1 while pointing). 5-7 floats for vst~ parameters: X, Y, Z",
                    "varname": "cmt_outs"
                }
            },
            {
                "box": {
                    "id": "obj-h200",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1720.0,
                        150.0,
                        95.0,
                        22.0
                    ],
                    "text": "s hando_start",
                    "varname": "hando_sstart"
                }
            },
            {
                "box": {
                    "id": "obj-h201",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1560.0,
                        46.0,
                        140.0,
                        22.0
                    ],
                    "restore": [
                        0.846
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "pattr hando_boxsize @bindto hando_box",
                    "varname": "hando_boxsize"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-108",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "source": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "source": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-80",
                        0
                    ],
                    "source": [
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-76",
                        0
                    ],
                    "source": [
                        "obj-37",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-42",
                        0
                    ],
                    "source": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "source": [
                        "obj-42",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "source": [
                        "obj-43",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "source": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-51",
                        0
                    ],
                    "source": [
                        "obj-47",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "source": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "source": [
                        "obj-50",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-58",
                        0
                    ],
                    "source": [
                        "obj-51",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "source": [
                        "obj-52",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "source": [
                        "obj-53",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-61",
                        0
                    ],
                    "source": [
                        "obj-53",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "source": [
                        "obj-53",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "source": [
                        "obj-54",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        1
                    ],
                    "order": 2,
                    "source": [
                        "obj-66",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-47",
                        1
                    ],
                    "order": 1,
                    "source": [
                        "obj-66",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-48",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-66",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-77",
                        0
                    ],
                    "source": [
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "source": [
                        "obj-80",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-80",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "source": [
                        "obj-80",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-76",
                        0
                    ],
                    "source": [
                        "obj-80",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "source": [
                        "obj-80",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-81",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-80",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "source": [
                        "obj-81",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "source": [
                        "obj-81",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "source": [
                        "obj-81",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-88",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-90",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-92",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-94",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-96",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-98",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-h100",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-h101",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-37",
                        0
                    ],
                    "destination": [
                        "obj-h200",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-15": [
                "number",
                "number",
                0
            ],
            "obj-42": [
                "hando_on",
                "hando_on",
                0
            ],
            "obj-66": [
                "hando_slewms",
                "hando_slewms",
                0
            ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ],
                    "buttons": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}