import lib-env.glsl
import lib-vectors.glsl
import lib-normal.glsl
import lib-sampler.glsl
import lib-pbr-aniso.glsl
import lib-utils.glsl

//: param auto main_light
uniform vec4 light_main;
//: param auto camera_view_matrix
uniform mat4 uniform_camera_view_matrix;
//: param auto mvp_matrix
uniform mat4 uniform_mvp_matrix;
//: param auto screen_size
uniform vec4 uniform_screen_size;

//-----------Category Modifiers---------------------------------------------------//
//: param custom {
//:   "default": 0,
//:   "label": "Albedo",
//:   "widget": "combobox",
//:   "values": {
//:     "Default": 0,
//:     "Detail Blend": 1,
//:     "Constant Color": 2,
//:     "Two Change Color": 3,
//:     "Four Change Color": 4,
//:     "Three Detail Blend": 5,
//:     "Two Detail Overlay": 6,
//:     "Two Detail": 7,
//:     "Color Mask": 8,
//:     "Two Detail Black Point": 9,
//:     "Two Change Color Anim Overlay": 10,
//:     "Chameleon": 11,
//:     "Two Change Color Chameleon": 12,
//:     "Chameleon Masked": 13,
//:     "Color Mask Hard Light": 14,
//:     "Two Change Color Tex Overlay": 15,
//:     "Chameleon Albedo Masked": 16,
//:     "Custom Cube": 17,
//:     "Two Color": 18,
//:     "Scrolling Cube Mask": 19,
//:     "Scrolling Cube": 20,
//:     "Scrolling Texture UV": 21,
//:     "Texture From Misc": 22
//:   },
//:   "group": "CATEGORIES"
//: }
uniform_specialization int u_albedotype;

//: param custom {
//:   "default": 0,
//:   "label": "Bump Mapping",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "Standard": 1,
//:     "Detail": 2,
//:     "Detail Masked": 3,
//:     "Detail Plus Detail Masked": 4,
//:     "Detail UNorm": 5
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_bumptype;

//: param custom {
//:   "default": 0,
//:   "label": "Alpha Test",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "On": 1
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_alphatest;

//: param custom {
//:   "default": 0,
//:   "label": "Specular Mask",
//:   "widget": "combobox",
//:   "values": {
//:     "No Specular Mask": 0,
//:     "Specular Mask From Diffuse": 1,
//:     "Specular Mask From Texture": 2,
//:     "Specular Mask From Color Texture": 3
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_specmask;

//: param custom {
//:   "default": 0,
//:   "label": "Material Model",
//:   "widget": "combobox",
//:   "values": {
//:     "Diffuse Only": 0,
//:     "Cook Torrence": 1,
//:     "Two Lobe Phong": 2,
//:     "Foliage": 3,
//:     "None": 4,
//:     "Glass": 5,
//:     "Organism": 6,
//:     "Single Lobe Phong": 7,
//:     "Car Paint": 8,
//:     "Cook Torrence Custom Cube": 9,
//:     "Cook Torrence PBR Maps": 10,
//:     "Cook Torrence Two Color Spec Tint": 11,
//:     "Two Lobe Phong Tint Map": 12,
//:     "Cook Torrence Scrolling Cube Mask": 13,
//:     "Cook Torrence Rim Fresnel": 14,
//:     "Cook Torrence Scrolling Cube": 15,
//:     "Cook Torrence From Albedo": 16
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_materialmodel;

//: param custom {
//:   "default": 0,
//:   "label": "Enviorment Mapping",
//:   "widget": "combobox",
//:   "values": {
//:     "None": 0,
//:     "Per Pixel": 1,
//:     "Dynamic": 2,
//:     "From Flat TExture": 3,
//:     "Custom Map": 4,
//:     "From Flat Texture as Cubemap": 5
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_envmapping;

//: param custom {
//:   "default": 0,
//:   "label": "Self Illumination",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "Simple": 1,
//:     "3 Channel Self Illum": 2,
//:     "Plasma": 3,
//:     "From Diffuse": 4,
//:     "Illum Detail": 5,
//:     "Meter": 6,
//:     "Self Illum Time Diffuse": 7,
//:     "Simple With Alpha Mask": 8,
//:     "Simple Four Change Color": 9,
//:     "Illum Detail World Space Four CC": 10,
//:     "Illum Change Color": 11
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_selfillum;

//: param custom {
//:   "default": 0,
//:   "label": "Blend Mode",
//:   "widget": "combobox",
//:   "values": {
//:     "Opaque": 0,
//:     "Addative": 1,
//:     "Muiltiply": 2,
//:     "Alpha Blend": 3,
//:     "Double Multiply": 4,
//:     "Premultiplied Alpha": 5
//:   },
//:   "group": "CATEGORIES"
//: }
uniform_specialization int u_blendmode;
//: state blend none { "enable" : "input.u_blendmode == 0" }
//: state blend add { "enable" : "input.u_blendmode == 1" }
//: state blend multiply { "enable" : "input.u_blendmode == 2" }
//: state blend over { "enable" : "input.u_blendmode == 3" }
//: state blend add_multiply { "enable" : "input.u_blendmode == 4" }
//: state blend over_premult { "enable" : "input.u_blendmode == 5" }

//: param custom {
//:   "default": 0,
//:   "label": "Parallax",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "Simple": 1,
//:     "Interpolated": 2,
//:     "Simple Detail": 3
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_parallax;

//: param custom {
//:   "default": 0,
//:   "label": "Distortion",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "On": 1
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_distortion;

//: param custom {
//:   "default": 0,
//:   "label": "Soft Fade",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "On": 1
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_softfade;

//: param custom {
//:   "default": 0,
//:   "label": "Misc Attr Animation",
//:   "widget": "combobox",
//:   "values": {
//:     "Off": 0,
//:     "Scrolling Cube": 1,
//:     "Scrolling Projected": 2
//:   },
//:   "group": "CATEGORIES"
//: }
uniform int u_misc_anim;

//: param auto channel_opacity
uniform SamplerSparse opacity_tex;

//-----------Albedo---------------------------------------------------------------//
//-----------Texture Inputs-------------------------------------------------------//
//: param auto channel_basecolor
uniform SamplerSparse basecolor_tex;
//: param auto channel_user14
uniform SamplerSparse albedoalphatex;
//: param auto channel_specularlevel
uniform SamplerSparse specularmask_tex;
//: param auto channel_user0
uniform SamplerSparse colormaskprimary;
//: param auto channel_user1
uniform SamplerSparse colormasksecondary;
//: param auto channel_user2
uniform SamplerSparse colormasktertiary;
//: param auto channel_user3
uniform SamplerSparse colormaskquat;
//: param auto channel_user4
uniform SamplerSparse basecolormasked;
//: param auto channel_user5
uniform SamplerSparse chameleonmask;
//: param custom { "default": [1,1,1], "label": "Primary Color", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 3 || input.u_albedotype == 4" }
uniform vec3 primary_change_color;
//: param custom { "default": [1,1,1], "label": "Secondary Color", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 3 || input.u_albedotype == 4" }
uniform vec3 secondary_change_color;
//: param custom { "default": [1,1,1], "label": "Tertiary Color", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 4" }
uniform vec3 tertiary_change_color;
//: param custom { "default": [1,1,1], "label": "Quaternary Color", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 4" }
uniform vec3 quaternary_change_color;
//: param custom { "default": [0, 0, 0], "label": "Primary Color Anim", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 10 || input.u_albedotype == 12" }
uniform vec3 primary_change_color_anim;
//: param custom { "default": [0, 0, 0], "label": "Secondary Color Anim", "widget": "color", "group": "ALBEDO", "visible": "input.u_albedotype == 10 || input.u_albedotype == 12" }
uniform vec3 secondary_change_color_anim;
//: param custom { "default": "default_detail", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Detail Map", "group": "ALBEDO", "visible": "input.u_albedotype == 0 || input.u_albedotype == 1 || input.u_albedotype == 3 || input.u_albedotype == 4 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 8 || input.u_albedotype == 9 || input.u_albedotype == 10 || input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 14 || input.u_albedotype == 15 || input.u_albedotype == 18 || input.u_albedotype == 19 || input.u_albedotype == 20" }
uniform sampler2D detailTex;
//: param custom { "default": [1,1,0,0], "label": "Detail Transform", "group": "ALBEDO", "visible": "input.u_albedotype == 0 || input.u_albedotype == 1 || input.u_albedotype == 3 || input.u_albedotype == 4 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 8 || input.u_albedotype == 9 || input.u_albedotype == 10 || input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 14 || input.u_albedotype == 15 || input.u_albedotype == 18 || input.u_albedotype == 19 || input.u_albedotype == 20" }
uniform vec4 u_detailxform;
//: param custom { "default": true, "label": "Detail Map is Linear", "group": "ALBEDO", "visible": "input.u_albedotype == 0 || input.u_albedotype == 1 || input.u_albedotype == 3 || input.u_albedotype == 4 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 8 || input.u_albedotype == 9 || input.u_albedotype == 10 || input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 14 || input.u_albedotype == 15 || input.u_albedotype == 18 || input.u_albedotype == 19 || input.u_albedotype == 20" }
uniform bool b_detaillinear;
//: param custom { "default": "default_detail", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Detail Map2", "group": "ALBEDO", "visible" : "input.u_albedotype == 1 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 9" }
uniform sampler2D detail2Tex;
//: param custom { "default": [1,1,0,0], "label": "Detail2 Transform", "group": "ALBEDO", "visible" : "input.u_albedotype == 1 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 9" }
uniform vec4 u_detail2xform;
//: param custom { "default": true, "label": "Detail Map2 is Linear", "group": "ALBEDO", "visible" : "input.u_albedotype == 1 || input.u_albedotype == 5 || input.u_albedotype == 6 || input.u_albedotype == 7 || input.u_albedotype == 9" }
uniform bool b_detail2linear;
//: param custom { "default": "default_detail", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Detail Map3", "group": "ALBEDO", "visible" : "input.u_albedotype == 5" }
uniform sampler2D detail3Tex;
//: param custom { "default": [1,1,0,0], "label": "Detail3 Transform", "group": "ALBEDO", "visible" : "input.u_albedotype == 5" }
uniform vec4 u_detail3xform;
//: param custom { "default": true, "label": "Detail Map3 is Linear", "group": "ALBEDO", "visible" : "input.u_albedotype == 5" }
uniform bool b_detail3linear;
//: param custom { "default": "default_detail", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Detail Map Overlay", "group": "ALBEDO", "visible" : "input.u_albedotype == 6" }
uniform sampler2D detailoverlayTex;
//: param custom { "default": [1,1,0,0], "label": "Detail Map Overlay Transform", "group": "ALBEDO", "visible" : "input.u_albedotype == 6" }
uniform vec4 u_detailoverxform;
//: param custom { "default": true, "label": "Detail Map Overlay is Linear", "group": "ALBEDO", "visible" : "input.u_albedotype == 6" }
uniform bool b_detailoverlinear;

//: param custom { "default": [1,1,1,1], "label": "Albedo Color + Albedo Alpha", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 0 || input.u_albedotype == 2 || input.u_albedotype == 8 || input.u_albedotype == 14 || input.u_albedotype == 16 || input.u_albedotype == 17 || input.u_albedotype == 18 || input.u_albedotype == 19" }
uniform vec4 albedo_color;
//: param custom { "default": [1,1,1,1], "label": "Albedo Color 2 + Albedo 2 Alpha", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 8" }
uniform vec4 albedo_color2;
//: param custom { "default": [1,1,1,1], "label": "Albedo Color 3 + Albedo 3 Alpha", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 8" }
uniform vec4 albedo_color3;
//: param custom { "default": [1,1,1], "label": "Neutral Gray", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 8" }
uniform vec3 neutral_gray;

//: param custom { "default": [1,0,1], "label": "Chameleon Color 0", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16" }
uniform vec3 chameleon_color0;
//: param custom { "default": [0,1,1], "label": "Chameleon Color 1", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16" }
uniform vec3 chameleon_color1;
//: param custom { "default": [1,1,0], "label": "Chameleon Color 2", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16" }
uniform vec3 chameleon_color2;
//: param custom { "default": [1,0,0], "label": "Chameleon Color 3", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16" }
uniform vec3 chameleon_color3;
//: param custom { "default": 0.33, "label": "Chameleon Color Offset 1", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16"}
uniform float chameleon_color_offset1;
//: param custom { "default": 0.67, "label": "Chameleon Color Offset 2", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16"}
uniform float chameleon_color_offset2;
//: param custom { "default": 2.0, "label": "Chameleon Fresnel Power", "group": "ALBEDO", "visible" : "input.u_albedotype == 11 || input.u_albedotype == 12 || input.u_albedotype == 13 || input.u_albedotype == 16"}
uniform float chameleon_fresnel_power;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Blend Map (It's a cubemap don't ask)", "group": "ALBEDO", "visible" : "input.u_albedotype == 18" }
uniform sampler2D blend_map;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Color Blend Mask Cubemap", "group": "ALBEDO", "visible" : "input.u_albedotype == 19" }
uniform sampler2D color_blend_mask_cubemap;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Color Cubemap", "group": "ALBEDO", "visible" : "input.u_albedotype == 20" }
uniform sampler2D color_cubemap;
//: param custom { "default": [1,1,1,1], "label": "Albedo Second Color + Alpha", "widget": "color", "group": "ALBEDO", "visible" : "input.u_albedotype == 18 || input.u_albedotype == 19" }
uniform vec4 albedo_second_color;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Color Texture", "group": "ALBEDO", "visible" : "input.u_albedotype == 21 || input.u_albedotype == 22" }
uniform sampler2D color_texture;
//: param custom { "default": [1,0], "label": "UV Speed", "group": "ALBEDO", "visible" : "input.u_albedotype == 21" }
uniform vec2 uv_speed;

//-----------Bump Mapping---------------------------------------------------------//
//: param custom { "default": "", "default_color": [0.5, 0.5, 1, 1.0], "label": "Bump Detail Map", "group": "BUMP MAPPING", "visible": "input.u_bumptype == 2 || input.u_bumptype == 3 || input.u_bumptype == 4 || input.u_bumptype == 5" }
uniform sampler2D bumpdetailtex;
//: param custom { "default": [1,1,0,0], "label": "Bump Detail Transform", "group": "BUMP MAPPING", "visible": "input.u_bumptype == 2 || input.u_bumptype == 3 || input.u_bumptype == 4 || input.u_bumptype == 5" }
uniform vec4 u_bumpdetailxform;
//: param auto channel_user6
uniform SamplerSparse bumpdetailmasktex;
//: param custom { "default": "", "default_color": [0.5, 0.5, 1, 1.0], "label": "Bump Detail Masked Map", "group": "BUMP MAPPING", "visible": "input.u_bumptype == 4" }
uniform sampler2D bumpdetailmaskedtex;
//: param custom { "default": [1,1,0,0], "label": "Bump Detail Masked Transform", "group": "BUMP MAPPING", "visible": "input.u_bumptype == 4" }
uniform vec4 u_bumpdetailmaskedxform;
//: param custom { "default": 1.0, "label": "Bump Detail Coefficient", "group": "BUMP MAPPING", "visible" : "input.u_bumptype == 2 || input.u_bumptype == 3 || input.u_bumptype == 4 || input.u_bumptype == 5" }
uniform float bump_detail_coefficient;
//: param custom { "default": 1.0, "label": "Bump Detail Masked Coefficient", "group": "BUMP MAPPING", "visible" : "input.u_bumptype == 4" }
uniform float bump_detail_masked_coefficient;
//: param custom { "default": false, "label": "Invert Mask", "group": "BUMP MAPPING", "visible": "input.u_bumptype == 3" }
uniform bool invert_mask;

//-----------Material Model-------------------------------------------------------//
//: param custom { "default": 1.0, "label": "Diffuse Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0" }
uniform float diffuse_coefficient;
//: param custom { "default": [1,1,1], "label": "Diffuse Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 diffuse_tint;
//: param custom { "default": 0.0, "label": "Specular Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 3 || input.u_materialmodel == 5 || input.u_materialmodel == 7 || input.u_materialmodel > 8" }
uniform float specular_coefficient;
//: param custom { "default": 0.0, "label": "Analytical Specular Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float analytical_specular_coefficient;
//: param custom { "default": 0.0, "label": "Area Specular Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float area_specular_coefficient;
//: param custom { "default": 0.1, "label": "Fresnel Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 5" }
uniform float fresnel_coefficient;


//: param custom { "default": [1,1,1], "label": "Specular Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 1 || input.u_materialmodel == 6 || input.u_materialmodel == 7 || input.u_materialmodel == 9 || input.u_materialmodel == 10 || input.u_materialmodel == 11 || input.u_materialmodel == 13 || input.u_materialmodel == 14" }
uniform vec3 specular_tint;
//: param custom { "default": 10, "label": "Specular Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float f_specular_power;
//: param custom { "default": 0, "label": "Environment Map Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float environment_map_coefficient;
//: param custom { "default": [1,1,1], "label": "Environment Map Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 environment_map_tint;

//: param custom { "default": [0.5,0.5,0.5], "label": "Fresnel Color", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 1 || input.u_materialmodel == 6 || input.u_materialmodel == 7 || input.u_materialmodel == 9 || input.u_materialmodel == 10 || input.u_materialmodel == 11 || input.u_materialmodel == 13 || input.u_materialmodel == 14 || input.u_materialmodel == 15 || input.u_materialmodel == 16" }
uniform vec3 fresnel_color;
//: param custom { "default": false, "label": "Use Fresnel Color Enviorment", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform bool use_fresnel_color_environment;
//: param custom { "default": [0.5,0.5,0.5], "label": "Fresnel Color", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform vec3 fresnel_color_environment;
//: param custom { "default": 1.0, "label": "Fresnel Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform float fresnel_power;
//: param custom { "default": 0.4, "label": "Roughness", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 1 || input.u_materialmodel == 5 || input.u_materialmodel == 7 || input.u_materialmodel == 9 || input.u_materialmodel == 10 || input.u_materialmodel == 11 || input.u_materialmodel == 13 || input.u_materialmodel == 14 || input.u_materialmodel == 15 || input.u_materialmodel == 16" }
uniform float roughness;

//: param custom { "default": 10, "label": "Normal Specular Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 12" }
uniform float normal_specular_power;
//: param custom { "default": [1,1,1], "label": "Normal Specular Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 12" }
uniform vec3 normal_specular_tint;
//: param custom { "default": 10, "label": "Glancing Specular Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 12" }
uniform float glancing_specular_power;
//: param custom { "default": [1,1,1], "label": "Glancing Specular Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 12" }
uniform vec3 glancing_specular_tint;
//: param custom { "default": 5, "label": "Fresnel Curve Steepness", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 5 || input.u_materialmodel == 6 || input.u_materialmodel == 12" }
uniform float fresnel_curve_steepness;
//: param custom { "default": 0, "label": "Fresnel Curve Bias", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 5" }
uniform float fresnel_curve_bias;

//: param custom { "default": 0, "label": "Rim Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float rim_coefficient;
//: param custom { "default": [0,0,0], "label": "Rim Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 rim_tint;
//: param custom { "default": 2, "label": "Rim Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float rim_power;
//: param custom { "default": 0.7, "label": "Rim Start", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float rim_start;
//: param custom { "default": 0, "label": "Rim Maps Transition Ratio", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float rim_maps_transition_ratio;
//: param custom { "default": 0, "label": "Ambient Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float ambient_coefficient;
//: param custom { "default": [1,1,1], "label": "Ambient Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 ambient_tint;
//: param auto channel_ambientocclusion
uniform SamplerSparse occlusion_parameter_map;
//: param custom { "default": 0, "label": "Subsurface Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float subsurface_coefficient;
//: param custom { "default": [1,1,1], "label": "Subsurface Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 subsurface_tint;
//: param custom { "default": 0, "label": "Subsurface Propagation Bias", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float subsurface_propagation_bias;
//: param custom { "default": 0, "label": "Subsurface Normal Detail", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float subsurface_normal_detail;
//: param auto channel_scatteringcolor
uniform SamplerSparse subsurface_map;
//: param auto channel_scattering
uniform SamplerSparse subsurface_map_scattering;
//: param custom { "default": 0, "label": "Transparence Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float transparence_coefficient;
//: param custom { "default": [1,1,1], "label": "Transparence Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 transparence_tint;
//: param custom { "default": 0, "label": "Transparence Normal Bias", "group": "MATERIAL MODEL", "min": -1.0, "max": 1.0, "visible" : "input.u_materialmodel == 6" }
uniform float transparence_normal_bias;
//: param custom { "default": 0, "label": "Transparence Normal Detail", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform float transparence_normal_detail;
//: param auto channel_transmissive
uniform SamplerSparse transparence_map;
//: param auto channel_translucency
uniform SamplerSparse transparence_map_translucency;
//: param custom { "default": [1,1,1], "label": "Final Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 6" }
uniform vec3 final_tint;
//: param auto channel_specular
uniform SamplerSparse specular_map;

//: param custom { "default": 0.5, "label": "Area Specular Contribution", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 6 || input.u_materialmodel > 6" }
uniform float area_specular_contribution;
//: param custom { "default": 0.5, "label": "Analytical Specular Contribution", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 6 || input.u_materialmodel > 6" }
uniform float analytical_specular_contribution;
//: param custom { "default": 0.0, "label": "Environment Map Specular Contribution", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 6 || input.u_materialmodel > 6" }
uniform float environment_map_specular_contribution;
//: param custom { "default": false, "label": "Use Material Texture", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 2 || input.u_materialmodel > 9 && input.u_materialmodel < 13 || input.u_materialmodel > 12" }
uniform bool use_material_texture;
//: param custom { "default": false, "label": "Order 3 Area Specular", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel > 0 && input.u_materialmodel < 3 || input.u_materialmodel > 9" }
uniform bool order3_area_specular;

//: param custom { "default": false, "label": "Albedo Blend With Specular Tint", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform bool albedo_blend_with_specular_tint;
//: param custom { "default": 0.0, "label": "Albedo Blend", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 1 || input.u_materialmodel == 9 || input.u_materialmodel == 10 || input.u_materialmodel == 11 || input.u_materialmodel == 13 || input.u_materialmodel == 14 || input.u_materialmodel == 15 || input.u_materialmodel == 16" }
uniform float albedo_blend;
//: param custom { "default": 0.0, "label": "Albedo Specular Tint Blend", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 2 || input.u_materialmodel == 12" }
uniform float albedo_specular_tint_blend;

//: param custom { "default": 0, "label": "Rim Fresnel Coefficient", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform float rim_fresnel_coefficient;
//: param custom { "default": [1,1,1], "label": "Rim Fresnel Color", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform vec3 rim_fresnel_color;
//: param custom { "default": 2.0, "label": "Rim Fresnel Power", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform float rim_fresnel_power;
//: param custom { "default": 0, "label": "Rim Fresnel Albedo Blend", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 14" }
uniform float rim_fresnel_albedo_blend;

//: param custom { "default": false, "label": "Use Material Texture0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform bool use_material_texture0;
//: param custom { "default": false, "label": "Use Material Texture1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform bool use_material_texture1;
//: param custom { "default": "sparklenoisemap", "default_color": [0.5, 0.5, 1, 1.0], "label": "Bump Detail Map0", "group": "MATERIAL MODEL", "visible": "input.u_materialmodel == 8" }
uniform sampler2D bump_detail_map0;
//: param custom { "default": [1,1,0,0], "label": "Bump Detail Map0 Transform", "group": "MATERIAL MODEL", "visible": "input.u_materialmodel == 8" }
uniform vec4 bump_detail_map0_xform;

//: param custom { "default": 0.75, "label": "Bump Detail Map0 Blend Factor", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float bump_detail_map0_blend_factor;

//: param custom { "default": 0.25, "label": "Diffuse Coefficient0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float diffuse_coefficient0;
//: param custom { "default": 1, "label": "Specular Coefficient0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float specular_coefficient0;
//: param custom { "default": [1,1,1], "label": "Specular Tint0", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 specular_tint0;
//: param custom { "default": [0.733,0.733,0.733], "label": "Fresnel Color0", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 fresnel_color0;
//: param custom { "default": 1.0, "label": "Fresnel Power0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float fresnel_power0;
//: param custom { "default": 0.0, "label": "Albedo Blend0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float albedo_blend0;
//: param custom { "default": 0.5, "label": "Rughness0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float roughness0;
//: param custom { "default": 0.3, "label": "Area Specular Contribution0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float area_specular_contribution0;
//: param custom { "default": 0.5, "label": "Analytical Specular Contribution0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float analytical_specular_contribution0;
//: param custom { "default": false, "label": "Order 3 Area Specular0", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform bool order3_area_specular0;

//: param custom { "default": 0, "label": "Diffuse Coefficient1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float diffuse_coefficient1;
//: param custom { "default": 0.15, "label": "Specular Coefficient1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float specular_coefficient1;
//: param custom { "default": [1,1,1], "label": "Specular Tint1", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 specular_tint1;
//: param custom { "default": [0.733,0.733,0.733], "label": "Fresnel Color1", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 fresnel_color1;
//: param custom { "default": [0.733,0.733,0.733], "label": "Fresnel Color Environment1", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 fresnel_color_environment1;
//: param custom { "default": 1.0, "label": "Fresnel Power1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float fresnel_power1;
//: param custom { "default": 0.0, "label": "Albedo Blend1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float albedo_blend1;
//: param custom { "default": 0.1, "label": "Rughness1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float roughness1;
//: param custom { "default": 0.1, "label": "Area Specular Contribution1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float area_specular_contribution1;
//: param custom { "default": 0.2, "label": "Analytical Specular Contribution1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float analytical_specular_contribution1;
//: param custom { "default": 1.0, "label": "Environment Map Specular Contribution1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float environment_map_specular_contribution1;
//: param custom { "default": false, "label": "Order 3 Area Specular1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform bool order3_area_specular1;

//: param custom { "default": 1.0, "label": "Rim Fresnel Coefficient1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float rim_fresnel_coefficient1;
//: param custom { "default": [0.733,0.733,0.733], "label": "Rim Fresnel Color1", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform vec3 rim_fresnel_color1;
//: param custom { "default": 1.0, "label": "Rim Fresnel Power1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float rim_fresnel_power1;
//: param custom { "default": 1.0, "label": "Rim Fresnel Albedo Blend1", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 8" }
uniform float rim_fresnel_albedo_blend1;

//: param custom { "default": "gray_50_percent", "default_color": [0.5, 0.5, 0.5, 1.0], "label": "Specular Blend Map", "group": "MATERIAL MODEL", "description": "Texture must be a cube", "visible": "input.u_materialmodel == 11" }
uniform sampler2D spec_blend_map;
//: param custom { "default": "gray_50_percent", "default_color": [0.5, 0.5, 0.5, 1.0], "label": "Tint Blend Mask Cubemap", "group": "MATERIAL MODEL", "description": "Texture must be a cube", "visible": "input.u_materialmodel == 13" }
uniform sampler2D tint_blend_mask_cubemap;
//: param custom { "default": "gray_50_percent", "default_color": [0.5, 0.5, 0.5, 1.0], "label": "Spec Tint Cubemap", "group": "MATERIAL MODEL", "description": "Texture must be a cube", "visible": "input.u_materialmodel == 15" }
uniform sampler2D spec_tint_cubemap;
//: param custom { "default": [1,1,1], "label": "Second Specular Tint", "widget": "color", "group": "MATERIAL MODEL", "visible" : "input.u_materialmodel == 11 || input.u_materialmodel == 13" }
uniform vec3 specular_second_tint;

//: param auto channel_user7
uniform SamplerSparse specularcoeftex;
//: param auto channel_user8
uniform SamplerSparse albedoblendtex;
//: param auto channel_user9
uniform SamplerSparse enviornmentcontribtex;
//: param auto channel_roughness
uniform SamplerSparse roughnesstex;
//: param auto channel_metallic
uniform SamplerSparse metallictex;
//: param auto channel_specularedgecolor
uniform SamplerSparse glancing_specular_tint_map;

//-----------Enviorment Mapping---------------------------------------------------//
//: param custom { "default": "default_dynamic_cube_map", "default_color": [0.5, 0.5, 0.5, 1.0], "label": "Enviorment Map", "group": "ENVIORMENT MAPPING", "description": "Texture must be a cube", "visible": "input.u_envmapping == 1" }
uniform sampler2D environment_map;
//: param custom { "default": "", "default_color": [0.5, 0.5, 0.5, 1.0], "label": "Enviorment Map", "group": "ENVIORMENT MAPPING", "description": "Texture must be a cube", "visible": "input.u_envmapping == 3 || input.u_envmapping == 5" }
uniform sampler2D flat_environment_map;
//: param custom { "default": [1,1,1], "label": "Env Tint Color", "widget": "color", "group": "ENVIORMENT MAPPING", "visible": "input.u_envmapping > 0" }
uniform vec3 env_tint_color;
//: param custom { "default": 1.0, "label": "Env Roughness Scale", "group": "ENVIORMENT MAPPING", "visible": "input.u_envmapping == 2" }
uniform float env_roughness_scale;
//: param custom { "default": 1.0, "label": "Hemisphere Percentage", "group": "ENVIORMENT MAPPING", "visible": "input.u_envmapping == 3 || input.u_envmapping == 5" }
uniform float hemisphere_percentage;
//: param custom { "default": [0,0,0,1], "label": "Env Bloom Override", "widget": "color", "group": "ENVIORMENT MAPPING", "visible": "input.u_envmapping == 3 || input.u_envmapping == 5" }
uniform vec4 env_bloom_override;
//: param custom { "default": 1.0, "label": "Env Bloom Override Intensity", "group": "ENVIORMENT MAPPING", "visible": "input.u_envmapping == 3 || input.u_envmapping == 5" }
uniform float env_bloom_override_intensity;

//-----------Self Illumination----------------------------------------------------//
//: param auto channel_emissive
uniform SamplerSparse self_illum_map;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Self Illum Detail Map", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 5 || input.u_selfillum == 10" }
uniform sampler2D self_illum_detail_map;
//: param custom { "default": [1,1,0,0], "label": "Self Illum Detail Map Transform", "group": "SELF ILLUMINATION", "description": "Offset is affected by time only in substance", "visible": "input.u_selfillum == 5 || input.u_selfillum == 10" }
uniform vec4 self_illum_detail_map_xform;
//: param custom { "default": [1,1,1], "label": "Self Illum Color", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 1 || input.u_selfillum == 4 || input.u_selfillum == 5 || input.u_selfillum == 7 || input.u_selfillum == 8" }
uniform vec3 self_illum_color;

//: param custom { "default": [1,1,1,1], "label": "Channel A", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 2" }
uniform vec4 channel_a;
//: param custom { "default": [1,1,1,1], "label": "Channel B", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 2" }
uniform vec4 channel_b;
//: param custom { "default": [1,1,1,1], "label": "Channel C", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 2" }
uniform vec4 channel_c;

//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Noise Map A", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform sampler2D noise_map_a;
//: param custom { "default": [1,1,0,0], "label": "Noise Map A Transform", "group": "SELF ILLUMINATION", "description": "Offset is affected by time only in substance", "min": -20, "max":20, "visible": "input.u_selfillum == 3" }
uniform vec4 noise_map_a_xform;
//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Noise Map B", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform sampler2D noise_map_b;
//: param custom { "default": [1,1,0,0], "label": "Noise Map B Transform", "group": "SELF ILLUMINATION", "description": "Offset is affected by time only in substance", "min": -20, "max":20, "visible": "input.u_selfillum == 3" }
uniform vec4 noise_map_b_xform;
//: param custom { "default": [1,1,1,1], "label": "Color Medium", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform vec4 color_medium;
//: param custom { "default": [1,1,1,1], "label": "Color Sharp", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform vec4 color_sharp;
//: param custom { "default": [1,1,1,1], "label": "Color Wide", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform vec4 color_wide;
//: param auto channel_user10
uniform SamplerSparse alpha_mask_map;

//: param custom { "default": 1.0, "label": "Self Illum Intensity", "group": "SELF ILLUMINATION", "min": 0.0, "max": 1000, "visible": "input.u_selfillum >= 1 && input.u_selfillum < 6 || input.u_selfillum > 6" }
uniform float self_illum_intensity;

//: param custom { "default": 0, "label": "Primary Change Color Blend", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 7 || input.u_selfillum == 11" }
uniform float primary_change_color_blend;

//: param custom { "default": 16, "label": "Thinness Medium", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform float thinness_medium;
//: param custom { "default": 4, "label": "Thinness Sharp", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform float thinness_sharp;
//: param custom { "default": 32, "label": "Thinness Wide", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 3" }
uniform float thinness_wide;

//: param auto channel_user11
uniform SamplerSparse meter_map;
//: param auto channel_user12
uniform SamplerSparse self_illum_alpha;
//: param custom { "default": [1,0,0], "label": "Meter Color Off", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 6" }
uniform vec3 meter_color_off;
//: param custom { "default": [0,1,0], "label": "Meter Color On", "widget": "color", "group": "SELF ILLUMINATION", "visible": "input.u_selfillum == 6" }
uniform vec3 meter_color_on;
//: param custom { "default": 0.5, "label": "Meter Value", "group": "SELF ILLUMINATION", "min": 0.0, "max":1.0, "visible": "input.u_selfillum == 6" }
uniform float meter_value;

//-----------Parallax-------------------------------------------------------------//
//: param auto channel_displacement
uniform SamplerSparse height_map;
//: param custom { "default": 0.5, "label": "Parallax Scale", "group": "PARALLAX", "visible": "input.u_parallax > 0" }
uniform float height_scale;
//: param auto channel_user13
uniform SamplerSparse height_scale_map;

//-----------Soft Fade------------------------------------------------------------//
//: param custom { "default": false, "label": "Use Soft Fresnel", "group": "SOFT FADE", "visible" : "input.u_softfade == 1" }
uniform bool use_soft_fresnel;
//: param custom { "default": 0, "label": "Soft Fresnel Power", "group": "SOFT FADE", "visible": "input.u_softfade == 1" }
uniform float soft_fresnel_power;
//: param custom { "default": false, "label": "Use Soft Z", "group": "SOFT FADE", "visible" : "input.u_softfade == 1" }
uniform bool use_soft_z;
//: param custom { "default": 0, "label": "Soft Z Range", "group": "SOFT FADE", "visible": "input.u_softfade == 1" }
uniform float soft_z_range;

//-----------Misc Attr Animation--------------------------------------------------//
//: param custom { "default": 0, "label": "Scrolling Axis X", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 1" }
uniform float scrolling_axis_x;
//: param custom { "default": 1, "label": "Scrolling Axis Y", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 1" }
uniform float scrolling_axis_y;
//: param custom { "default": 0, "label": "Scrolling Axis Z", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 1" }
uniform float scrolling_axis_z;
//: param custom { "default": 1, "label": "Scrolling Speed", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 1" }
uniform float scrolling_speed;

//: param custom { "default": 0, "label": "Object Center X", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float object_center_x;
//: param custom { "default": 0, "label": "Object Center Y", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float object_center_y;
//: param custom { "default": 0.65, "label": "Object Center Z", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float object_center_z;
//: param custom { "default": 0, "label": "Plane U X", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_u_x;
//: param custom { "default": 1, "label": "Plane U Y", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_u_y;
//: param custom { "default": 0, "label": "Plane U Z", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_u_z;
//: param custom { "default": 0, "label": "Plane V X", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_v_x;
//: param custom { "default": 0, "label": "Plane V Y", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_v_y;
//: param custom { "default": 1, "label": "Plane V Z", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float plane_v_z;
//: param custom { "default": 1, "label": "Scale V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float scale_u;
//: param custom { "default": 1, "label": "Scale V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float scale_v;
//: param custom { "default": 0, "label": "Translate V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float translate_u;
//: param custom { "default": 0, "label": "Translate V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float translate_v;
//: param custom { "default": 0.1, "label": "Speed V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float speed_u;
//: param custom { "default": 0, "label": "Speed V", "group": "MISC ATTR ANIMATION", "visible": "input.u_misc_anim == 2" }
uniform float speed_v;

//: param custom { "default": "gray_50_percent", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Custom Cube", "group": "CROSS CATEGORY", "visible" : "input.u_albedotype == 17 || input.u_materialmodel == 9" }
uniform sampler2D custom_cube;

//: param custom { "default": "cc0236", "default_color": [0.0, 0.0, 0.0, 0.0], "label": "cc0236", "group": "Rasterizer" }
uniform sampler2D cc0236;
//: param custom { "default": "dd0236", "default_color": [0.0, 0.0, 0.0, 0.0], "label": "dd0236", "group": "Rasterizer" }
uniform sampler2D dd0236;
//: param custom { "default": "c78d78", "default_color": [0.0, 0.0, 0.0, 0.0], "label": "c78d78", "group": "Rasterizer" }
uniform sampler2D c78d78;

// modified
//: param custom { "default": 0, "label": "Time", "min": 0.0, "max":100, "visible" : true }
uniform float Time;

/*Common parameters and functions*/
const float SQRT3 = 1.73205080756;
const float DETAIL_MULTIPLIER = 4.59479;
const float c_view_z_shift = 0.5/32.0;

vec4[10] shCoeffs (vec3 normal)
{
  /*vec2 uv = FragCoord.xy / uniform_screen_size.zw;
  float theta = uv.y * M_PI;
  float phi = (uv.x - 0.5) * 2.0 * M_PI;
  //vec3 irradiance = texture(environment_texture, worldToEnvSpace(normal).xy).rgb;
  vec3 direction = sphericalToCartesian(theta, phi);
  vec4 envColor = texture(environment_texture, uv);
  envColor.a = dot(envColor.rgb, vec3(0.299, 0.587, 0.114));
  envColor *= environment_exposure;*/
  vec4 sh_coefficients[9];


  float Y00 = 0.282095;
  float Y1n = 0.488603; // 3 direction dependent values
  float Y2n = 1.092548; // 3 direction dependent values
  float Y20 = 0.315392;
  float Y22 = 0.546274;

  float CosineA1 = (2.0 * M_PI) / 3.0;
  float CosineA2 = M_PI * 0.25;

  float c1 = 0.429043;
  float c2 = 0.511664;
  float c3 = 0.743125;
  float c4 = 0.886227;
  float c5 = 0.247708;


  sh_coefficients[1].xyz = vec3(irrad_mat_red[1].w, irrad_mat_green[1].w, irrad_mat_blue[1].w) / c2;
  sh_coefficients[2].xyz = vec3(irrad_mat_red[2].w, irrad_mat_green[2].w, irrad_mat_blue[2].w) / c2;
  sh_coefficients[3].xyz = vec3(irrad_mat_red[0].w, irrad_mat_green[0].w, irrad_mat_blue[0].w) / c2;
  sh_coefficients[4].xyz = vec3(irrad_mat_red[1].r, irrad_mat_green[1].r, irrad_mat_blue[1].r) / c1;
  sh_coefficients[5].xyz = vec3(irrad_mat_red[1].b, irrad_mat_green[1].b, irrad_mat_blue[1].b) / c1;
  sh_coefficients[6].xyz = vec3(irrad_mat_red[2].b, irrad_mat_green[2].b, irrad_mat_blue[2].b) / c3;
  sh_coefficients[7].xyz = vec3(irrad_mat_red[0].b, irrad_mat_green[0].b, irrad_mat_blue[0].b) / c1;
  sh_coefficients[8].xyz = vec3(irrad_mat_red[0].r, irrad_mat_green[0].r, irrad_mat_blue[0].r) / c1;
  sh_coefficients[0].xyz = (vec3(irrad_mat_red[3].w, irrad_mat_green[3].w, irrad_mat_blue[3].w) - (c5 *sh_coefficients[6].xyz)) / c4;
  
  /*for(int i = 0; i < 9; i++)
  {
    //sh_coefficients[i].a = 0;
    sh_coefficients[i].rgb = abs(sh_coefficients[i].rgb);
    //sh_coefficients[i].rgb = normalize(sh_coefficients[i].rgb);
    //sh_coefficients[i].rgb *= 0.5 + 0.5;
  }*/
  
  //normal = worldToEnvSpace(normal);
  sh_coefficients[0] *= M_PI * Y00;
  sh_coefficients[1] *= CosineA1 * Y1n * normal.y;
  sh_coefficients[2] *= CosineA1 * Y1n * normal.z;
  sh_coefficients[3] *= CosineA1 * Y1n * normal.x;
  sh_coefficients[4] *= CosineA2 * Y2n * normal.x * normal.y;
  sh_coefficients[5] *= CosineA2 * Y2n * normal.y * normal.z;
  sh_coefficients[6] *= CosineA2 * Y2n * (3 * pow(normal.z, 2) - 1);
  sh_coefficients[7] *= CosineA2 * Y20 * normal.x * normal.z;
  sh_coefficients[8] *= CosineA2 * Y22 * (pow(normal.x, 2) - pow(normal.y, 2));

  /*sh_coefficients[0] *= M_PI * Y00;
  sh_coefficients[1] *= abs(normal.y);
  sh_coefficients[2] *= abs(normal.z);
  sh_coefficients[3] *= abs(normal.x);
  sh_coefficients[4] *= abs(normal.x * normal.y);
  sh_coefficients[5] *= abs(normal.y * normal.z);
  sh_coefficients[6] *= abs((3 * pow(normal.z, 2) - 1));
  sh_coefficients[7] *= abs(normal.x * normal.z);
  sh_coefficients[8] *= abs(pow(normal.x, 2) - pow(normal.y, 2));*/

  vec4 lighting_constants[10];

  lighting_constants[0] = vec4(sh_coefficients[0].rgb, 0);

  lighting_constants[1] = vec4(sh_coefficients[3].r, sh_coefficients[1].r, -sh_coefficients[2].r, 0);
  lighting_constants[2] = vec4(sh_coefficients[3].g, sh_coefficients[1].g, -sh_coefficients[2].g, 0);
  lighting_constants[3] = vec4(sh_coefficients[3].b, sh_coefficients[1].b, -sh_coefficients[2].b, 0);

  lighting_constants[4] = vec4(-sh_coefficients[4].r, sh_coefficients[5].r, sh_coefficients[7].r, 0);
  lighting_constants[5] = vec4(-sh_coefficients[4].g, sh_coefficients[5].g, sh_coefficients[7].g, 0);
  lighting_constants[6] = vec4(-sh_coefficients[4].b, sh_coefficients[5].b, sh_coefficients[7].b, 0);

  lighting_constants[7] = vec4(-sh_coefficients[8].r, sh_coefficients[8].r, -sh_coefficients[6].r*1.73205080756, sh_coefficients[6].r*1.73205080756);
  lighting_constants[8] = vec4(-sh_coefficients[8].g, sh_coefficients[8].g, -sh_coefficients[6].g*1.73205080756, sh_coefficients[6].g*1.73205080756);
  lighting_constants[9] = vec4(-sh_coefficients[8].b, sh_coefficients[8].b, -sh_coefficients[6].b*1.73205080756, sh_coefficients[6].b*1.73205080756);

  /*for(int i = 0; i < 10; i++)
  {
    lighting_constants[i].rgb = worldToEnvSpace(lighting_constants[i].rgb);
  }*/
  
  return lighting_constants;
}

vec2 uvoffsetTime(vec4 transform)
{
  bool xiszero = (transform.z == 0);
  bool yiszero = (transform.w == 0);
  transform = 30/(transform * 30);

  float u = (!xiszero) ? transform.z * Time : 0;
  float v = (!yiszero) ? transform.w * Time : 0;

  return vec2(u,v);
}

float safe_pow(float x, float y)
{
  if (y == 0){
    return 1;
  }
  else{
    return pow(x, y);
  }
}

vec4 cubeSample(sampler2D cube, vec3 dir, float lod)
{
    vec2 pos = M_INV_PI * vec2(atan(-dir.z, -1.0 * dir.x), 2.0 * asin(dir.y));
    pos = 0.5 * pos + vec2(0.5);
    return textureLod(cube, pos, lod);
}

vec4 cubemapSampleHalo(sampler2D t_cube, vec3 normal)
{
    float x = normal.x;
    float y = normal.y;
    float z = normal.z;

    float absX = abs(x);
    float absY = abs(y);
    float absZ = abs(z);

    bool isXPositive = x > 0 ? true : false;
    bool isYPositive = y > 0 ? true : false;
    bool isZPositive = z > 0 ? true : false;

    float maxAxis, uc, vc;

    int index;

    // POSITIVE X
    if(isXPositive && absX >= absY && absX >= absZ){
        maxAxis = absX;
        uc = -z;
        vc = y;
        index = 0;
    }
    // NEGATIVE X
    if(!isXPositive && absX >= absY && absX >= absZ){
        maxAxis = absX;
        uc = z;
        vc = y;
        index = 1;
    }
    // POSITIVE Y
    if(isYPositive && absY >= absX && absY >= absZ){
        maxAxis = absY;
        uc = x;
        vc = -z;
        index = 2;
    }
    // NEGATIVE Y
    if(!isYPositive && absY >= absX && absY >= absZ){
        maxAxis = absY;
        uc = x;
        vc = z;
        index = 3;
    }
    // POSITIVE Z
    if(isZPositive && absZ >= absX && absZ >= absY){
        maxAxis = absZ;
        uc = x;
        vc = y;
        index = 4;
    }
    // NEGATIVE Z
    if(!isZPositive && absZ >= absX && absZ >= absY){
        maxAxis = absZ;
        uc = -x;
        vc = y;
        index = 5;
    }

    vec2 uv;
    uv.x = 0.5 * (uc / maxAxis + 1.0);
    uv.y = 0.5 * (vc / maxAxis + 1.0);

    uv *= vec2(0.25, .333);
    float minclamp = 0.005;
    float maxclamp = 0.995;

    //remap faces and clamp
    if(index == 0){
        uv += vec2(.25,.333);
        uv = clamp(uv, vec2(.25, .333 + minclamp),vec2(.5, maxclamp - .333));
    }
    if(index == 1){
        uv += vec2(.75,.333);
        uv = clamp(uv, vec2(.75, .333 + minclamp),vec2(1, maxclamp - .333));
    }
    if(index == 2){
        uv += vec2(0,.666);
        uv = clamp(uv, vec2(minclamp, .666 + minclamp),vec2(maxclamp - .75, maxclamp));
    }
    if(index == 3){
        uv = clamp(uv, vec2(minclamp, minclamp), vec2(maxclamp - .75, .333));
    }
    if(index == 4){
        uv += vec2(0,.333);
        uv = clamp(uv, vec2(0, minclamp + .333), vec2(.25, maxclamp - .333));
    }
    if(index == 5){
        uv += vec2(.5,.333);
        uv = clamp(uv, vec2(.5, minclamp + .333), vec2(75, maxclamp - .333));
    }

    return texture(t_cube, uv);
}

vec4 cubemapSampleHalo(sampler2D t_cube, vec3 normal, float lod)
{
    float x = normal.x;
    float y = normal.y;
    float z = normal.z;

    float absX = abs(x);
    float absY = abs(y);
    float absZ = abs(z);

    bool isXPositive = x > 0 ? true : false;
    bool isYPositive = y > 0 ? true : false;
    bool isZPositive = z > 0 ? true : false;

    float maxAxis, uc, vc;

    int index;

    // POSITIVE X
    if(isXPositive && absX >= absY && absX >= absZ){
        maxAxis = absX;
        uc = -z;
        vc = y;
        index = 0;
    }
    // NEGATIVE X
    if(!isXPositive && absX >= absY && absX >= absZ){
        maxAxis = absX;
        uc = z;
        vc = y;
        index = 1;
    }
    // POSITIVE Y
    if(isYPositive && absY >= absX && absY >= absZ){
        maxAxis = absY;
        uc = x;
        vc = -z;
        index = 2;
    }
    // NEGATIVE Y
    if(!isYPositive && absY >= absX && absY >= absZ){
        maxAxis = absY;
        uc = x;
        vc = z;
        index = 3;
    }
    // POSITIVE Z
    if(isZPositive && absZ >= absX && absZ >= absY){
        maxAxis = absZ;
        uc = x;
        vc = y;
        index = 4;
    }
    // NEGATIVE Z
    if(!isZPositive && absZ >= absX && absZ >= absY){
        maxAxis = absZ;
        uc = -x;
        vc = y;
        index = 5;
    }

    vec2 uv;
    uv.x = 0.5 * (uc / maxAxis + 1.0);
    uv.y = 0.5 * (vc / maxAxis + 1.0);

    uv *= vec2(0.25, .333);
    float minclamp = 0.005;
    float maxclamp = 0.995;

    //remap faces and clamp
    if(index == 0){
        uv += vec2(.25,.333);
        uv = clamp(uv, vec2(.25, .333 + minclamp),vec2(.5, maxclamp - .333));
    }
    if(index == 1){
        uv += vec2(.75,.333);
        uv = clamp(uv, vec2(.75, .333 + minclamp),vec2(1, maxclamp - .333));
    }
    if(index == 2){
        uv += vec2(0,.666);
        uv = clamp(uv, vec2(minclamp, .666 + minclamp),vec2(maxclamp - .75, maxclamp));
    }
    if(index == 3){
        uv = clamp(uv, vec2(minclamp, minclamp), vec2(maxclamp - .75, .333));
    }
    if(index == 4){
        uv += vec2(0,.333);
        uv = clamp(uv, vec2(0, minclamp + .333), vec2(.25, maxclamp - .333));
    }
    if(index == 5){
        uv += vec2(.5,.333);
        uv = clamp(uv, vec2(.5, minclamp + .333), vec2(75, maxclamp - .333));
    }

    return textureLod(t_cube, uv, lod);
}

float apply_black_point(float black_point, float alpha)
{
  float mid_point = (black_point + 1.0)/2.0;

  return mid_point * clamp((alpha - black_point)/(mid_point - black_point), 0.0, 1.0) + clamp(alpha - mid_point, 0.0, 1.0);
}

vec3 calc_chameleon(vec3 normal, vec3 view_dir)
{
  float dp = pow(max(dot(normal, view_dir), 0.0), chameleon_fresnel_power);

  vec3 col0 = chameleon_color0;
  vec3 col1 = chameleon_color1;
  float lrp = dp * (1.0 / chameleon_color_offset1);

  if (dp > chameleon_color_offset1){
    col0 = chameleon_color1;
    col1 = chameleon_color2;
    lrp = (dp - chameleon_color_offset1) * (1.0 / (chameleon_color_offset2 - chameleon_color_offset1));
  }
  if (dp > chameleon_color_offset2){
    col0 = chameleon_color2;
    col1 = chameleon_color3;
    lrp = (dp - chameleon_color_offset2) * (1.0 / (1.0 - chameleon_color_offset2));
  }

  return mix(col0, col1, lrp);
}

mat3 make_rotation_matrix(float angle, vec3 axis)
{
  float c, s;
  s = sin(angle);
  c = cos(angle);

  float t = 1 -c;
  float x = axis.x;
  float y  = axis.y;
  float z = axis.z;

  return mat3(
    t*x*x+c, t*x*y-s*z, t*x*z+s*y,
    t*x*y+s*z, t*y*y+c, t*y*z-s*x,
    t*x*z-s*y, t*y*z+s*x, t*z*z+c
  );
}

float SmoothStep(float x)
{
	return x * x * (3 - 2 * x);
}

float calc_fresnel_dp(in vec3 wnorm, in vec3 wview)
{
	//   float3 V = normalize(wpos - camPos);
	float NdotV = clamp(abs(dot(wnorm, wview)), 0.0, 1.0);
	NdotV = SmoothStep(NdotV);

	return NdotV;
}

vec2 z_to_w_coeffs()
{
	const float zf = 0.007812500f;
	const float zn = 10240.00000f;

	const vec2 k = vec2(
		zf / (zf - zn),
		-zn * zf / (zf - zn));
	return k;
}

float z_to_w(float z)
{
	vec2 k = z_to_w_coeffs();
	return k.y / (z - k.x);
}

float get_softness(float z1, float z2, float range)
{
	return clamp((z1 - z2) * range, 0.0, 1.0);
}

vec4 calc_misc_scrolling_cube_vs(vec3 normal)
{
  vec3 scrolling_axis = vec3(-scrolling_axis_y, -scrolling_axis_z, -scrolling_axis_x);
  vec3 rotated_normal = normal * make_rotation_matrix(Time * 1, scrolling_axis);

  return vec4(rotated_normal, 0.0);
}

vec4 calc_misc_scrolling_projected_vs(vec3 position)
{
  vec3 object_center = vec3(object_center_y, object_center_z, object_center_x);
  vec3 plane_u = vec3(plane_u_y, plane_u_z, plane_u_x);
  vec3 plane_v = vec3(plane_v_y, plane_v_z, plane_v_x);
  vec2 scale = vec2(scale_u, scale_v);
  vec2 translate = vec2(translate_u, translate_v);
  vec2 speed = vec2(speed_u, speed_v);

  vec3 vn = normalize(position - object_center);
  float u = dot(vn, plane_u);
  float v = dot(vn, plane_v);
  vec2 uv = acos(vec2(u,v)) / M_PI * scale + translate;
  uv += speed * Time;

  return vec4(uv, 0, 0);
}

vec4 misc_attr_animation(vec3 normal, vec3 position)
{
  vec4 misc;
  switch(u_misc_anim){
    case 0:
      misc = vec4(0);
      break;
    case 1:
      misc = calc_misc_scrolling_cube_vs(normal);
      break;
    case 2:
      misc = calc_misc_scrolling_projected_vs(position);
      break;
  }

  return misc;
}

/*Albedo Blending Functions*/
vec4 calc_albedo_default_ps(vec4 base, vec4 detail)
{
  vec4 albedo;
  albedo.rgb = base.rgb * (detail.rgb * DETAIL_MULTIPLIER) * albedo_color.rgb;
  albedo.w = base.w * detail.w * albedo_color.w;

  return albedo;
}

vec4 calc_albedo_detail_blend_ps(vec4 base, vec4 detail, vec4 detail2)
{
  vec4 albedo;
  albedo.rgb = (1 - base.w) * detail.rgb + base.w * detail2.rgb;
  albedo.rgb = DETAIL_MULTIPLIER * base.rgb * albedo.rgb;
  albedo.w = (1 - base.w) * detail.w + base.w * detail2.w;

  return albedo;
}

vec4 calc_albedo_three_detail_blend_ps(vec4 base, vec4 detail, vec4 detail2, vec4 detail3)
{
  vec4 albedo;
  float blend1 = clamp(2 * base.w, 0.0, 1.0);
  float blend2 = clamp(2 * base.w - 1, 0.0, 1.0);

  vec4 first_blend = (1 - blend1) * detail + blend1 * detail2;
  vec4 second_blend = (1 - blend2) * first_blend + blend2 * detail3;

  albedo.rgb = DETAIL_MULTIPLIER * base.rgb * second_blend.rgb;
  albedo.a = second_blend.a;

  return albedo;
}

vec4 calc_albedo_two_change_color_ps(vec4 base, vec4 detail, vec4 change_color)
{
  vec4 albedo;
  change_color.rgb = ((1 - change_color.r) + change_color.r * primary_change_color) * ((1 - change_color.g) + change_color.g * secondary_change_color);

  albedo.rgb = DETAIL_MULTIPLIER * base.rgb * detail.rgb * change_color.rgb;
  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_four_change_color_ps(vec4 base, vec4 detail, vec4 change_color)
{
  vec4 albedo;

  change_color.rgb = ((1 - change_color.r) + change_color.r * primary_change_color) *
                      ((1 - change_color.g) + change_color.g * secondary_change_color) *
                      ((1 - change_color.b) + change_color.b * tertiary_change_color) *
                      ((1 - change_color.a) + change_color.a * quaternary_change_color);

  albedo.rgb = DETAIL_MULTIPLIER * base.rgb * detail.rgb * change_color.rgb;
  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_two_detail_overlay_ps(vec4 base, vec4 detail, vec4 detail2, vec4 detail_overlay)
{
  vec4 albedo;

  vec4 detail_blend = (1 - base.a) * detail + base.a * detail2;

  albedo.rgb = base.rgb * (DETAIL_MULTIPLIER * DETAIL_MULTIPLIER) * detail_blend.rgb * detail_overlay.rgb;
  albedo.a = detail_blend.a * detail_overlay.a;

  return albedo;
}

vec4 calc_albedo_two_detail_ps(vec4 base, vec4 detail, vec4 detail2)
{
  vec4 albedo;

  albedo.rgb = base.rgb * (DETAIL_MULTIPLIER * DETAIL_MULTIPLIER) * detail.rgb * detail2.rgb;
  albedo.a = base.a * detail.a * detail2.a;

  return albedo;
}

vec4 calc_albedo_color_mask_ps(vec4 base, vec4 detail, vec4 color_mask)
{
  vec4 albedo;

  vec4 tint_color = ((1 - color_mask.r) + color_mask.r * albedo_color / vec4(neutral_gray, 1)) *
                    ((1 - color_mask.g) + color_mask.g * albedo_color2 / vec4(neutral_gray, 1)) *
                    ((1 - color_mask.b) + color_mask.b * albedo_color3 / vec4(neutral_gray, 1));

  albedo.rgb = base.rgb * (detail.rgb * DETAIL_MULTIPLIER) * tint_color.rgb;
  albedo.a = base.a * detail.a * tint_color.a;

  return albedo;
}

vec4 calc_albedo_two_detail_black_point_ps(vec4 base, vec4 detail, vec4 detail2)
{
  vec4 albedo;

  albedo.rgb = base.rgb * (DETAIL_MULTIPLIER * DETAIL_MULTIPLIER) * detail.rgb * detail2.rgb;
  albedo.a = apply_black_point(base.a, detail.a * detail2.a);

  return albedo;
}

vec4 calc_albedo_two_change_color_anim_ps(vec4 base, vec4 detail, vec4 change_color)
{
  vec4 albedo;

  vec3 cur_primary_change_color = primary_change_color_anim;
  vec3 cur_secondary_change_color = secondary_change_color_anim;

  albedo.rgb = DETAIL_MULTIPLIER * base.rgb * detail.rgb;

  cur_primary_change_color *= albedo.rgb;
  cur_secondary_change_color *= albedo.rgb;

  albedo.rgb = mix(albedo.rgb, cur_primary_change_color, change_color.x);
  albedo.rgb = mix(albedo.rgb, cur_secondary_change_color, change_color.y);
  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_chameleon_ps(vec4 base, vec4 detail, vec3 normal, vec3 view_dir)
{
  vec4 albedo;
  vec3 color = calc_chameleon(normal, view_dir);

  albedo.rgb = base.rgb * (detail.rgb * DETAIL_MULTIPLIER) * color;
  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_two_change_color_chameleon_ps(vec4 base, vec4 detail, vec4 change_color, vec3 normal, vec3 view_dir)
{
  vec4 albedo;

  vec3 cur_primary_change_color = primary_change_color_anim;
  vec3 cur_secondary_change_color = secondary_change_color_anim;

  vec3 color = calc_chameleon(normal, view_dir);

  albedo.rgb = base.rgb * (detail.rgb * DETAIL_MULTIPLIER) * color;

  vec3 cc = cur_primary_change_color * change_color.x + cur_secondary_change_color * change_color.y;
  cc = mix(vec3(0.5), min(cc, 1.0), min(change_color.x + change_color.y, 1.0));

  albedo.rgb = any(lessThan(albedo.rgb, vec3(0.5))) ? (2.0 * albedo.rgb * cc) : (1.0 - (2.0 * (1.0 - albedo.rgb) * (1.0 - cc)));

  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_chameleon_masked_ps(vec4 base, vec4 detail, float mask, vec3 normal, vec3 view_dir)
{
  vec4 albedo;

  vec3 color = mix(vec3(1.0), calc_chameleon(normal, view_dir), mask);

  albedo.rgb = base.rgb * (detail.rgb * DETAIL_MULTIPLIER) * color;
  albedo.a = base.a * detail.a;

  return albedo;
}

vec4 calc_albedo_chameleon_albedo_masked_ps(vec4 base, vec4 base_masked, float mask, vec3 normal, vec3 view_dir)
{
  vec4 albedo;

  base_masked.rgb *= calc_chameleon(normal, view_dir);

  albedo = mix(base, base_masked, mask);

  return albedo;
}

vec4 calc_albedo_custom_cube_ps(vec4 base, vec3 normal)
{
  vec4 albedo;

  vec4 custom_color = cubemapSampleHalo(custom_cube, normal);

  albedo.rgb = base.rgb * custom_color.rgb;
  albedo.a = base.a * albedo_color.a;

  return albedo;
}

vec4 calc_albedo_two_color_ps(vec4 base, vec3 normal)
{
  vec4 albedo;
  vec4 blend_factor = cubemapSampleHalo(blend_map, normal);
  vec4 color = blend_factor.y * albedo_color * 2.0 + blend_factor.z * albedo_second_color * 2.0;

  albedo = base * color;

  return albedo;
}

vec4 calc_albedo_scrolling_cube_mask_ps(vec4 base, vec3 normal, vec3 position)
{
  vec4 albedo;
  normal = misc_attr_animation(normal, position).xyz;
  vec4 blend_factor = cubemapSampleHalo(color_blend_mask_cubemap, normal);
  vec4 color = blend_factor.y * albedo_color * 2.0 + blend_factor.z * albedo_second_color * 2.0;

  albedo = base * color;

  return albedo;
}

vec4 calc_albedo_scrolling_cube_ps(vec4 base, vec3 normal, vec3 position)
{
  vec4 albedo;
  normal = misc_attr_animation(normal, position).xyz;
  vec4 color = cubemapSampleHalo(color_cubemap, normal);

  albedo = base * color;

  return albedo;
}

vec4 calc_albedo_scrolling_texture_uv_ps(vec4 base, vec2 texcoord)
{
  vec4 albedo;
  vec4 color = texture(color_texture, texcoord + (Time * uv_speed));

  albedo = base * color;

  return albedo;
}

vec4 calc_albedo_texture_from_misc_ps(vec4 base, vec3 normal, vec3 position)
{
  vec4 albedo;
  vec4 color = texture(color_texture, misc_attr_animation(normal, position).xy);

  albedo = base * color;

  return albedo;
}

/*Bump Mapping Functions*/
vec3 calc_bumpmap_detail_ps(V2F inputs)
{
  vec3 bump = normalUnpack(textureSparse(normal_texture, inputs.sparse_coord), base_normal_y_coeff);
  vec3 detail = normalUnpack(texture(bumpdetailtex, (inputs.tex_coord * u_bumpdetailxform.xy) + u_bumpdetailxform.zw), base_normal_y_coeff);

  bump.xy += detail.xy * bump_detail_coefficient;
  bump = normalize(bump);

  return normalize(bump.x * inputs.tangent +
                   bump.y * inputs.bitangent +
                   bump.z * inputs.normal);
}

vec3 calc_bumpmap_detail_unorm_ps(V2F inputs)
{
  vec3 bump = normalUnpack(textureSparse(normal_texture, inputs.sparse_coord), base_normal_y_coeff);
  vec3 detail = normalUnpack(texture(bumpdetailtex, (inputs.tex_coord * u_bumpdetailxform.xy) + u_bumpdetailxform.zw), base_normal_y_coeff);
  bump = bump * 2.0 + - 1.0;

  bump.xy += detail.xy * bump_detail_coefficient;
  bump = normalize(bump);

  return normalize(bump.x * inputs.tangent +
                   bump.y * inputs.bitangent +
                   bump.z * inputs.normal);
}

vec3 calc_bumpmap_detail_masked_ps(V2F inputs)
{
  vec3 bump = normalUnpack(textureSparse(normal_texture, inputs.sparse_coord), base_normal_y_coeff);
  vec3 detail = normalUnpack(texture(bumpdetailtex, (inputs.tex_coord * u_bumpdetailxform.xy) + u_bumpdetailxform.zw), base_normal_y_coeff);
  float mask = textureSparse(bumpdetailmasktex, inputs.sparse_coord).r;

  mask = invert_mask ? 1 - mask : mask;

  bump.xy += detail.xy * mask * bump_detail_coefficient;
  bump = normalize(bump);

  return normalize(bump.x * inputs.tangent +
                   bump.y * inputs.bitangent +
                   bump.z * inputs.normal); 
}

vec3 calc_bumpmap_detail_plus_detail_masked_ps(V2F inputs)
{
  vec3 bump = normalUnpack(textureSparse(normal_texture, inputs.sparse_coord), base_normal_y_coeff);
  vec3 detail = normalUnpack(texture(bumpdetailtex, (inputs.tex_coord * u_bumpdetailxform.xy) + u_bumpdetailxform.zw), base_normal_y_coeff);
  vec3 detail_masked = normalUnpack(texture(bumpdetailmaskedtex, (inputs.tex_coord * u_bumpdetailmaskedxform.xy) + u_bumpdetailmaskedxform.zw), base_normal_y_coeff);
  float mask = textureSparse(bumpdetailmasktex, inputs.sparse_coord).r;

  bump.xy += detail.xy * bump_detail_coefficient;
  bump.xy += detail_masked.xy * mask * bump_detail_masked_coefficient;
  bump = normalize(bump);

  return normalize(bump.x * inputs.tangent +
                   bump.y * inputs.bitangent +
                   bump.z * inputs.normal); 
}

/*Material Model Functions*/
void calculate_fresnel_tint_map(in SparseCoord texcoord, in vec3 view_dir, in vec3 normal_dir, in vec3 albedo_color, out float power, out vec3 tint)
{
  vec3 nst = textureSparse(specular_map, texcoord).xyz * normal_specular_tint;
  vec3 gst = textureSparse(glancing_specular_tint_map, texcoord).xyz * glancing_specular_tint;

  float n_dot_v = dot(normal_dir, view_dir);
  float fresnel_blend = pow((1 - n_dot_v), fresnel_curve_steepness);
  power = mix(normal_specular_power, glancing_specular_power, fresnel_blend);

  tint = mix(nst, gst, fresnel_blend);
  tint = mix(tint, albedo_color, albedo_specular_tint_blend);
}

float get_material_cook_torrance_specular_power(float power_or_roughness)
{
  if (power_or_roughness == 0){
    return 0;
  }
  else{
    return 0.27291 * pow(power_or_roughness, -2.1973);
  }
}

void calculate_fresnel(in vec3 view_dir, in vec3 normal_dir, in vec3 diffuse_albedo_color, out float power, out vec3 tint)
{
  float n_dot_v = dot(normal_dir, view_dir);
  float fresnel_blend = pow((1 - n_dot_v), fresnel_curve_steepness);
  power = mix(normal_specular_power, glancing_specular_power, fresnel_blend);

  tint = mix(normal_specular_tint, glancing_specular_tint, fresnel_blend);
  tint = mix(tint, diffuse_albedo_color, albedo_specular_tint_blend);
}

void calc_simple_lights_analytical(in vec3 fragment_position_world, in vec3 surface_normal, in vec3 view_reflect_dir_world, in float specular_power, out vec3 diffusely_reflected_light, out vec3 specularly_reflected_light)
{
  float cosine_lobe = dot(surface_normal, light_main.xyz);
  vec3 light_radiance = envIrradiance(light_main.xyz);
  diffusely_reflected_light += light_radiance * max(0.05, cosine_lobe);
  specularly_reflected_light += light_radiance * safe_pow(max(0.0, dot(light_main.xyz, view_reflect_dir_world)), specular_power);

  specularly_reflected_light *= specular_power;
}

void calculate_simple_light(in vec3 fragment_position_world, out vec3 light_radiance, out vec3 fragment_to_light)
{
  fragment_to_light = light_main.xyz - fragment_position_world;
  float light_dist2= dot(fragment_to_light, fragment_to_light);
  fragment_to_light *= inversesqrt(light_dist2);

  vec2 falloff;
  falloff.x = 1 / light_dist2;
  falloff.y = dot(fragment_to_light, fragment_to_light);
  falloff = max(falloff, 0.0001);

  float combined_falloff= clamp(falloff.x, 0, 1) * clamp(falloff.y, 0, 1);

  light_radiance = ((envIrradiance(light_main.xyz) * 2) * environment_exposure) * combined_falloff;
}

void calc_simple_lights_analytical_diffuse_translucent(in vec3 fragment_position_world, in vec3 surface_normal, in vec3 translucency, out vec3 diffusely_reflected_light)
{
  diffusely_reflected_light = vec3(0);

  vec3 fragment_to_light;
	vec3 light_radiance;
	calculate_simple_light(fragment_position_world, light_radiance, fragment_to_light);

  diffusely_reflected_light  += light_radiance;
}

vec3 sh_rotate_023(vec3 rotate_x, vec3 rotate_z, float sh_0, vec4 sh_312)
{
  return vec3(sh_0, -dot(rotate_z, sh_312.xyz), dot(rotate_x, sh_312.xyz));
}

void sh_glossy_ct_2(in vec3 view_dir, in vec3 rotate_z, in vec4 sh_0, in vec4 sh_312[3], in float t_roughness, 
                    in float r_dot_l, in float power, out vec3 specular_part, out vec3 schlick_part)
{
  vec3 rotate_x = normalize(view_dir - dot(view_dir, rotate_z) * rotate_z);
  vec3 rotate_y = cross(rotate_z, rotate_x);

  t_roughness = max(t_roughness, 0.05);
  vec2 view_lookup = vec2(pow(dot(view_dir, rotate_x), power) + c_view_z_shift, t_roughness);
  view_lookup.y = 1 - view_lookup.y;
  //view_lookup.x = 1 - view_lookup.x;
  //view_lookup = clamp(view_lookup, 1.0/32.0, 31.0/32.0);

  vec4 c_value = texture(cc0236, view_lookup);
  c_value = linear2sRGB(c_value);
  vec4 d_value = texture(dd0236, view_lookup);
  d_value = linear2sRGB(d_value);

  vec4 quadratic_a, quadratic_b, sh_local;
  quadratic_a.xyz = rotate_z.yzx * rotate_z.xyz * (-SQRT3);
  quadratic_b = vec4(rotate_z * rotate_z, 1.0/3.0) * 0.5 * (-SQRT3);

  //c0236 dot L0236
  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.r, sh_312[0]);
  sh_local.w = 0.0;

  sh_local *= vec4(1.0, r_dot_l, r_dot_l, r_dot_l);
  specular_part.r = dot(c_value, sh_local);
  schlick_part.r = dot(d_value, sh_local);

  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.r, sh_312[1]);
  sh_local.w = 0.0;

  sh_local *= vec4(1, r_dot_l, r_dot_l, r_dot_l);
  specular_part.g = dot(c_value, sh_local);
  schlick_part.g = dot(d_value, sh_local);

  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.r, sh_312[2]);
  sh_local.w = 0.0;

  sh_local *= vec4(1, r_dot_l, r_dot_l, r_dot_l);
  specular_part.b = dot(c_value, sh_local);
  schlick_part.b = dot(d_value, sh_local);
  schlick_part= schlick_part * 0.01;
}

void sh_glossy_ct_3(in vec3 view_dir, in vec3 rotate_z, in vec4 sh_0, in vec4 sh_312[3], in vec4 sh_457[3], 
                    in vec4 sh_8866[3], in float t_roughness, in float r_dot_l, in float power, out vec3 specular_part, out vec3 schlick_part)
{
  vec3 rotate_x = normalize(view_dir - dot(view_dir, rotate_z) * rotate_z);
  vec3 rotate_y = cross(rotate_x, rotate_z);

  t_roughness = max(t_roughness, 0.05);
  vec2 view_lookup = vec2(pow(dot(view_dir, rotate_x), power) + c_view_z_shift, t_roughness);
  view_lookup.y = 1.0 - view_lookup.y;
  //view_lookup.x = 1 - view_lookup.x;
  //view_lookup = clamp(view_lookup, 1.0/32.0, 31.0/32.0);

  vec4 c_value = texture(cc0236, view_lookup);
  c_value = linear2sRGB(c_value);
  vec4 d_value = texture(dd0236, view_lookup);
  d_value = linear2sRGB(d_value);
  vec4 g_value = texture(c78d78, view_lookup);
  g_value = linear2sRGB(g_value);

  vec4 quadratic_a, quadratic_b, sh_local;
  quadratic_a.xyz = rotate_z.yzx * rotate_z.xyz * (-SQRT3);
  quadratic_b = vec4(rotate_z * rotate_z, 1.0/3.0) * 0.5 * (-SQRT3);

  //c0236 dot L0236
  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.r, sh_312[0]);
  sh_local.w = dot(quadratic_a.xyz, sh_457[0].xyz) + dot(quadratic_b, sh_8866[0]);
  sh_local *= vec4(1.0, r_dot_l, r_dot_l, r_dot_l);

  specular_part.r = dot(c_value, sh_local);
  schlick_part.r = dot(d_value, sh_local);

  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.g, sh_312[1]);
  sh_local.w = dot(quadratic_a.xyz, sh_457[1].xyz) + dot(quadratic_b, sh_8866[1]);
  sh_local *= vec4(1.0, r_dot_l, r_dot_l, r_dot_l);

  specular_part.g = dot(c_value, sh_local);
  schlick_part.g = dot(d_value, sh_local);

  sh_local.xyz = sh_rotate_023(rotate_x, rotate_z, sh_0.b, sh_312[2]);
  sh_local.w = dot(quadratic_a.xyz, sh_457[2].xyz) + dot(quadratic_b, sh_8866[2]);
  sh_local *= vec4(1.0, r_dot_l, r_dot_l, r_dot_l);

  specular_part.b = dot(c_value, sh_local);
  schlick_part.b = dot(d_value, sh_local);

  // basis - 7
  quadratic_a.xyz = rotate_x.xyz * rotate_z.yzx + rotate_x.yzx * rotate_z.xyz;
	quadratic_b.xyz = rotate_x.xyz * rotate_z.xyz;
	sh_local.rgb= vec3(dot(quadratic_a.xyz, sh_457[0].xyz) + dot(quadratic_b.xyz, sh_8866[0].xyz),
						           dot(quadratic_a.xyz, sh_457[1].xyz) + dot(quadratic_b.xyz, sh_8866[1].xyz),
						           dot(quadratic_a.xyz, sh_457[2].xyz) + dot(quadratic_b.xyz, sh_8866[2].xyz));
  sh_local *= r_dot_l;
  specular_part += g_value.x * sh_local.rgb;
  schlick_part += g_value.z * sh_local.rgb;

  //basis - 8
  quadratic_a.xyz = rotate_x.xyz * rotate_x.yzx - rotate_y.yzx * rotate_y.xyz;
	quadratic_b.xyz = 0.5*(rotate_x.xyz * rotate_x.xyz - rotate_y.xyz * rotate_y.xyz);
	sh_local.rgb= vec3(-dot(quadratic_a.xyz, sh_457[0].xyz) - dot(quadratic_b.xyz, sh_8866[0].xyz),
		                 -dot(quadratic_a.xyz, sh_457[1].xyz) - dot(quadratic_b.xyz, sh_8866[1].xyz),
		                 -dot(quadratic_a.xyz, sh_457[2].xyz) - dot(quadratic_b.xyz, sh_8866[2].xyz));
  sh_local *= r_dot_l;
  specular_part += g_value.y * sh_local.rgb;
  schlick_part += g_value.w * sh_local.rgb;

  schlick_part= schlick_part * 0.01;
}

void calculate_area_specular_phong_order_3(in vec3 reflection_dir, in vec4 sh_lighting_coefficients[10], in float power, in vec3 tint, out vec3 s0)
{
  float p_0= 0.4231425;									// 0.886227f			0.282095f * 1.5f;
	float p_1= -0.3805236;									// 0.511664f * -2		exp(-0.5f * power_invert) * (-0.488602f);
	float p_2= -0.4018891;									// 0.429043f * -2		exp(-2.0f * power_invert) * (-1.092448f);
	float p_3= -0.2009446;	

  vec3 x0, x1, x2, x3;

  x0= vec3(sh_lighting_coefficients[0].r * p_0);

  x1.r=  dot(reflection_dir, sh_lighting_coefficients[1].xyz);
	x1.g=  dot(reflection_dir, sh_lighting_coefficients[2].xyz);
	x1.b=  dot(reflection_dir, sh_lighting_coefficients[3].xyz);
	x1 *= p_1;

  //quadratic
	vec3 quadratic_a= (reflection_dir.xyz)*(reflection_dir.yzx);
	x2.x= dot(quadratic_a, sh_lighting_coefficients[4].xyz);
	x2.y= dot(quadratic_a, sh_lighting_coefficients[5].xyz);
	x2.z= dot(quadratic_a, sh_lighting_coefficients[6].xyz);
	x2 *= p_2;

  vec4 quadratic_b = vec4( reflection_dir.xyz*reflection_dir.xyz, 1./3.);
	x3.x= dot(quadratic_b, sh_lighting_coefficients[7]);
	x3.y= dot(quadratic_b, sh_lighting_coefficients[8]);
	x3.z= dot(quadratic_b, sh_lighting_coefficients[9]);
	x3 *= p_3;

  s0 = (x0 + x1 + x2 + x3) * tint;
}

void calculate_area_specular_phong_order_2(in vec3 reflection_dir, in vec4 sh_lighting_coefficients[10], in float power, in vec3 tint, out vec3 s0)
{
  float p_0= 0.4231425;									// 0.886227f			0.282095f * 1.5f;
	float p_1= -0.3805236;									// 0.511664f * -2		exp(-0.5f * power_invert) * (-0.488602f);
	float p_2= -0.4018891;									// 0.429043f * -2		exp(-2.0f * power_invert) * (-1.092448f);
	float p_3= -0.2009446;									// 0.429043f * -1

	vec3 x0, x1, x2, x3;

  x0= vec3(sh_lighting_coefficients[0].r * p_0);

  x1.r=  dot(reflection_dir, sh_lighting_coefficients[1].xyz);
	x1.g=  dot(reflection_dir, sh_lighting_coefficients[2].xyz);
	x1.b=  dot(reflection_dir, sh_lighting_coefficients[3].xyz);
	x1 *= p_1;
	
	s0= (x0 + x1 ) * tint;
}

//Overload for Material Model Organism
void calculate_area_specular_phong_order_2(in vec3 reflection_dir, in vec4 sh_lighting_coefficients[10], out vec3 s0)
{
  float p_0= 0.4231425;									// 0.886227f			0.282095f * 1.5f;
	float p_1= -0.3805236;									// 0.511664f * -2		exp(-0.5f * power_invert) * (-0.488602f);
	float p_2= -0.4018891;									// 0.429043f * -2		exp(-2.0f * power_invert) * (-1.092448f);
	float p_3= -0.2009446;	

  vec3 x0, x1, x2, x3;

  //constant
  x0= vec3(sh_lighting_coefficients[0].r * p_0);

  // linear
	x1.r=  dot(reflection_dir, sh_lighting_coefficients[1].xyz);
	x1.g=  dot(reflection_dir, sh_lighting_coefficients[2].xyz);
	x1.b=  dot(reflection_dir, sh_lighting_coefficients[3].xyz);
	x1 *= p_1;

  s0= x1;
}

void calculate_analytical_specular_new_phong_3(in vec3 dominant_light_dir, in vec3 dominant_light_intensity, in vec3 reflect_dir, in float t_roughness, out vec3 s0)
{
  float roughness_sq = t_roughness*t_roughness;
  float cos_theta = max(dot(dominant_light_dir, reflect_dir), 0.0);
  float cos_theta_sq = cos_theta*cos_theta;
  float tan_theta_sq = (1 - cos_theta_sq)/cos_theta_sq;
  float tan_theta_sq_over_roughness_sq = (roughness_sq != 0) ? (tan_theta_sq / roughness_sq) : 0;
  s0 = (M_PI * roughness_sq * cos_theta * cos_theta_sq) * exp(-tan_theta_sq_over_roughness_sq) * dominant_light_intensity;
}

void calculate_area_specular_new_phong_3(in vec3 reflection_dir, in vec4 sh_lighting_coefficients[10], in float t_roughness, in bool order3, out vec3 s0)
{
  float roughness_sq = t_roughness*t_roughness;

  float c_dc = 0.282095;
  float c_linear = -(0.5128945834 + (-0.1407369526) * t_roughness + (-0.2660066620e-2) * roughness_sq) * 0.60;
  float c_quradratic = -(0.7212524717 + (-0.5541015389) * t_roughness + (0.7960539966e-1) * roughness_sq) * 0.5;

  vec3 x0, x1, x2, x3;

  x1.r=  dot(reflection_dir, sh_lighting_coefficients[1].rgb);
	x1.g=  dot(reflection_dir, sh_lighting_coefficients[2].rgb);
	x1.b=  dot(reflection_dir, sh_lighting_coefficients[3].rgb);

  if(order3)
  {
    vec3 quadratic_a= (reflection_dir.xyz)*(reflection_dir.yzx);
    x2.x= dot(quadratic_a, sh_lighting_coefficients[4].rgb);
		x2.y= dot(quadratic_a, sh_lighting_coefficients[5].rgb);
		x2.z= dot(quadratic_a, sh_lighting_coefficients[6].rgb);
    
    vec4 quadratic_b = vec4( reflection_dir.xyz*reflection_dir.xyz, 1./3. );

    x3.x= dot(quadratic_b, sh_lighting_coefficients[7]);
		x3.y= dot(quadratic_b, sh_lighting_coefficients[8]);
		x3.z= dot(quadratic_b, sh_lighting_coefficients[9]);

    s0= max(x0 * c_dc + x1 * c_linear + x2 * c_quradratic + x3 * c_quradratic, 0.0);
  }
  else
  {
    s0= max(x0 * c_dc + x1 * c_linear, 0.0);
  }
}

void calc_material_analytic_specular_cook_torrance_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, vec3 light_dir, in vec3 light_irradiance, 
                                                      in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec3 surface_normal, in vec4 misc, 
                                                      out vec4 spatially_varying_material_parameters, out vec3 specular_fresnel_color, out vec3 specular_albedo_color,
                                                      out vec3 analytic_specular_radiance)
{
  spatially_varying_material_parameters = vec4(specular_coefficient, albedo_blend, environment_map_specular_contribution, roughness);
  if (use_material_texture)
  {
    spatially_varying_material_parameters.r = textureSparse(specularcoeftex, texcoord).r;
    spatially_varying_material_parameters.g = textureSparse(albedoblendtex, texcoord).r;
    spatially_varying_material_parameters.b = textureSparse(enviornmentcontribtex, texcoord).r;
    spatially_varying_material_parameters.a = textureSparse(roughnesstex, texcoord).r;
  }

  specular_albedo_color = diffuse_albedo_color * spatially_varying_material_parameters.g + fresnel_color * (1.0 - spatially_varying_material_parameters.g);

  float n_dot_l = dot(normal_dir, light_dir);
  float n_dot_v = dot(normal_dir, view_dir);
  float min_dot = min(n_dot_l, n_dot_v);

  if(min_dot > 0.0)
  {
    // compute geometric attenuation
    vec3 half_vector = normalize(view_dir + light_dir);
    float n_dot_h = dot(normal_dir, half_vector);
    float v_dot_h = dot(view_dir, half_vector);

    // VH may be negative by numerical errors, so we need saturate(VH)
    float geometry_term = (2.0 * n_dot_h * min_dot) / (clamp(v_dot_h, 0.0, 1.0) + 0.00001);

    //calculate fresnel term
    vec3 f0 = min(specular_albedo_color, 0.999);
    vec3 sqrt_f0 = sqrt(f0);
    vec3 n = (1.0 + sqrt_f0) / (1.0-sqrt_f0);
    vec3 g = sqrt(n*n + v_dot_h*v_dot_h - 1.0);
    vec3 gpc = g + v_dot_h;
    vec3 gmc = g - v_dot_h;
    vec3 r = (v_dot_h*gpc-1.0)/(v_dot_h*gmc+1.0);
    specular_fresnel_color = (0.5 * ((gmc*gmc) / (gpc*gpc + 0.00001)) * (1.0 + r*r));

    //calculate the distribution term
    float t_roughness = max(spatially_varying_material_parameters.a, 0.05);
    float m_squared = t_roughness*t_roughness;
    float cosine_alpha_squared = n_dot_h * n_dot_h;
    float distribution;
    distribution = exp((cosine_alpha_squared - 1.0)/(m_squared*cosine_alpha_squared)) / (m_squared*cosine_alpha_squared*cosine_alpha_squared+0.00001);

    //puting it all together
    analytic_specular_radiance = distribution * clamp(geometry_term, 0.0, 1.0) / (3.14159265 * n_dot_v + 0.00001) * specular_fresnel_color;
    analytic_specular_radiance = min(analytic_specular_radiance, vertex_n_dot_l + 1.0) * light_irradiance;
  }
  else
  {
    analytic_specular_radiance = vec3(0.00001);
    specular_fresnel_color = specular_albedo_color;
  }
}

void calc_material_analytic_specular_cook_torrance_rim_fresnel_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, vec3 light_dir, in vec3 light_irradiance, 
                                                      in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec3 surface_normal, in vec4 misc, 
                                                      out vec4 spatially_varying_material_parameters, out vec3 specular_fresnel_color, out vec3 specular_albedo_color,
                                                      out vec3 analytic_specular_radiance)
{
  spatially_varying_material_parameters = vec4(specular_coefficient, albedo_blend, environment_map_specular_contribution, roughness);
  if (use_material_texture)
  {
    spatially_varying_material_parameters.r = textureSparse(specularcoeftex, texcoord).r;
    spatially_varying_material_parameters.g = textureSparse(albedoblendtex, texcoord).r;
    spatially_varying_material_parameters.b = textureSparse(enviornmentcontribtex, texcoord).r;
    spatially_varying_material_parameters.a = textureSparse(roughnesstex, texcoord).r;
  }

  specular_albedo_color = diffuse_albedo_color * spatially_varying_material_parameters.g + fresnel_color * (1.0 - spatially_varying_material_parameters.g);
  if(albedo_blend_with_specular_tint){
    specular_albedo_color = fresnel_color;
  }

  float n_dot_l = dot(normal_dir, light_dir);
  float n_dot_v = dot(normal_dir, view_dir);
  float min_dot = min(n_dot_l, n_dot_v);

  if(min_dot > 0.0)
  {
    // compute geometric attenuation
    vec3 half_vector = normalize(view_dir + light_dir);
    float n_dot_h = dot(normal_dir, half_vector);
    float v_dot_h = dot(view_dir, half_vector);

    // VH may be negative by numerical errors, so we need saturate(VH)
    float geometry_term = (2 * n_dot_h * min_dot) / (clamp(v_dot_h, 0, 1) + 0.00001);

    //calculate fresnel term
    vec3 f0 = min(specular_albedo_color, 0.999);
    vec3 sqrt_f0 = sqrt(f0);
    vec3 n = (1.0 + sqrt_f0) / (1-sqrt_f0);
    vec3 g = sqrt(n*n + v_dot_h*v_dot_h - 1.0);
    vec3 gpc = g + v_dot_h;
    vec3 gmc = g - v_dot_h;
    vec3 r = (v_dot_h*gpc-1.0)/(v_dot_h*gmc+1.0);
    specular_fresnel_color = (0.5 * ((gmc*gmc) / (gpc*gpc + 0.00001)) * (1. + r*r));

    //calculate the distribution term
    float t_roughness = max(spatially_varying_material_parameters.a, 0.05);
    float m_squared = t_roughness*t_roughness;
    float cosine_alpha_squared = n_dot_h * n_dot_h;
    float distribution;
    distribution = exp((cosine_alpha_squared - 1.0)/(m_squared*cosine_alpha_squared)) / (m_squared*cosine_alpha_squared*cosine_alpha_squared+0.00001);

    //puting it all together
    analytic_specular_radiance = distribution * clamp(geometry_term, 0, 1) / (3.14159265 * n_dot_v + 0.00001) * specular_fresnel_color;
    analytic_specular_radiance = min(analytic_specular_radiance, vertex_n_dot_l + 1.0) * light_irradiance;
  }
  else
  {
    analytic_specular_radiance = vec3(0.00001);
    specular_fresnel_color = specular_albedo_color;
  }
}

void calc_material_analytic_specular_cook_torrance_pbr_maps_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, vec3 light_dir, in vec3 light_irradiance, 
                                                      in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec3 surface_normal, in vec4 misc, 
                                                      out vec4 spatially_varying_material_parameters, out vec3 specular_fresnel_color, out vec3 specular_albedo_color,
                                                      out vec3 analytic_specular_radiance)
{
  spatially_varying_material_parameters.r = textureSparse(metallictex, texcoord).r;
  spatially_varying_material_parameters.g = albedo_blend;
  spatially_varying_material_parameters.b = environment_map_specular_contribution;
  spatially_varying_material_parameters.a = textureSparse(roughnesstex, texcoord).r;

  specular_albedo_color = diffuse_albedo_color * spatially_varying_material_parameters.g + fresnel_color * (1.0 - spatially_varying_material_parameters.g);

  float n_dot_l = dot(normal_dir, light_dir);
  float n_dot_v = dot(normal_dir, view_dir);
  float min_dot = min(n_dot_l, n_dot_v);

  if(min_dot > 0.0)
  {
    // compute geometric attenuation
    vec3 half_vector = normalize(view_dir + light_dir);
    float n_dot_h = dot(normal_dir, half_vector);
    float v_dot_h = dot(view_dir, half_vector);

    // VH may be negative by numerical errors, so we need saturate(VH)
    float geometry_term = (2 * n_dot_h * min_dot) / (clamp(v_dot_h, 0, 1) + 0.00001);

    //calculate fresnel term
    vec3 f0 = min(specular_albedo_color, 0.999);
    vec3 sqrt_f0 = sqrt(f0);
    vec3 n = (1.0 + sqrt_f0) / (1-sqrt_f0);
    vec3 g = sqrt(n*n + v_dot_h*v_dot_h - 1.0);
    vec3 gpc = g + v_dot_h;
    vec3 gmc = g - v_dot_h;
    vec3 r = (v_dot_h*gpc-1.0)/(v_dot_h*gmc+1.0);
    specular_fresnel_color = (0.5 * ((gmc*gmc) / (gpc*gpc + 0.00001)) * (1. + r*r));

    //calculate the distribution term
    float t_roughness = max(spatially_varying_material_parameters.a, 0.05);
    float m_squared = t_roughness*t_roughness;
    float cosine_alpha_squared = n_dot_h * n_dot_h;
    float distribution;
    distribution = exp((cosine_alpha_squared - 1.0)/(m_squared*cosine_alpha_squared)) / (m_squared*cosine_alpha_squared*cosine_alpha_squared+0.00001);

    //puting it all together
    analytic_specular_radiance = distribution * clamp(geometry_term, 0, 1) / (3.14159265 * n_dot_v + 0.00001) * specular_fresnel_color;
    analytic_specular_radiance = min(analytic_specular_radiance, vertex_n_dot_l + 1.0) * light_irradiance;
  }
  else
  {
    analytic_specular_radiance = vec3(0.00001);
    specular_fresnel_color = specular_albedo_color;
  }
}

void _calc_material_analytic_specular_car_paint(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, vec3 light_dir, in vec3 light_irradiance, 
                                                in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec4 spatially_varying_material_parameters, 
                                                out vec3 specular_fresnel_color, out vec3 specular_albedo_color, out vec3 analytic_specular_radiance, in vec3 _fresnel_color)
{

  specular_albedo_color = diffuse_albedo_color * spatially_varying_material_parameters.g + _fresnel_color * (1.0 - spatially_varying_material_parameters.g);

  float n_dot_l = dot(normal_dir, light_dir);
  float n_dot_v = dot(normal_dir, view_dir);
  float min_dot = min(n_dot_l, n_dot_v);

  if(min_dot > 0.0)
  {
    // compute geometric attenuation
    vec3 half_vector = normalize(view_dir + light_dir);
    float n_dot_h = dot(normal_dir, half_vector);
    float v_dot_h = dot(view_dir, half_vector);

    // VH may be negative by numerical errors, so we need saturate(VH)
    float geometry_term = (2 * n_dot_h * min_dot) / (clamp(v_dot_h, 0, 1) + 0.00001);

    //calculate fresnel term
    vec3 f0 = min(specular_albedo_color, 0.999);
    vec3 sqrt_f0 = sqrt(f0);
    vec3 n = (1.0 + sqrt_f0) / (1-sqrt_f0);
    vec3 g = sqrt(n*n + v_dot_h*v_dot_h - 1.0);
    vec3 gpc = g + v_dot_h;
    vec3 gmc = g - v_dot_h;
    vec3 r = (v_dot_h*gpc-1.0)/(v_dot_h*gmc+1.0);
    specular_fresnel_color = (0.5 * ((gmc*gmc) / (gpc*gpc + 0.00001)) * (1. + r*r));

    //calculate the distribution term
    float t_roughness = max(spatially_varying_material_parameters.a, 0.05);
    float m_squared = t_roughness*t_roughness;
    float cosine_alpha_squared = n_dot_h * n_dot_h;
    float distribution;
    distribution = exp((cosine_alpha_squared - 1.0)/(m_squared*cosine_alpha_squared)) / (m_squared*cosine_alpha_squared*cosine_alpha_squared+0.00001);

    //puting it all together
    analytic_specular_radiance = distribution * clamp(geometry_term, 0, 1) / (3.14159265 * n_dot_v + 0.00001) * specular_fresnel_color;
    analytic_specular_radiance = min(analytic_specular_radiance, vertex_n_dot_l + 1.0) * light_irradiance;
  }
  else
  {
    analytic_specular_radiance = vec3(0.00001);
    specular_fresnel_color = specular_albedo_color;
  }
}

void calc_material_analytic_specular_two_lobe_phong_tint_map_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, in vec3 light_dir, in vec3 light_irradiance,
                                                                in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec3 surface_normal, in vec4 misc,
                                                                out vec4 material_parameters, out vec3 specular_fresnel_color, out vec3 specular_albedo_color, out vec3 analytic_specular_radiance)
{
  float power_or_roughness = 0;
  specular_fresnel_color = vec3(0);
  calculate_fresnel_tint_map(texcoord, view_dir, normal_dir, diffuse_albedo_color, power_or_roughness, specular_fresnel_color);
  specular_albedo_color = textureSparse(specular_map, texcoord).xyz;
  material_parameters.rgb = vec3(specular_coefficient, albedo_specular_tint_blend, environment_map_specular_contribution);
  material_parameters.a = power_or_roughness;

  float l_dot_r = dot(light_dir, view_reflect_dir);

  if(l_dot_r > 0)
  {
    analytic_specular_radiance = pow(l_dot_r, power_or_roughness) * ((power_or_roughness + 1.0) / 6.2832) * specular_fresnel_color * light_irradiance;
  }
  else{
    analytic_specular_radiance = vec3(0);
  }
}

void calc_material_cook_torrance_base(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                      in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                      in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only, 
                                      out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
  vec3 fresnel_analytical;
  vec3 effective_reflectance;
  vec4 per_pixel_parameters;
  vec3 specular_analytical;
  vec4 spatially_varying_material_parameters;
  calc_material_analytic_specular_cook_torrance_ps(view_dir, normalize(view_normal), view_reflect_dir_world, normalize(light_main.xyz), light_color, albedo_color, texcoord, 
                                                   prt_ravi_diff.w, tangent_frame[2], misc, spatially_varying_material_parameters, fresnel_analytical, effective_reflectance, 
                                                   specular_analytical);
  
  // apply anti-shadow
  // maybe later

  vec3 simple_light_diffuse_light;
  vec3 simple_light_specular_light;

  calc_simple_lights_analytical(fragment_position_world, view_normal, view_reflect_dir_world, get_material_cook_torrance_specular_power(spatially_varying_material_parameters.a),
                                simple_light_diffuse_light, simple_light_specular_light);

  vec3 sh_glossy = vec3(0.0);
  float r_dot_l = max(dot(view_light_dir, light_main.xyz), 0.0) * 0.65 + 0.35;

  vec3 specular_part = vec3(0.0);
  vec3 schlick_part = vec3(0.0);
  //view_normal = (uniform_mvp_matrix * vec4(view_normal, 1)).xyz;
  //view_normal = normalize(view_normal);
  if (order3_area_specular)
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    vec4 sh_457[3] = vec4[3](sh_lighting_coefficients[4], sh_lighting_coefficients[5], sh_lighting_coefficients[6]);
    vec4 sh_8866[3] = vec4[3](sh_lighting_coefficients[7], sh_lighting_coefficients[8], sh_lighting_coefficients[9]);
    sh_glossy_ct_3(view_dir, view_normal, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);
  }
  else
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    sh_glossy_ct_2(view_dir, view_normal, sh_0, sh_312, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);
  }

  //sh_glossy = pbrComputeSpecular(vectors, vec3(1.0), vec3(1.0), (spatially_varying_material_parameters.a * 0.5) + 0.5, 1.0, 0.0);
  sh_glossy= specular_part * effective_reflectance + (1.0 - effective_reflectance) * schlick_part;
  envmap_specular_reflectance_and_roughness.w = spatially_varying_material_parameters.a;
  envmap_area_specular_only = sh_glossy * prt_ravi_diff.z * spec_tint;

  //scaling and masking
  specular_color.xyz = specular_mask * spatially_varying_material_parameters.r * spec_tint * 
                      ((specular_analytical) * analytical_specular_contribution + 
                      max(sh_glossy, 0) * area_specular_contribution);

  specular_color.w = 0.0;

  envmap_specular_reflectance_and_roughness.xyz = vec3(spatially_varying_material_parameters.b * specular_mask * spatially_varying_material_parameters.r);

  float diffuse_adjusted = diffuse_coefficient;
  if (use_material_texture)
  {
    diffuse_adjusted = 1.0 - spatially_varying_material_parameters.r;
  }

  diffuse_radiance = diffuse_radiance * prt_ravi_diff.x;
  diffuse_radiance = (diffuse_radiance) * diffuse_adjusted;
  specular_color *= prt_ravi_diff.z;
}

void calc_material_cook_torrance_pbr_maps_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                      in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                      in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only, 
                                      out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
  vec3 fresnel_analytical;
  vec3 effective_reflectance;
  vec4 per_pixel_parameters;
  vec3 specular_analytical;
  vec4 spatially_varying_material_parameters;

  calc_material_analytic_specular_cook_torrance_pbr_maps_ps(view_dir, normalize(view_normal), view_reflect_dir_world, normalize(light_main.xyz), light_color, albedo_color, texcoord, 
                                                   prt_ravi_diff.w, tangent_frame[2], misc, spatially_varying_material_parameters, fresnel_analytical, effective_reflectance, 
                                                   specular_analytical);
  
  // apply anti-shadow
  // maybe later

  spec_tint = textureSparse(specular_map, texcoord).xyz;

  /*vec3 simple_light_diffuse_light;
  vec3 simple_light_specular_light;

  calc_simple_lights_analytical(fragment_position_world, view_normal, view_reflect_dir_world, get_material_cook_torrance_specular_power(spatially_varying_material_parameters.a),
                                simple_light_diffuse_light, simple_light_specular_light);*/

  vec3 sh_glossy = vec3(0.0);
  float r_dot_l = max(dot(view_light_dir, light_main.xyz), 0.0) * 0.65 + 0.35;

  vec3 specular_part = vec3(0.0);
  vec3 schlick_part = vec3(0.0);
  //view_normal = (transpose(inverse(uniform_camera_view_matrix)) * vec4(view_normal, 1)).xyz;
  view_normal = normalize(view_normal);
  if (order3_area_specular)
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    vec4 sh_457[3] = vec4[3](sh_lighting_coefficients[4], sh_lighting_coefficients[5], sh_lighting_coefficients[6]);
    vec4 sh_8866[3] = vec4[3](sh_lighting_coefficients[7], sh_lighting_coefficients[8], sh_lighting_coefficients[9]);
    sh_glossy_ct_3(view_dir, view_normal, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);
  }
  else
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    sh_glossy_ct_2(view_dir, view_normal, sh_0, sh_312, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);
  }

  //sh_glossy = pbrComputeSpecular(vectors, vec3(1.0), vec3(1.0), (spatially_varying_material_parameters.a * 0.5) + 0.5, 1.0, 0.0);
  sh_glossy= specular_part * effective_reflectance + (1 - effective_reflectance) * schlick_part;
  envmap_specular_reflectance_and_roughness.w = spatially_varying_material_parameters.a;
  envmap_area_specular_only = sh_glossy * prt_ravi_diff.z * spec_tint;

  //scaling and masking
  specular_color.xyz = specular_mask * spatially_varying_material_parameters.r * spec_tint * 
                      ((0 + specular_analytical) * (analytical_specular_contribution * 1) + 
                      max(sh_glossy, 0) * area_specular_contribution);

  specular_color.w = 0.0;

  envmap_specular_reflectance_and_roughness.xyz = vec3(spatially_varying_material_parameters.b * specular_mask * spatially_varying_material_parameters.r);

  float diffuse_adjusted = diffuse_coefficient;
  if (use_material_texture)
  {
    diffuse_adjusted = 1.0 - spatially_varying_material_parameters.r;
  }

  diffuse_radiance = diffuse_radiance * prt_ravi_diff.x;
  diffuse_radiance = (diffuse_radiance) * diffuse_adjusted;
  specular_color *= prt_ravi_diff.z;
}

void calc_material_analytic_specular_two_lobe_phong_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, in vec3 light_dir, in vec3 light_irradiance, 
                                                       in vec3 diffuse_albedo_color, in SparseCoord texcoord, in float vertex_n_dot_l, in vec3 surface_normal, in vec4 misc, 
                                                       out vec4 material_parameters, out vec3 specular_fresnel_color, out vec3 specular_albedo_color, out vec3 analytic_specular_radiance)
{
  float power_or_roughness;
  calculate_fresnel(view_dir, normal_dir, diffuse_albedo_color, power_or_roughness, specular_fresnel_color);
  specular_albedo_color = normal_specular_tint;
  material_parameters.rgb = vec3(specular_coefficient, albedo_specular_tint_blend, environment_map_specular_contribution);
  material_parameters.a = power_or_roughness;

  float l_dot_r = dot(light_dir, view_reflect_dir);

  if (l_dot_r > 0)
  {
    analytic_specular_radiance = pow(l_dot_r, power_or_roughness) * ((power_or_roughness + 1) / 6.2832) * specular_fresnel_color * light_irradiance;
  }
  else{
    analytic_specular_radiance = vec3(0);
  }
}

void calc_material_two_lobe_phong_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 surface_normal, in vec3 view_reflect_dir, in vec4 sh_lighting_coefficients[10],
                                     in vec3 analytical_light_dir, in vec3 analytical_light_intensity, in vec3 diffuse_reflectance, in float specular_mask, in SparseCoord texcoord,
                                     in vec4 prt_ravi_diff, in mat3 tangent_frame, in vec4 misc, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only,
                                     out vec4 specular_color, inout vec3 diffuse_radiance)
{
  vec3 analytic_specular_radiance;
	vec3 specular_fresnel_color;
	vec3 specular_albedo_color;
	vec4 material_parameters;

  calc_material_analytic_specular_two_lobe_phong_ps(view_dir, surface_normal, view_reflect_dir, analytical_light_dir, analytical_light_intensity, diffuse_reflectance, texcoord, 
                                                    prt_ravi_diff.w, tangent_frame[2], misc, material_parameters, specular_fresnel_color, specular_albedo_color, analytic_specular_radiance);

  vec3 area_specular_radiance;
  if (order3_area_specular)
  {
    calculate_area_specular_phong_order_3(view_reflect_dir, sh_lighting_coefficients, material_parameters.a, specular_fresnel_color, area_specular_radiance);
  }
  else{
    calculate_area_specular_phong_order_2(view_reflect_dir, sh_lighting_coefficients, material_parameters.a, specular_fresnel_color, area_specular_radiance);
  }

  specular_color.xyz= specular_mask * material_parameters.r * 
                      ((max(analytic_specular_radiance, 0.0)) * analytical_specular_contribution +
		                  max(area_specular_radiance * area_specular_contribution, 0.0));
  specular_color.w= 0.0;

  //modulate with prt	
	specular_color*= prt_ravi_diff.z;

  //output for environment stuff
	envmap_area_specular_only= area_specular_radiance * prt_ravi_diff.z;
	envmap_specular_reflectance_and_roughness.xyz=	vec3(material_parameters.b * specular_mask * material_parameters.r);
	envmap_specular_reflectance_and_roughness.w= max(0.01, 1.01 - material_parameters.a / 200.0);		// convert specular power to roughness (cheap and bad approximation);

  //do diffuse
	//vec3 diffuse_part= ravi_order_3(surface_normal, sh_lighting_coefficients);
	diffuse_radiance= prt_ravi_diff.x * diffuse_radiance;
	diffuse_radiance= (diffuse_radiance) * diffuse_coefficient;
}

void calc_material_glass_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 surface_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10],
                            in vec3 analytical_light_dir, in vec3 analytical_light_intensity, in vec3 diffuse_reflectance, in float specular_mask, in SparseCoord texcoord, 
                            in vec4 prt_ravi_diff, in mat3 tangent_frame, in vec4 misc, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only,
                            out vec4 specular_radiance, inout vec3 diffuse_radiance)
{
  vec3 area_specular = vec3(0);
  if(area_specular_contribution > 0.0)
  {
    calculate_area_specular_new_phong_3(view_reflect_dir_world, sh_lighting_coefficients, roughness, false, area_specular);
  }

  vec3 analytical_specular = vec3(0);
  if(analytical_specular_contribution > 0.0)
  {
    calculate_analytical_specular_new_phong_3(analytical_light_dir, analytical_light_intensity, view_reflect_dir_world, roughness, analytical_specular);
  }

  float fresnel = fresnel_coefficient+(1 - fresnel_coefficient) * pow(1 - max(dot(surface_normal, view_dir), 0.0), fresnel_curve_steepness) + fresnel_curve_bias;
  specular_radiance.rgb = (area_specular * area_specular_contribution + analytical_specular * analytical_specular_contribution) * specular_coefficient * specular_mask;
  specular_radiance.w = fresnel;
  diffuse_radiance = (diffuse_radiance) * diffuse_coefficient;
  float env_multiplyer= specular_coefficient * fresnel * specular_mask;
  envmap_specular_reflectance_and_roughness= vec4(env_multiplyer, env_multiplyer, env_multiplyer, roughness);
	envmap_area_specular_only= sh_lighting_coefficients[0].xyz;
}

void calc_material_analytic_specular(in vec3 normal_dir, in vec3 view_reflect_dir, in vec3 light_dir, in vec3 light_irradiance, in float power_or_roughness, out vec3 analytic_specular_radiance)
{
  float l_dot_r = dot(light_dir, view_reflect_dir);
  if(l_dot_r > 0)
  {
    analytic_specular_radiance = pow(l_dot_r, power_or_roughness) * ((power_or_roughness + 1) / 6.2832) * light_irradiance;
  }
  else
  {
    analytic_specular_radiance = vec3(0);
  }
}

void calc_material_organism_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 bump_normal, in vec3 view_reflect_by_bump_dir, in vec4 sh_lighting_coefficients[10],
                               in vec3 analytical_light_dir, in vec3 analytical_light_intensity, in vec3 diffuse_reflectance, in float specular_mask, in SparseCoord texcoord, 
                               in vec4 prt_ravi_diff, in mat3 tangent_frame, in vec4 misc, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only,
                               out vec4 output_color, inout vec3 diffuse_radiance)
{
  vec3 surface_normal = tangent_frame[2];

  vec4 specular_map_color = vec4(textureSparse(specular_map, texcoord).rgb, specular_mask);
  float power_or_roughness = specular_map_color.a * f_specular_power;

  vec3 diffuse_color = diffuse_radiance * diffuse_coefficient * diffuse_tint;

  vec3 specular_color;
  vec3 analytic_specular_radiance;
  calc_material_analytic_specular(bump_normal, view_reflect_by_bump_dir, analytical_light_dir, analytical_light_intensity, power_or_roughness, analytic_specular_radiance);
  vec3 area_specular_radiance;
  calculate_area_specular_phong_order_2(view_reflect_by_bump_dir, sh_lighting_coefficients, area_specular_radiance);

  specular_color = analytic_specular_radiance*analytical_specular_coefficient +
                   area_specular_radiance*area_specular_coefficient *
                   analytical_specular_coefficient;
  specular_color *= specular_tint * specular_map_color.rgb;

  envmap_area_specular_only = vec3(prt_ravi_diff.z);
  envmap_specular_reflectance_and_roughness.xyz = environment_map_tint * environment_map_coefficient * specular_map_color.rgb;
  envmap_specular_reflectance_and_roughness.w = 1.0;

  // begin the hack of skin
  //vec2 occlusion_map_value = textureSparse(occlusion_parameter_map, texcoord).xy;
  float ambient_occlusion= textureSparse(occlusion_parameter_map, texcoord).x;
	//float visibility_occlusion= occlusion_map_value.y;

  vec3 rim_color_specular = vec3(0);
  vec3 rim_color_diffuse = vec3(0);
  if(rim_coefficient > 0.01){
    vec3 rim_color;
    float rim_ratio = clamp(1 - dot(view_dir, bump_normal), 0, 1);
    rim_ratio = clamp((rim_ratio - rim_start, 0, 1) / max(1 - rim_start, 0.001), 0, 1);
    rim_ratio = pow(rim_ratio, rim_power);
    rim_color = analytical_light_intensity * rim_ratio * rim_tint * rim_coefficient;

    rim_color_specular = rim_color * rim_maps_transition_ratio * specular_map_color.rgb;
    rim_color_diffuse = rim_color * (1 - rim_maps_transition_ratio);
  }

  vec3 ambient_color = vec3(0);
  if(ambient_coefficient > 0.01){
    ambient_color = ambient_occlusion * sh_lighting_coefficients[0].rgb * ambient_tint * ambient_coefficient;
  }

  vec3 subsurface_color = vec3(0);
  if(subsurface_coefficient > 0.01){
    vec4 subsurface_map_color = vec4(textureSparse(subsurface_map, texcoord).rgb, textureSparse(subsurface_map_scattering, texcoord).r);

    vec3 subsurface_normal = normalize(mix(surface_normal, bump_normal, subsurface_normal_detail) + analytical_light_dir*subsurface_propagation_bias * subsurface_map_color.w);

    vec3 area_radiance_subsurface;
    calculate_area_specular_phong_order_2(subsurface_normal, sh_lighting_coefficients, area_radiance_subsurface);

    subsurface_color = area_radiance_subsurface * subsurface_tint * subsurface_coefficient * subsurface_map_color.rgb * ambient_occlusion;
  }

  vec3 transparence_color = vec3(0);
  if(transparence_coefficient > 0.01){
    vec4 transparence_map_color = vec4(textureSparse(transparence_map, texcoord).rgb, textureSparse(transparence_map_translucency, texcoord).r);

    vec3 area_radiance_transparence = vec3(0);
    calculate_area_specular_phong_order_2(-view_dir, sh_lighting_coefficients, area_radiance_transparence);

    vec3 dynamic_radiance_trasparence = vec3(0);
    calc_simple_lights_analytical_diffuse_translucent(fragment_position_world, -view_dir, vec3(0.0), dynamic_radiance_trasparence);

    float normal_bias = 0;
    vec3 transparence_normal = normalize(mix(surface_normal, bump_normal, transparence_normal_detail));
    float normal_weight = dot(view_dir, transparence_normal);
    if(transparence_normal_bias < 0){
      normal_weight = 1 - normal_weight;
    }
    normal_bias = clamp(1 - normal_weight*abs(transparence_normal_bias * transparence_map_color.a), 0, 1);

    transparence_color = (area_radiance_transparence + dynamic_radiance_trasparence) * normal_bias * transparence_tint * transparence_coefficient * transparence_map_color.rgb;
  }

  output_color.rgb = rim_color_specular + specular_color + subsurface_color + transparence_color;
  output_color.w = 0;

  diffuse_radiance = diffuse_color + rim_color_diffuse + ambient_color;

  output_color.xyz *= final_tint;
  diffuse_radiance *= final_tint;
}

void calc_material_single_lobe_phong_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 surface_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10],
                                        in vec3 analytical_light_dir, in vec3 analytical_light_intensity, in vec3 diffuse_reflectance, in float specular_mask, in SparseCoord texcoord,
                                        in vec4 prt_ravi_diff, in mat3 tangent_frame, in vec4 misc, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only,
                                        out vec4 specular_radiance, inout vec3 diffuse_radiance)
{
  vec3 area_specular;
  calculate_area_specular_new_phong_3(view_reflect_dir_world, sh_lighting_coefficients, roughness, order3_area_specular, area_specular);

  vec3 analytical_specular= vec3(0);
  if(analytical_specular_contribution > 0.0)
  {
    calculate_analytical_specular_new_phong_3(analytical_light_dir, analytical_light_intensity, view_reflect_dir_world, roughness, analytical_specular);
  }

  specular_radiance.rgb = (area_specular * area_specular_contribution + analytical_specular * analytical_specular_contribution) * specular_coefficient * specular_mask * specular_tint;
  specular_radiance.w= 0.0;

  diffuse_radiance= (diffuse_radiance) * diffuse_coefficient;
  float env_multiplyer = specular_coefficient * specular_mask * environment_map_specular_contribution;
  envmap_specular_reflectance_and_roughness = vec4(env_multiplyer, env_multiplyer, env_multiplyer, roughness);
  envmap_area_specular_only= area_specular * prt_ravi_diff.z;
}

mat3 compute_tangent_frame(vec3 normal)
{
  mat3 basis;

  vec3 up = vec3(0,1,0);
  vec3 forward = vec3(0,0,1);
  vec3 product = cross(normal, up);
  if(all(product == vec3(0))){
    product = cross(normal, forward);
  }
  basis[0] = normalize(product);
  basis[1] = normalize(cross(basis[0], normal));
  basis[2] = normal;

  return basis;
}

void calc_material_analytic_specular_two_layer(in vec3 view_dir, inout vec3 normal_dir0, in vec3 normal_dir1, in vec3 view_reflect_dir, in vec3 light_dir, in vec3 light_irradiance,
                                               in vec3 diffuse_albedo_color, in vec2 texcoord, in SparseCoord sparse_coord, in float vertex_n_dot_l, in vec3 surface_normal, out vec4 spatially_varying_material_parameters0,
                                               out vec3 specular_fresnel_color0, out vec3 specular_albedo_color0, out vec3 analytic_specular_radiance0, out vec4 spatially_varying_material_parameters1,
                                               out vec3 specular_fresnel_color1, out vec3 specular_albedo_color1, out vec3 analytic_specular_radiance1, out vec3 specular_albedo_color_env1)
{
  vec3 detail_normal = normalUnpack(texture(bump_detail_map0, (texcoord * bump_detail_map0_xform.xy) + bump_detail_map0_xform.zw), base_normal_y_coeff);
  detail_normal = detail_normal * compute_tangent_frame(surface_normal);
  normal_dir0 = normalize(mix(normal_dir0, detail_normal, bump_detail_map0_blend_factor));

  spatially_varying_material_parameters0 = vec4(specular_coefficient0, albedo_blend0, 0, roughness0);
  if(use_material_texture0){
    spatially_varying_material_parameters0.r *= textureSparse(specularcoeftex, sparse_coord).r;
    spatially_varying_material_parameters0.g *= textureSparse(albedoblendtex, sparse_coord).r;
    spatially_varying_material_parameters0.b *= textureSparse(enviornmentcontribtex, sparse_coord).r;
    spatially_varying_material_parameters0.a *= textureSparse(roughnesstex, sparse_coord).r;
  }

  _calc_material_analytic_specular_car_paint(view_dir, normal_dir0, view_reflect_dir, light_dir, light_irradiance, diffuse_albedo_color, sparse_coord, vertex_n_dot_l, 
                                            spatially_varying_material_parameters0, specular_fresnel_color0, specular_albedo_color0, analytic_specular_radiance0, fresnel_color0);

  spatially_varying_material_parameters1 = vec4(specular_coefficient1, albedo_blend1, environment_map_specular_contribution1, roughness1);
  if(use_material_texture0){
    spatially_varying_material_parameters1.r *= textureSparse(specularcoeftex, sparse_coord).r;
    spatially_varying_material_parameters1.g *= textureSparse(albedoblendtex, sparse_coord).r;
    spatially_varying_material_parameters1.b *= textureSparse(enviornmentcontribtex, sparse_coord).r;
    spatially_varying_material_parameters1.a *= textureSparse(roughnesstex, sparse_coord).r;
  }

  _calc_material_analytic_specular_car_paint(view_dir, normal_dir1, view_reflect_dir, light_dir, light_irradiance, diffuse_albedo_color, sparse_coord, vertex_n_dot_l, 
                                            spatially_varying_material_parameters1, specular_fresnel_color1, specular_albedo_color1, analytic_specular_radiance1, fresnel_color1);
  
  specular_albedo_color_env1 = diffuse_albedo_color * spatially_varying_material_parameters1.g + fresnel_color_environment1 * (1-spatially_varying_material_parameters1.g);
}

void calc_material_analytic_specular_car_paint_ps(in vec3 view_dir, in vec3 normal_dir, in vec3 view_reflect_dir, in vec3 light_dir, in vec3 light_irradiance, in vec3 diffuse_albedo_color,
                                                  in vec2 texcoord, in SparseCoord sparse_coord, in float vertex_n_dot_l, in vec3 surface_normal, out vec4 spatially_varying_material_parameters,
                                                  out vec3 specular_fresnel_color, out vec3 specular_albedo_color, out vec3 analytic_specular_radiance)
{
  vec3 normal_dir0 = normal_dir;
	vec4 spatially_varying_material_parameters0;
	vec3 specular_fresnel_color0;
	vec3 specular_albedo_color0;
	vec3 analytic_specular_radiance0;
	/// layer1
	vec3 normal_dir1 = normal_dir;
	vec4 spatially_varying_material_parameters1;
	vec3 specular_fresnel_color1;
	vec3 specular_albedo_color1;
	vec3 analytic_specular_radiance1;
	vec3 specular_albedo_color_env1;

  calc_material_analytic_specular_two_layer(view_dir, normal_dir0, normal_dir1, view_reflect_dir, light_dir, light_irradiance, diffuse_albedo_color, texcoord, sparse_coord, vertex_n_dot_l,
                                            surface_normal, spatially_varying_material_parameters0, specular_fresnel_color0, specular_albedo_color0, analytic_specular_radiance0, spatially_varying_material_parameters1,
                                            specular_fresnel_color1, specular_albedo_color1, analytic_specular_radiance1, specular_albedo_color_env1);
  
  specular_fresnel_color = specular_fresnel_color0 + specular_fresnel_color1;
	specular_albedo_color = specular_albedo_color0 + specular_albedo_color1;
	analytic_specular_radiance = analytic_specular_radiance0 + analytic_specular_radiance1;
	spatially_varying_material_parameters = spatially_varying_material_parameters0 + spatially_varying_material_parameters1;
}

void calc_material_car_paint_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 _view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10],
                                in vec3 view_light_dir, in vec3 light_color, in vec3 _albedo_color, in vec3 specular_mask, in V2F inputs, in vec4 prt_ravi_diff, in mat3 tangent_frame, 
                                out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance)
{
  vec3 view_normal0 = _view_normal;
	vec4 spatially_varying_material_parameters0;
	vec3 fresnel_analytical0;			// fresnel_specular_albedo
	vec3 effective_reflectance0;		// specular_albedo (no fresnel)
	vec3 specular_analytical0;			// specular radiance

	vec3 view_normal1 = _view_normal;
	vec4 spatially_varying_material_parameters1;
	vec3 fresnel_analytical1;			// fresnel_specular_albedo
	vec3 effective_reflectance1;		// specular_albedo (no fresnel)
	vec3 specular_analytical1;			// specular radiance
	vec3 specular_albedo_color_env1;

  calc_material_analytic_specular_two_layer(view_dir, view_normal0, view_normal1, view_reflect_dir_world, view_light_dir, light_color, _albedo_color, inputs.tex_coord, inputs.sparse_coord,
                                            prt_ravi_diff.w, tangent_frame[2], spatially_varying_material_parameters0, fresnel_analytical0, effective_reflectance0, specular_analytical0,
                                            spatially_varying_material_parameters1, fresnel_analytical1, effective_reflectance1, specular_analytical1, specular_albedo_color_env1);

  float r_dot_l= max(dot(view_light_dir, view_reflect_dir_world), 0.0) * 0.65 + 0.35;
  vec3 specular_part0 = vec3(0.0);
	vec3 schlick_part0 = vec3(0.0);
	vec3 specular_part1 = vec3(0.0);
	vec3 schlick_part1 = vec3(0.0);
  vec3 rim_specular_part1 = vec3(0.0);
	vec3 rim_schlick_part1 = vec3(0.0);

  if (order3_area_specular0) {
		vec4 sh_0= sh_lighting_coefficients[0];
		vec4 sh_312[3]= vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
		vec4 sh_457[3]= vec4[3](sh_lighting_coefficients[4], sh_lighting_coefficients[5], sh_lighting_coefficients[6]);
		vec4 sh_8866[3]= vec4[3](sh_lighting_coefficients[7], sh_lighting_coefficients[8], sh_lighting_coefficients[9]);
		sh_glossy_ct_3(view_dir, view_normal0, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters0.a, r_dot_l, fresnel_power0, specular_part0, schlick_part0);
	}
  else
  {
    vec4 sh_0= sh_lighting_coefficients[0];
		vec4 sh_312[3]= vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    sh_glossy_ct_2(view_dir, view_normal0, sh_0, sh_312, spatially_varying_material_parameters0.a, r_dot_l, fresnel_power0, specular_part0,schlick_part0);
  }

  if (order3_area_specular1) {
		vec4 sh_0= sh_lighting_coefficients[0];
		vec4 sh_312[3]= vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
		vec4 sh_457[3]= vec4[3](sh_lighting_coefficients[4], sh_lighting_coefficients[5], sh_lighting_coefficients[6]);
		vec4 sh_8866[3]= vec4[3](sh_lighting_coefficients[7], sh_lighting_coefficients[8], sh_lighting_coefficients[9]);
		sh_glossy_ct_3(view_dir, view_normal1, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters1.a, r_dot_l, fresnel_power1, specular_part1, schlick_part1);
	}
  else
  {
    vec4 sh_0= sh_lighting_coefficients[0];
		vec4 sh_312[3]= vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    sh_glossy_ct_2(view_dir, view_normal1, sh_0, sh_312, spatially_varying_material_parameters1.a, r_dot_l, fresnel_power1, specular_part1, schlick_part1);

    if (rim_fresnel_coefficient1 > 0.0) {
		sh_glossy_ct_2(view_dir, view_normal1, sh_0, sh_312, spatially_varying_material_parameters1.a, r_dot_l, rim_fresnel_power1, rim_specular_part1, rim_schlick_part1);
	  }
  }

  vec3 sh_glossy0 = specular_part0 * effective_reflectance0 + (1 - effective_reflectance0) * schlick_part0;
	vec3 sh_glossy1 = specular_part1 * effective_reflectance1 + (1 - effective_reflectance1) * schlick_part1;

  vec3 sh_glossy_env1 = specular_part1 * specular_albedo_color_env1 + (1 - specular_albedo_color_env1) * schlick_part1;

  envmap_specular_reflectance_and_roughness.w= spatially_varying_material_parameters1.a;
	envmap_area_specular_only= sh_glossy_env1 * prt_ravi_diff.z * specular_tint1;

  specular_color.xyz = specular_mask * spatially_varying_material_parameters0.r * specular_tint0 * ((effective_reflectance0 + specular_analytical0) * 
                        analytical_specular_contribution0 + max(sh_glossy0, 0.0) * area_specular_contribution0);

	specular_color.xyz += specular_mask * spatially_varying_material_parameters1.r * specular_tint1 * ((effective_reflectance1 + specular_analytical1) 
                        * analytical_specular_contribution1 + max(sh_glossy1, 0.0) * area_specular_contribution1);

  specular_color.xyz += specular_mask * spatially_varying_material_parameters1.r * rim_fresnel_coefficient1 * mix(rim_fresnel_color1, _albedo_color, rim_fresnel_albedo_blend1) * 
                        rim_schlick_part1;

  specular_color.w= 0.0;

  envmap_specular_reflectance_and_roughness.xyz=	spatially_varying_material_parameters1.b * specular_mask * spatially_varying_material_parameters1.r;

  float diffuse_adjusted0 = diffuse_coefficient0;
  float diffuse_adjusted1 = diffuse_coefficient1;

  vec3 diff_rad = diffuse_radiance * prt_ravi_diff.x;
	diffuse_radiance = (diff_rad) * diffuse_adjusted0;
	diffuse_radiance += (diff_rad) * diffuse_adjusted1;

	specular_color *= prt_ravi_diff.z;
}

void calc_material_cook_torrance_custom_cube_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                                in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                                in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, 
                                                out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
	vec3 custom_spec_tint = cubemapSampleHalo(custom_cube, view_normal).xyz;

	calc_material_cook_torrance_base(view_dir, fragment_position_world, view_normal, view_reflect_dir_world, sh_lighting_coefficients, view_light_dir, light_color, albedo_color, 
                                  specular_mask, texcoord, prt_ravi_diff, tangent_frame, misc, custom_spec_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                  specular_color, diffuse_radiance, vectors);
}

void calc_material_cook_torrance_two_color_spec_tint_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                                in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                                in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, 
                                                out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
	vec3 spec_blend = cubemapSampleHalo(spec_blend_map, view_normal).xyz;
  spec_tint = spec_blend.y * specular_tint * 2 + spec_blend.z * specular_second_tint * 2;

	calc_material_cook_torrance_base(view_dir, fragment_position_world, view_normal, view_reflect_dir_world, sh_lighting_coefficients, view_light_dir, light_color, albedo_color, 
                                  specular_mask, texcoord, prt_ravi_diff, tangent_frame, misc, spec_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                  specular_color, diffuse_radiance, vectors);
}

void calc_material_two_lobe_phong_tint_map_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 surface_normal, in vec3 view_reflect_dir, in vec4 sh_lighting_coefficients[10],
                                     in vec3 analytical_light_dir, in vec3 analytical_light_intensity, in vec3 diffuse_reflectance, in float specular_mask, in SparseCoord texcoord,
                                     in vec4 prt_ravi_diff, in mat3 tangent_frame, in vec4 misc, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only,
                                     out vec4 specular_color, inout vec3 diffuse_radiance)
{
  vec3 analytic_specular_radiance;
	vec3 specular_fresnel_color;
	vec3 specular_albedo_color;
	vec4 material_parameters;

  calc_material_analytic_specular_two_lobe_phong_tint_map_ps(view_dir, surface_normal, view_reflect_dir, analytical_light_dir, analytical_light_intensity, diffuse_reflectance, texcoord, 
                                                    prt_ravi_diff.w, tangent_frame[2], misc, material_parameters, specular_fresnel_color, specular_albedo_color, analytic_specular_radiance);

  vec3 area_specular_radiance;
  if (order3_area_specular)
  {
    calculate_area_specular_phong_order_3(view_reflect_dir, sh_lighting_coefficients, material_parameters.a, specular_fresnel_color, area_specular_radiance);
  }
  else{
    calculate_area_specular_phong_order_2(view_reflect_dir, sh_lighting_coefficients, material_parameters.a, specular_fresnel_color, area_specular_radiance);
  }

  specular_color.xyz= specular_mask * material_parameters.r * 
                      ((max(analytic_specular_radiance, 0.0)) * analytical_specular_contribution +
		                  max(area_specular_radiance * area_specular_contribution, 0.0));
  specular_color.w= 0.0;

  //modulate with prt	
	specular_color*= prt_ravi_diff.z;

  //output for environment stuff
	envmap_area_specular_only= area_specular_radiance * prt_ravi_diff.z;
	envmap_specular_reflectance_and_roughness.xyz=	vec3(material_parameters.b * specular_mask * material_parameters.r);
	envmap_specular_reflectance_and_roughness.w= max(0.01, 1.01 - material_parameters.a / 200.0);		// convert specular power to roughness (cheap and bad approximation);

  //do diffuse
	//vec3 diffuse_part= ravi_order_3(surface_normal, sh_lighting_coefficients);
	diffuse_radiance= prt_ravi_diff.x * diffuse_radiance;
	diffuse_radiance= (diffuse_radiance) * diffuse_coefficient;
}

void calc_material_cook_torrance_scrolling_cube_mask_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                                in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                                in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, 
                                                out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
	vec3 spec_blend = cubemapSampleHalo(spec_blend_map, misc.xyz).xyz;
  spec_tint = spec_blend.y * specular_tint * 2 + spec_blend.z * specular_second_tint * 2;

	calc_material_cook_torrance_base(view_dir, fragment_position_world, view_normal, view_reflect_dir_world, sh_lighting_coefficients, view_light_dir, light_color, albedo_color, 
                                  specular_mask, texcoord, prt_ravi_diff, tangent_frame, misc, spec_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                  specular_color, diffuse_radiance, vectors);
}

void calc_material_cook_torrance_scrolling_cube_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                                in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                                in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, 
                                                out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
  spec_tint = cubemapSampleHalo(spec_tint_cubemap, misc.xyz).xyz;

	calc_material_cook_torrance_base(view_dir, fragment_position_world, view_normal, view_reflect_dir_world, sh_lighting_coefficients, view_light_dir, light_color, albedo_color, 
                                  specular_mask, texcoord, prt_ravi_diff, tangent_frame, misc, spec_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                  specular_color, diffuse_radiance, vectors);
}

void calc_material_cook_torrance_from_albedo_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                                in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                                in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, 
                                                out vec3 envmap_area_specular_only, out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
  spec_tint = albedo_color;

	calc_material_cook_torrance_base(view_dir, fragment_position_world, view_normal, view_reflect_dir_world, sh_lighting_coefficients, view_light_dir, light_color, albedo_color, 
                                  specular_mask, texcoord, prt_ravi_diff, tangent_frame, misc, spec_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                  specular_color, diffuse_radiance, vectors);
}

void calc_material_cook_torrance_rim_fresnel_ps(in vec3 view_dir, in vec3 fragment_position_world, in vec3 view_normal, in vec3 view_reflect_dir_world, in vec4 sh_lighting_coefficients[10], 
                                      in vec3 view_light_dir, in vec3 light_color, in vec3 albedo_color, in float specular_mask, in SparseCoord texcoord, in vec4 prt_ravi_diff, 
                                      in mat3 tangent_frame, in vec4 misc, in vec3 spec_tint, out vec4 envmap_specular_reflectance_and_roughness, out vec3 envmap_area_specular_only, 
                                      out vec4 specular_color, inout vec3 diffuse_radiance, in LocalVectors vectors)
{
  vec3 fresnel_analytical;
  vec3 effective_reflectance;
  vec4 per_pixel_parameters;
  vec3 specular_analytical;
  vec4 spatially_varying_material_parameters;
  calc_material_analytic_specular_cook_torrance_rim_fresnel_ps(view_dir, normalize(view_normal), view_reflect_dir_world, normalize(light_main.xyz), light_color, albedo_color, texcoord, 
                                                   prt_ravi_diff.w, tangent_frame[2], misc, spatially_varying_material_parameters, fresnel_analytical, effective_reflectance, 
                                                   specular_analytical);
  
  // apply anti-shadow
  // maybe later

  vec3 simple_light_diffuse_light;
  vec3 simple_light_specular_light;

  calc_simple_lights_analytical(fragment_position_world, view_normal, view_reflect_dir_world, get_material_cook_torrance_specular_power(spatially_varying_material_parameters.a),
                                simple_light_diffuse_light, simple_light_specular_light);

  vec3 sh_glossy = vec3(0.0);
  float r_dot_l = max(dot(view_light_dir, light_main.xyz), 0.0) * 0.65 + 0.35;

  vec3 specular_part = vec3(0.0);
  vec3 schlick_part = vec3(0.0);

  vec3 rim_specular_part = vec3(0.0);
  vec3 rim_schlick_part = vec3(0.0);
  //view_normal = (transpose(inverse(uniform_camera_view_matrix)) * vec4(view_normal, 1)).xyz;
  view_normal = normalize(view_normal);
  if (order3_area_specular)
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    vec4 sh_457[3] = vec4[3](sh_lighting_coefficients[4], sh_lighting_coefficients[5], sh_lighting_coefficients[6]);
    vec4 sh_8866[3] = vec4[3](sh_lighting_coefficients[7], sh_lighting_coefficients[8], sh_lighting_coefficients[9]);
    sh_glossy_ct_3(view_dir, view_normal, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);

    if(rim_fresnel_coefficient > 0){
      sh_glossy_ct_3(view_dir, view_normal, sh_0, sh_312, sh_457, sh_8866, spatially_varying_material_parameters.a, r_dot_l, rim_fresnel_power, rim_specular_part, rim_schlick_part);
    }
  }
  else
  {
    vec4 sh_0 = sh_lighting_coefficients[0];
    vec4 sh_312[3] = vec4[3](sh_lighting_coefficients[1], sh_lighting_coefficients[2], sh_lighting_coefficients[3]);
    sh_glossy_ct_2(view_dir, view_normal, sh_0, sh_312, spatially_varying_material_parameters.a, r_dot_l, 1, specular_part, schlick_part);

    if(rim_fresnel_coefficient > 0){
      sh_glossy_ct_2(view_dir, view_normal, sh_0, sh_312, spatially_varying_material_parameters.a, r_dot_l, rim_fresnel_power, rim_specular_part, rim_schlick_part);
    }
  }

  //sh_glossy = pbrComputeSpecular(vectors, vec3(1.0), vec3(1.0), (spatially_varying_material_parameters.a * 0.5) + 0.5, 1.0, 0.0);
  sh_glossy= specular_part * effective_reflectance + (1 - effective_reflectance) * schlick_part;

  vec3 sh_glossy_env = sh_glossy;
  if(use_fresnel_color_environment){
    vec3 specular_albedo_color_env = albedo_color * spatially_varying_material_parameters.g + fresnel_color_environment * (1-spatially_varying_material_parameters.g);
    if(albedo_blend_with_specular_tint){
      specular_albedo_color_env = fresnel_color_environment;
    }
    sh_glossy_env = specular_part * specular_albedo_color_env + (1 - specular_albedo_color_env) * schlick_part;
  }

  vec3 res_specular_tint = specular_tint;
  if(albedo_blend_with_specular_tint){
    res_specular_tint = albedo_color * spatially_varying_material_parameters.g + specular_tint * (1-spatially_varying_material_parameters.g);
  }

  envmap_specular_reflectance_and_roughness.w = spatially_varying_material_parameters.a;
  envmap_area_specular_only = sh_glossy_env * prt_ravi_diff.z * res_specular_tint;

  //scaling and masking
  specular_color.xyz = specular_mask * spatially_varying_material_parameters.r * res_specular_tint * 
                      ((effective_reflectance + specular_analytical) * (analytical_specular_contribution * 1) + 
                      max(sh_glossy, 0) * area_specular_contribution);

  specular_color.xyz += specular_mask * spatially_varying_material_parameters.r * rim_fresnel_coefficient * mix(rim_fresnel_color, albedo_color, rim_fresnel_albedo_blend) * 
                        rim_schlick_part;

  specular_color.w = 0.0;

  envmap_specular_reflectance_and_roughness.xyz = vec3(spatially_varying_material_parameters.b * specular_mask * spatially_varying_material_parameters.r);

  float diffuse_adjusted = diffuse_coefficient;
  //if (use_material_texture)
  //{
    //diffuse_adjusted = 1.0 - spatially_varying_material_parameters.r;
  //}

  diffuse_radiance = diffuse_radiance * prt_ravi_diff.x;
  diffuse_radiance = (diffuse_radiance) * diffuse_adjusted;
  specular_color *= prt_ravi_diff.z;
}

/*Enviorment Mapping Functions*/
vec3 calc_environment_map_per_pixel_ps(vec3 view_dir, vec3 normal, vec3 reflect_dir, vec4 specular_reflectance_and_roughness, vec3 low_frequency_specular_color)
{
  reflect_dir.z = -reflect_dir.z;
  vec4 reflection = cubemapSampleHalo(environment_map, reflect_dir);

  return reflection.rgb * specular_reflectance_and_roughness.rgb * low_frequency_specular_color * env_tint_color * reflection.a * 10;
}

vec3 calc_environment_map_dynamic_ps(vec3 view_dir, vec3 normal, vec3 reflect_dir, vec4 specular_reflectance_and_roughness, vec3 low_frequency_specular_color)
{
  vec4 reflection_0, reflection_1;
  reflect_dir.z = -reflect_dir.z;

  float grad_x = normalize(length(dFdx(reflect_dir)));
  float grad_y = normalize(length(dFdy(reflect_dir)));
  float base_lod = 6.0 * sqrt(max(grad_x, grad_y)) - 0.6;
  //base_lod = 6.0 * 5 - 0.6;
  float lod = max(base_lod - 1, specular_reflectance_and_roughness.w * env_roughness_scale * 4);

  //reflect_dir.z = -reflect_dir.z;
  reflection_0.rgb = envSample((reflect_dir), lod);
  //reflection_0.a = dot(reflection_0.rgb, vec3(0.299, 0.587, 0.114)) / 255;
  //reflection_0.rgb = reflection_0.rgb*(2.51*reflection_0.rgb + .03) / (reflection_0.rgb*(2.43*reflection_0.rgb + .59) + .14);
  //reflection_0.rgb *= 0.5;
  //reflection_0.a = sRGB2linear(reflection_0.a);
  //reflection_0.a = dot(reflection_0.rgb, vec3(0.299, 0.587, 0.114)) / 255;
  //reflection_0.a *= .2;

  vec3 reflection = reflection_0.rgb * 2.0;

  return reflection * specular_reflectance_and_roughness.rgb * env_tint_color * low_frequency_specular_color;
}

vec3 calc_environment_map_from_flat_texture_ps(vec3 view_dir, vec3 normal, vec3 reflect_dir, vec4 specular_reflectance_and_roughness, vec3 low_frequency_specular_color, bool iscube)
{
  vec3 reflection = vec3(0);

  vec3 envmap_dir;
  envmap_dir.x= dot(reflect_dir, vec3(1,0,0));
	envmap_dir.y= dot(reflect_dir, vec3(0,1,0));
	envmap_dir.z= dot(reflect_dir, vec3(0,0,1));

  float radius = sqrt((envmap_dir.z + 1.0)/hemisphere_percentage);

  vec2 texcoord = envmap_dir.xy * radius / sqrt(dot(envmap_dir.xy, envmap_dir.xy));
  texcoord = (1.0 + texcoord) * 0.5;

  if(iscube){
    vec3 cube_texcoord = vec3(1.0, -((texcoord.y * 2) - 1.0), -((texcoord.x * 2) - 1.0));
    reflection = cubemapSampleHalo(flat_environment_map, cube_texcoord).rgb;
  }
  else{
    reflection = texture(flat_environment_map, texcoord).rgb;
  }

  reflection += max(dot(reflection, vec3(0.299, 0.587, 0.114)) - env_bloom_override.a, 0.0) * env_bloom_override.rgb * env_bloom_override_intensity * environment_exposure;

  return reflection * specular_reflectance_and_roughness.rgb * env_tint_color;
}

vec3 calc_environment_map_custom_map_ps(vec3 view_dir, vec3 normal, vec3 reflect_dir, vec4 specular_reflectance_and_roughness, vec3 low_frequency_specular_color)
{
  vec4 reflection;
  reflect_dir.z = -reflect_dir.z;

  vec3 gradx = dFdx(reflect_dir);
  vec3 grady = dFdy(reflect_dir);
  float grad_x = dot(gradx, gradx);
  float grad_y = dot(grady, grady);
  float base_lod = 6.0 * sqrt(max(grad_x, grad_y)) - 0.6;
  //base_lod = 6.0 * 5 - 0.6;
  float lod = max(base_lod, specular_reflectance_and_roughness.w * env_roughness_scale * 4);

  //reflect_dir.z = -reflect_dir.z;
  reflection = cubemapSampleHalo(environment_map, (reflect_dir), lod);
  //reflection_0.a = dot(reflection_0.rgb, vec3(0.299, 0.587, 0.114)) / 255;
  //reflection_0.rgb = reflection_0.rgb*(2.51*reflection_0.rgb + .03) / (reflection_0.rgb*(2.43*reflection_0.rgb + .59) + .14);
  //reflection_0.rgb *= 0.5;
  //reflection_0.a = sRGB2linear(reflection_0.a);
  //reflection_0.a = dot(reflection_0.rgb, vec3(0.299, 0.587, 0.114)) / 255;
  //reflection_0.a *= .2;

  reflection *= reflection.a * 256.0;

  return reflection.rgb * specular_reflectance_and_roughness.rgb * env_tint_color * low_frequency_specular_color;
}

/*Self Illum Functions*/
vec3 calc_self_illumination_simple_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec3 result = textureSparse(self_illum_map, inputs.sparse_coord).rgb * self_illum_color;
  result *= self_illum_intensity;

  return result;
}

vec3 calc_self_illumination_three_channel_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec3 self_illum = textureSparse(self_illum_map, inputs.sparse_coord).rgb;
  self_illum = self_illum.r * channel_a.a * channel_a.rgb +
               self_illum.b * channel_b.a * channel_b.rgb +
               self_illum.g * channel_c.a * channel_c.rgb;

  return self_illum * self_illum_intensity;
}

vec3 calc_self_illumination_plasma_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  float alpha = textureSparse(alpha_mask_map, inputs.sparse_coord).r;
  float noise_a = texture(noise_map_a, inputs.tex_coord * noise_map_a_xform.xy + uvoffsetTime(noise_map_a_xform)).r;
  float noise_b = texture(noise_map_b, inputs.tex_coord * noise_map_b_xform.xy + uvoffsetTime(noise_map_b_xform)).r;

  float diff = 1.0 - abs(noise_a-noise_b);
  float medium_diff = pow(diff, thinness_medium);
  float sharp_diff = pow(diff, thinness_sharp);
  float wide_diff = pow(diff, thinness_wide);

  wide_diff -= medium_diff;
  medium_diff -= sharp_diff;

  vec3 color = color_medium.rgb*color_medium.a*medium_diff + color_sharp.rgb*color_sharp.a*sharp_diff + color_wide.rgb*color_wide.a*wide_diff;

  return color*alpha*self_illum_intensity;
}

vec3 calc_self_illumination_from_albedo_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec3 result = albedo * self_illum_color.xyz * self_illum_intensity;
  albedo = vec3(0);

  return result;
}

vec3 calc_self_illumination_detail_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec4 self_illum = textureSparse(self_illum_map, inputs.sparse_coord);
  vec4 self_illum_detail = texture(self_illum_detail_map, inputs.tex_coord * self_illum_detail_map_xform.xy + uvoffsetTime(self_illum_detail_map_xform));

  vec4 result = self_illum * (self_illum_detail * DETAIL_MULTIPLIER) * vec4(self_illum_color, 1);
  result.rgb *= self_illum_intensity;

  return result.rgb;
}

vec3 calc_self_illumination_meter_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec4 meter_map_sample = vec4(vec3(textureSparse(meter_map, inputs.sparse_coord).r), textureSparse(self_illum_alpha, inputs.sparse_coord).r);

  return (meter_map_sample.x >= 0.5) ? (meter_value >= meter_map_sample.w) ? meter_color_on : meter_color_off : vec3(0);
}

vec3 calc_self_illumination_times_diffuse_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec3 self_illum_texture_sample = textureSparse(self_illum_map, inputs.sparse_coord).rgb;

  float blend = max(self_illum_texture_sample.g * 10.0 - 9.0, 0.0);
  vec3 albedo_part = blend + (1-blend) * albedo;
  vec3 mix_illum_color = (primary_change_color_blend * primary_change_color) + ((1 - primary_change_color_blend) * self_illum_color);
  vec3 self_illum = albedo_part * mix_illum_color * self_illum_intensity * self_illum_texture_sample;

  return self_illum;
}

vec3 calc_self_illumination_simple_with_alpha_mask_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec4 result = vec4(vec3(textureSparse(self_illum_map, inputs.sparse_coord)).rgb, textureSparse(self_illum_alpha, inputs.sparse_coord).r) * vec4(self_illum_color, 1);
  result *= result.a * self_illum_intensity;

  return result.rgb;
}

vec3 calc_self_illumination_change_color_ps(in V2F inputs, inout vec3 albedo, in vec3 view_dir)
{
  vec3 self_illum_texture_sample = textureSparse(self_illum_map, inputs.sparse_coord).rgb;
  vec3 mix_illum_color = (primary_change_color_blend * primary_change_color) + ((1 - primary_change_color_blend) * self_illum_color);
  vec3 self_illum = mix_illum_color * self_illum_intensity * self_illum_texture_sample;

  return self_illum;
}

/*Parallax Functions*/
void calc_parallax_simple_ps(inout V2F inputs, in vec3 view_dir)
{
  float height = (getDisplacement(height_map, inputs.sparse_coord) * .5) * height_scale;
  vec2 parallax_texcoord = inputs.tex_coord + height * view_dir.xy;

  inputs.tex_coord = parallax_texcoord;
  inputs.sparse_coord = getSparseCoord(inputs.tex_coord);
}

void calc_parallax_interpolated_ps(inout V2F inputs, in vec3 view_dir)
{
  float cur_height = 0.0;
  float height_1 = (getDisplacement(height_map, inputs.sparse_coord) * .5) * height_scale;
  float height_difference = height_1 - cur_height;
  vec2 step_offset = height_difference * view_dir.xy;
  
  vec2 parallax_texcoord = inputs.tex_coord + step_offset;
  inputs.sparse_coord = getSparseCoord(parallax_texcoord);
  cur_height = height_difference * view_dir.z;

  float height_2 = (getDisplacement(height_map, inputs.sparse_coord) * .5) * height_scale;

  height_difference = height_2 - cur_height;
  if(sign(height_difference) != sign(height_1 - cur_height)){
    float pct = height_1/(cur_height - height_2 + height_1);
    parallax_texcoord = inputs.tex_coord + pct * step_offset;
  }
  else{
    parallax_texcoord = parallax_texcoord + height_difference * view_dir.xy;
  }

  inputs.tex_coord = parallax_texcoord;
  inputs.sparse_coord = getSparseCoord(inputs.tex_coord);
}

void calc_parallax_simple_detail_ps(inout V2F inputs, in vec3 view_dir)
{
  float height = (getDisplacement(height_map, inputs.sparse_coord) * .5) * textureSparse(height_scale_map, inputs.sparse_coord).r * height_scale;
  vec2 parallax_texcoord = inputs.tex_coord + height * view_dir.xy;

  inputs.tex_coord = parallax_texcoord;
  inputs.sparse_coord = getSparseCoord(inputs.tex_coord);
}

void apply_soft_fade_on(inout vec4 albedo, in vec3 wnorm, in vec3 wview, in float linearDepth, in vec2 vPos)
{
  float val = 1;
  if(use_soft_fresnel){
    float fresnel_dp = calc_fresnel_dp(wnorm, wview);
    val *= pow(fresnel_dp, soft_fresnel_power);
  }
  if(use_soft_z){
    vec2 sampler_size;
    vec2 frag_coord = (vPos.xy + vec2(0.5)) / uniform_screen_size.xy;
    val *= get_softness(z_to_w((linearDepth/uniform_screen_size.xy).r), linearDepth, soft_z_range);
  }
  if(u_blendmode == 3){
    albedo.w *= val;
  }
  else{
    albedo.rgb *= val;
  }
}

void shade(V2F inputs)
{
  LocalVectors vectors = computeLocalFrame(inputs);
  mat3 tangent_frame = mat3(vectors.tangent, vectors.bitangent, vectors.vertexNormal);
  vec4 prt_ravi_diff = vec4(1.0, 1.0, 1.0, max(dot(tangent_frame[2], normalize(light_main.xyz)), 0));
  vec3 view_dir_in_tangent_space = worldSpaceToTangentSpace(getEyeVec(inputs.position), inputs);

  switch(u_parallax){
    case 0:
      break;
    case 1:
      calc_parallax_simple_ps(inputs, view_dir_in_tangent_space);
      break;
    case 2:
      calc_parallax_interpolated_ps(inputs, view_dir_in_tangent_space);
      break;
    case 3:
      calc_parallax_simple_detail_ps(inputs, view_dir_in_tangent_space);
      break;
  }

  /*Diffuse Textures Should've been in the functions, but this i how I started*/
  vec4 base_map = vec4(getBaseColor(basecolor_tex, inputs.sparse_coord), getSpecularLevel(specularmask_tex, inputs.sparse_coord));
  vec4 detail_map = texture(detailTex, (inputs.tex_coord * u_detailxform.xy) + u_detailxform.zw);
  if (b_detaillinear){
    detail_map = sRGB2linear(detail_map);
  }
  vec4 detail_map2 = texture(detail2Tex, (inputs.tex_coord * u_detail2xform.xy) + u_detail2xform.zw);
  if (b_detail2linear){
    detail_map2 = sRGB2linear(detail_map2);
  }
  vec4 detail_map3 = texture(detail3Tex, (inputs.tex_coord * u_detail3xform.xy) + u_detail3xform.zw);
  if (b_detail3linear){
    detail_map3 = sRGB2linear(detail_map3);
  }
  vec4 detail_overlay = texture(detailoverlayTex, (inputs.tex_coord * u_detailoverxform.xy) + u_detailoverxform.zw);
  if (b_detailoverlinear){
    detail_overlay = sRGB2linear(detail_overlay);
  }
  vec4 base_masked_map = vec4(getBaseColor(basecolormasked, inputs.sparse_coord), getSpecularLevel(albedoalphatex, inputs.sparse_coord));
  vec4 color_mask;
  color_mask.r = getSpecularLevel(colormaskprimary, inputs.sparse_coord);
  color_mask.g = getSpecularLevel(colormasksecondary, inputs.sparse_coord);
  color_mask.b = getSpecularLevel(colormasktertiary, inputs.sparse_coord);
  color_mask.a = getSpecularLevel(colormaskquat, inputs.sparse_coord);
  float chameleon_mask_map = getSpecularLevel(specularmask_tex, inputs.sparse_coord);

  vec3 bump_map;
  switch (u_bumptype){
    case 0:
      bump_map = inputs.normal;
      break;
    case 1:
      bump_map = vectors.normal;
      break;
    case 2:
      bump_map = calc_bumpmap_detail_ps(inputs);
      break;
    case 3:
      bump_map = calc_bumpmap_detail_masked_ps(inputs);
      break;
    case 4:
      bump_map = calc_bumpmap_detail_plus_detail_masked_ps(inputs);
      break;
    case 5:
      bump_map = calc_bumpmap_detail_unorm_ps(inputs);
      break;
  }

  vec3 reflectionVector = -normalize(reflect(vectors.eye, bump_map));

  vec4 albedo;
  switch (u_albedotype){
    case 0:
      albedo = calc_albedo_default_ps(base_map, detail_map);
      break;
    case 1:
      albedo = calc_albedo_detail_blend_ps(base_map, detail_map, detail_map2);
      break;
    case 2:
      albedo = albedo_color;
      break;
    case 3:
      albedo = calc_albedo_two_change_color_ps(base_map, detail_map, color_mask);
      break;
    case 4:
      albedo = calc_albedo_four_change_color_ps(base_map, detail_map, color_mask);
      break;
    case 5:
      albedo = calc_albedo_three_detail_blend_ps(base_map, detail_map, detail_map2, detail_map3);
      break;
    case 6:
      albedo = calc_albedo_two_detail_overlay_ps(base_map, detail_map, detail_map2, detail_overlay);
      break;
    case 7:
      albedo = calc_albedo_two_detail_ps(base_map, detail_map, detail_map2);
      break;
    case 8:
      albedo = calc_albedo_color_mask_ps(base_map, detail_map, color_mask);
      break;
    case 9:
      albedo = calc_albedo_two_detail_black_point_ps(base_map, detail_map, detail_map2);
      break;
    case 10:
      albedo = calc_albedo_two_change_color_anim_ps(base_map, detail_map, color_mask);
      break;
    case 11:
      albedo = calc_albedo_chameleon_ps(base_map, detail_map, bump_map, vectors.eye);
      break;
    case 12:
      albedo = calc_albedo_two_change_color_chameleon_ps(base_map, detail_map, color_mask, bump_map, vectors.eye);
      break;
    case 13:
      albedo = calc_albedo_chameleon_masked_ps(base_map, detail_map, chameleon_mask_map, bump_map, vectors.eye);
      break;
    case 14:
      albedo = calc_albedo_color_mask_ps(base_map, detail_map, color_mask); //Where the FUCK is this function in H3's code?!?!?
      break;
    case 15:
      albedo = vec4(0,0,0,1); //CAN'T FIND THIS EITHER
      break;
    case 16:
      albedo = calc_albedo_chameleon_albedo_masked_ps(base_map, base_masked_map, chameleon_mask_map, bump_map, vectors.eye);
      break;
    case 17:
      albedo = calc_albedo_custom_cube_ps(base_map, reflectionVector);
      break;
    case 18:
      albedo = calc_albedo_two_color_ps(base_map, reflectionVector);
      break;
    case 19:
      albedo = calc_albedo_scrolling_cube_mask_ps(base_map, bump_map, inputs.position);
      break;
    case 20:
      albedo = calc_albedo_scrolling_cube_ps(base_map, bump_map, inputs.position);
      break;
    case 21:
      albedo = calc_albedo_scrolling_texture_uv_ps(base_map, inputs.tex_coord);
      break;
    case 22:
      albedo = calc_albedo_texture_from_misc_ps(base_map, bump_map, inputs.position);
      break;
    
  }

  float specular_mask;
  switch (u_specmask){
    case 0:
      specular_mask = 1;
      break;
    case 1:
      specular_mask = albedo.a;
      break;
    case 2:
      specular_mask = getSpecularLevel(specularmask_tex, inputs.sparse_coord);
      break;
    case 3:
      specular_mask = getSpecularLevel(specularmask_tex, inputs.sparse_coord);
      break;
  }

  switch(u_softfade){
    case 0:
      break;
    case 1:
      apply_soft_fade_on(albedo, bump_map, vectors.eye, gl_FragCoord.z, inputs.position.xy);
  }

  /*Inputs for Material Models*/
  vec3 view_normal = (transpose(inverse(uniform_camera_view_matrix)) * vec4(bump_map, 1)).xyz;
  view_normal = normalize(view_normal);
  vec4 sh_lighting_coefficients[10] = shCoeffs(bump_map);
  vec3 view_light_dir = (transpose(inverse(uniform_camera_view_matrix)) * light_main).xyz;
  view_light_dir = normalize(view_light_dir);
  vec3 light_color = (envIrradiance(light_main.xyz) * 2) * environment_exposure;
  vec4 misc = misc_attr_animation(bump_map, inputs.position);
  vec3 fragment_position_world = camera_pos - vectors.eye;
  vec4 envmap_specular_reflectance_and_roughness;
  vec3 envmap_area_specular_only;
  vec4 specular_color;
  vec3 diffuse = envIrradiance(bump_map);
  vec4 temp;
  vec3 analyticaltmp;
  LocalVectors Halo3Vectors = computeLocalFrame(inputs, bump_map, 0.0);

  switch (u_materialmodel){
    case 0:
      break;
    case 1:
      calc_material_cook_torrance_base(normalize(vectors.eye), fragment_position_world, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, normalize(view_light_dir), 
                                       light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, specular_tint, envmap_specular_reflectance_and_roughness, 
                                       envmap_area_specular_only,
                                       specular_color, diffuse, Halo3Vectors);
      break;
    case 2:
      calc_material_two_lobe_phong_ps(vectors.eye, fragment_position_world, bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, 
                                      specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, envmap_specular_reflectance_and_roughness, envmap_area_specular_only,
                                      specular_color, diffuse);
      break;
    case 3:
      envmap_specular_reflectance_and_roughness = vec4(1,1,1,0);
      envmap_area_specular_only = 0.282094815 * sh_lighting_coefficients[0].rgb;
      specular_color = vec4(0);
      break;
    case 4:
      envmap_specular_reflectance_and_roughness = vec4(1,1,1,0);
      envmap_area_specular_only = vec3(0);
      specular_color = vec4(0);
      diffuse = vec3(0);
      break;
    case 5:
      calc_material_glass_ps(vectors.eye, normalize(inputs.position), bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, specular_mask,
                            inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse);
      break;
    case 6:
      calc_material_organism_ps(vectors.eye, fragment_position_world, bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, specular_mask,
                                inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse);
      break;
    case 7:
      calc_material_single_lobe_phong_ps(vectors.eye, normalize(inputs.position), bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, 
                                         specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                         specular_color, diffuse);
      break;
    case 8:
      calc_material_car_paint_ps(vectors.eye, normalize(inputs.position), bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, 
                                vec3(specular_mask), inputs, prt_ravi_diff, tangent_frame, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, 
                                specular_color, diffuse);
      break;
    case 9:
      calc_material_cook_torrance_custom_cube_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, 
                                                normalize(view_light_dir), light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, 
                                                specular_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse, Halo3Vectors);
      break;
    case 10:
      calc_material_cook_torrance_pbr_maps_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, normalize(view_light_dir), 
                                       light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, specular_tint, envmap_specular_reflectance_and_roughness, 
                                       envmap_area_specular_only,
                                       specular_color, diffuse, Halo3Vectors);
      break;
    case 11:
      calc_material_cook_torrance_two_color_spec_tint_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, 
                                                normalize(view_light_dir), light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, 
                                                specular_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse, Halo3Vectors);
      break;
    case 12:
      calc_material_two_lobe_phong_tint_map_ps(vectors.eye, inputs.position, bump_map, reflectionVector, sh_lighting_coefficients, normalize(light_main.xyz), light_color, albedo.rgb, 
                                      specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, envmap_specular_reflectance_and_roughness, envmap_area_specular_only,
                                      specular_color, diffuse);
      break;
    case 13:
      calc_material_cook_torrance_scrolling_cube_mask_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, 
                                                normalize(view_light_dir), light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, 
                                                specular_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse, Halo3Vectors);
      break;
    case 14:
      calc_material_cook_torrance_rim_fresnel_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, normalize(view_light_dir), 
                                       light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, specular_tint, envmap_specular_reflectance_and_roughness, 
                                       envmap_area_specular_only,
                                       specular_color, diffuse, Halo3Vectors);
      break;
    case 15:
      calc_material_cook_torrance_scrolling_cube_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, 
                                                normalize(view_light_dir), light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, 
                                                specular_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse, Halo3Vectors);
      break;
    case 16:
      calc_material_cook_torrance_from_albedo_ps(normalize(vectors.eye), inputs.position, normalize(bump_map), normalize(reflectionVector), sh_lighting_coefficients, 
                                                normalize(view_light_dir), light_color, albedo.rgb, specular_mask, inputs.sparse_coord, prt_ravi_diff, tangent_frame, misc, 
                                                specular_tint, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, specular_color, diffuse, Halo3Vectors);
      break;
  }

  envmap_area_specular_only = max(envmap_area_specular_only, 0.001);
  vec3 envmap;
  switch (u_envmapping){
    case 0:
      envmap = vec3(0);
      break;
    case 1:
      envmap = calc_environment_map_per_pixel_ps(vectors.eye, bump_map, reflectionVector, envmap_specular_reflectance_and_roughness, envmap_area_specular_only);
      break;
    case 2:
      reflectionVector = -normalize(reflect(worldToEnvSpace(vectors.eye), worldToEnvSpace(bump_map)));
      envmap = calc_environment_map_dynamic_ps(vectors.eye, bump_map, reflectionVector, envmap_specular_reflectance_and_roughness, envmap_area_specular_only);
      break;
    case 3:
      envmap = calc_environment_map_from_flat_texture_ps(vectors.eye, bump_map, reflectionVector, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, false);
      break;
    case 4:
      envmap = calc_environment_map_custom_map_ps(vectors.eye, bump_map, reflectionVector, envmap_specular_reflectance_and_roughness, envmap_area_specular_only);
      break;
    case 5:
      envmap = calc_environment_map_from_flat_texture_ps(vectors.eye, bump_map, reflectionVector, envmap_specular_reflectance_and_roughness, envmap_area_specular_only, true);
      break;
  }

  vec3 self_illumination = vec3(0);
  switch(u_selfillum){
    case 0:
      break;
    case 1:
      self_illumination = calc_self_illumination_simple_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 2:
      self_illumination = calc_self_illumination_three_channel_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 3:
      self_illumination = calc_self_illumination_plasma_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 4:
      self_illumination = calc_self_illumination_from_albedo_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 5:
      self_illumination = calc_self_illumination_detail_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 6:
      self_illumination = calc_self_illumination_meter_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 7:
      self_illumination = calc_self_illumination_times_diffuse_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 8:
      self_illumination = calc_self_illumination_simple_with_alpha_mask_ps(inputs, albedo.rgb, vectors.eye);
      break;
    case 9:
      break;
    case 10:
      break;
    case 11:
      self_illumination = calc_self_illumination_change_color_ps(inputs, albedo.rgb, vectors.eye);
      break;
  }

  float shadowFactor = getShadowFactor();


  switch(u_alphatest){
    case 0:
    break;
    
    case 1:
    float alpha = getOpacity(opacity_tex, inputs.sparse_coord);
    if (alpha < 0.5) discard;
  }

  albedoOutput(max(albedo.rgb, 0.0));
  diffuseShadingOutput(max(diffuse * shadowFactor, 0.0));
  specularShadingOutput(max((specular_color.rgb + envmap) * shadowFactor, 0.0));
  alphaOutput(albedo.a);
  emissiveColorOutput(self_illumination * 1);
}