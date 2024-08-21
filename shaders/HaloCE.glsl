import lib-env.glsl
import lib-normal.glsl
import lib-alpha.glsl
import lib-pbr.glsl
import lib-vectors.glsl
import lib-sampler.glsl
import lib-utils.glsl

//-------- Basic Maps ---------------------------------------------------//
//: param auto channel_basecolor
uniform SamplerSparse basecolor_tex;

//: param auto channel_specularlevel
uniform SamplerSparse specularSampler;

//: param auto channel_emissive
uniform SamplerSparse emissiveSampler;

//: param auto channel_user0
uniform SamplerSparse colorChangeTex;

//: param auto channel_user1
uniform SamplerSparse multipurpAlphaTex;

//-------- Basic Shader Info ---------------------------------------------------//
//: param auto main_light
uniform vec4 light_main;

//: param auto camera_view_matrix
uniform mat4 uniform_camera_view_matrix;

//-----------Input Parameters---------------------------------------------------//
//: param custom { "default": 1.0, "label": "Color Change", "widget": "color" }
uniform vec3 changeColor;

//: param custom { "default": 1.0, "label": "Perpendicular Brightness"}
uniform float perpendicularbrightness;
//: param custom { "default": 1.0, "label": "Perpendicular Color Tint", "widget": "color" }
uniform vec3 perpendicularColor;

//: param custom { "default": 1.0, "label": "Parallel Brightness"}
uniform float parallelbrightness;
//: param custom { "default": 1.0, "label": "Parallel Color Tint", "widget": "color" }
uniform vec3 parallelColor;

//: param custom { "default": "", "default_color": [0.0, 0.0, 0.0, 0.0], "label": "Cubemap" }
uniform sampler2D matcapTex;

//: param custom { "default": false, "label": "Cubemap is rotated" }
uniform bool bHaloRotate;

//: param custom { "default": "", "default_color": [0.22323, 0.22323, 0.22323, 1.0], "label": "Detail Map" }
uniform sampler2D detailTex;

//: param custom { "default": 1.0, "label": "Detail Scale"}
uniform float detailScale;

//: param custom {
//:   "default": 0,
//:   "label": "Detail Blend Mode",
//:   "widget": "combobox",
//:   "values": {
//:     "Add": -1,
//:     "Multiply": 0,
//:     "Biased Multiply": 1
//:   }
//: }
uniform int detailBlend;

//: param custom {
//:   "default": 0,
//:   "label": "Detail Mask",
//:   "widget": "combobox",
//:   "values": {
//:     "None": 0,
//:     "Reflection Mask Inverse": 1,
//:     "Reflection Mask": 2,
//:     "Self Illumination Mask Inverse": 3,
//:     "Self Illumination Mask": 4,
//:     "Color Change Mask Inverse": 5,
//:     "Color Change Mask": 6,
//:     "Multipurpouse Alpha Inverse": 7,
//:     "Multipurpouse Alpha": 8
//:   }
//: }
uniform int detailMaskMode;

//: param custom { "default": false, "label": "Detail After Reflection" }
uniform bool bDetailBeforeReflection;

float sRGBGammaLin (float Clinear, float v)
{
   return (Clinear<=0.0031308) ? (12.92 * Clinear) : v;
}

float d3dSRGBGamma(float c_srgb_lin)
{
	float c_srgb = 1.055 * pow(clamp(c_srgb_lin, 0.0, 1.0),1.0/2.4) - 0.055;
	c_srgb_lin = sRGBGammaLin(c_srgb_lin, c_srgb);
	
	return c_srgb_lin;
}

vec3 d3dSRGBGamma(vec3 c_srgb_lin)
{
	vec3 c_srgb = vec3(1.055 * pow(clamp(c_srgb_lin, 0.0, 1.0), vec3(1.0/2.4)) - 0.055);
	c_srgb_lin.r = sRGBGammaLin(c_srgb_lin.r, c_srgb.r);
	c_srgb_lin.g = sRGBGammaLin(c_srgb_lin.g, c_srgb.g);
	c_srgb_lin.b = sRGBGammaLin(c_srgb_lin.b, c_srgb.b);
	
	return c_srgb_lin;
}

float d3dPWLDeGamma (float C)
{
   float Clin;

   C *= 255;
   if (C < 64) {
      Clin = C;
   } else if (C < 96) {
      Clin = 64 + (C-64)*2;
   } else if (C < 192) {
      Clin = 128 + (C-96)*4;
   } else {
      Clin = 513 + (C-192)*8;
   }
   return Clin / 1023;
}

vec3 cubeSample(sampler2D cube, vec3 dir){
    vec2 pos = M_INV_PI * vec2(atan(-dir.z, -1.0 * dir.x), 2.0 * asin(dir.y));
    pos = 0.5 * pos + vec2(0.5);
    return texture(cube, pos).rgb;
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
vec4 cubemapSampleHaloCE(sampler2D t_cube, vec3 normal)
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

    vec2 uvscale = vec2(0.25, .333);
    float minclamp = 0.005;
    float maxclamp = 0.995;

    //remap faces and clamp
    if(index == 0){
        uv = vec2(uv.y, 1- uv.x);
        uv *= uvscale;
        uv += vec2(0.5,.333);
        uv = clamp(uv, vec2(.5 + minclamp, .333 + minclamp),vec2(maxclamp - .25, maxclamp - .333));
    }
    if(index == 1){
        uv *= uvscale;
        uv += vec2(.75,.333);
        uv = clamp(uv, vec2(.75 + minclamp, .333 + minclamp),vec2(1, maxclamp - .333));
    }
    if(index == 2){
        uv *= uvscale;
        uv += vec2(0,.666);
        uv = clamp(uv, vec2(minclamp, .666 + minclamp),vec2(maxclamp - .75, maxclamp));
    }
    if(index == 3){
        uv *= uvscale;
        uv = clamp(uv, vec2(minclamp, minclamp), vec2(maxclamp - .75, .333));
    }
    if(index == 4){
        uv *= uvscale;
        uv += vec2(0,0.33);
        uv = clamp(uv, vec2(minclamp + 0, minclamp + .333), vec2(maxclamp - .75, maxclamp - .333));
    }
    if(index == 5){
        //uv *= uvscale;
        uv = vec2(1-uv.y, uv.x);
        uv *= uvscale;
        uv += vec2(0.25,.333);
        uv = clamp(uv, vec2(minclamp + .25, minclamp + .333), vec2(maxclamp - .5, maxclamp - .333));
    }

    return texture(t_cube, uv);
}

void shade(V2F inputs) {
    LocalVectors vectors = computeLocalFrame(inputs);

    float multipurpAlpha = textureSparse(multipurpAlphaTex, inputs.sparse_coord).r;

    //-----------------Calculate Lighting-------------------------//
    float ndl = clamp(dot(inputs.normal, light_main.xyz), 0.0, 1.0) * environment_exposure * getShadowFactor();

    //------------Calculate Specular-----------------------------//
    float reflectionMask = textureSparse(specularSampler, inputs.sparse_coord).r;
    //reflectionMask = linear2sRGB(reflectionMask);
    reflectionMask = pow(reflectionMask, 2.2);
    float emissiveMask = textureSparse(emissiveSampler, inputs.sparse_coord).r;

    //------------------Reflection Tint Color--------------------//
    vec4 eyeVector = vec4(0.0);
    eyeVector.w = dot(vectors.eye, vectors.eye);
    eyeVector.w = inversesqrt(abs(eyeVector.w));
    reflectionMask *= eyeVector.w;
    eyeVector = vec4(vectors.eye, eyeVector.w) * eyeVector.w;
    eyeVector = vec4(dot(eyeVector.xyz, inputs.normal));
    vec4 tintColor = eyeVector * vec4(perpendicularColor * perpendicularbrightness, 1.0);
    tintColor += vec4(parallelColor * parallelbrightness, 0.0);

    //--------------Color Change---------------------------------//
    float colorChangeMask = textureSparse(colorChangeTex, inputs.sparse_coord).r;
    //colorChangeMask = linear2sRGB(colorChangeMask);
    vec3 colorChange = mix(vec3(1.0), changeColor, colorChangeMask);

    //-----------------"Cubemap"----------------------------------//
    vec3 Cubereflectvec = -normalize(reflect( vectors.vertexNormal, vectors.eye));
    //vec4 viewNormal = uniform_camera_view_matrix * vec4(inputs.normal, 0.0);
    //vec2 matcapUV = viewNormal.xy * 0.5 + 0.5;
    vec3 matcapAdjusted;
    if(bHaloRotate){
        matcapAdjusted = cubemapSampleHaloCE(matcapTex, Cubereflectvec).rgb;
    }
    else{
        matcapAdjusted = cubemapSampleHalo(matcapTex, Cubereflectvec).rgb;
    }
    matcapAdjusted = pow(matcapAdjusted, vec3(1/2.2));
    vec3 tinted_reflection = mix(matcapAdjusted, matcapAdjusted, ndl) * tintColor.rgb;

    //---------------Base Color---------------------------------//
    vec3 albedo = getBaseColor(basecolor_tex, inputs.sparse_coord) * colorChange;
    vec3 detail = texture(detailTex, inputs.tex_coord * vec2(detailScale)).rgb;

    //-----------------Detail Mask-----------------------------//
    float detailMask;
    if(detailMaskMode == 0){
        detailMask = 1;
    }
    if(detailMaskMode == 1){
        detailMask = 1 - reflectionMask;
    }
    if(detailMaskMode == 2){
        detailMask = reflectionMask;
    }
    if(detailMaskMode == 3){
        detailMask = 1 - emissiveMask;
    }
    if(detailMaskMode == 4){
        detailMask = emissiveMask;
    }
    if(detailMaskMode == 5){
        detailMask = 1 - colorChangeMask;
    }
    if(detailMaskMode == 6){
        detailMask = colorChangeMask;
    }
    if(detailMaskMode == 7){
        detailMask = 1 - multipurpAlpha;
    }
    if(detailMaskMode == 8){
        detailMask = multipurpAlpha;
    }

    float detailFunction = 0.0;
    if(detailBlend == 1){
        detailFunction = 0.5;
    }
    if(detailBlend == 0){
        detailFunction = 1.0;
    }
    if(detailBlend == -1){
        detailFunction = 0.5;
    }
    detailMask = pow(detailMask, 1.0/3.2);
    detail = mix(vec3(detailFunction), detail, detailMask);

    //-----------------Detail Blending-------------------------//
    //if(detailBlend == 1){
    //    albedo = albedo * detail.rgb * 2;
    //}
    //if(detailBlend == 0){
    //    albedo = albedo * detail.rgb;
    //}
    //if(detailBlend == -1){
    //    albedo = albedo + 2 * detail.rgb -1;
    //}
    //albedo = clamp(albedo, 0.0, 1.0);

    vec3 ambient = envIrradiance(cross(vectors.vertexNormal, light_main.xyz));
    vec3 diffuseLight = (envIrradiance(vectors.vertexNormal));
    vec3 diffuseFinal;
    if(bDetailBeforeReflection == true){
        if(detailBlend == 1){
        diffuseFinal = albedo * detail.rgb * 2;
        }
        if(detailBlend == 0){
        diffuseFinal = albedo * detail.rgb;
        }
        if(detailBlend == -1){
        diffuseFinal = albedo + 2 * detail.rgb -1;
        }
        diffuseFinal = clamp(diffuseFinal, 0.0, 1.0) * diffuseLight + tinted_reflection * (reflectionMask);
    }
    else{
        diffuseFinal = clamp(albedo * diffuseLight + tinted_reflection * reflectionMask, 0.0, 1.0);
        if(detailBlend == 1){
            diffuseFinal = diffuseFinal * detail.rgb * 2;
        }
        if(detailBlend == 0){
            diffuseFinal = diffuseFinal * detail.rgb;
        }
        if(detailBlend == -1){
            diffuseFinal = diffuseFinal + 2 * detail.rgb -1;
        }
    }

    diffuseShadingOutput(diffuseFinal);

    emissiveColorOutput(vec3(emissiveMask) * albedo);
}