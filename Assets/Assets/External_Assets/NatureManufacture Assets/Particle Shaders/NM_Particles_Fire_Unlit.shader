Shader "NatureManufacture/HDRP/Particles/Fire Unlit"
{
    Properties
    {
        [NoScaleOffset]_Emission_Flipbook("Emission Flipbook (RGB)", 2D) = "white" {}
        [ToggleUI]_Use_Texture_as_Alpha("Use Texture as Alpha", Float) = 0
        _Alpha_Multiplier("Alpha Multiplier", Float) = 1
        _Emission_Intensity("Emission Intensity", Float) = 1
        [HDR]_Emission_Color("Emission Color", Color) = (32, 32, 32, 0)
        [ToggleUI]_Wind_from_Center_T_Age_F("Wind from Center (T) Age (F)", Float) = 0
        _Gust_Strength("Gust Strength", Float) = 0
        _Shiver_Strength("Shiver Strength", Float) = 0
        _Bend_Strength("Bend Strength", Range(0.1, 4)) = 2
        _Intersection_Offset("Intersection Offset", Float) = 0.5
        [Toggle]USE_TRANSPARENCY_INTERSECTION("Use Transparency Intersection", Float) = 0
        [Toggle]USE_WIND("Use Wind", Float) = 0
        [HideInInspector]_EmissionColor("Color", Color) = (1, 1, 1, 1)
        [HideInInspector]_RenderQueueType("Float", Float) = 4
        [HideInInspector][ToggleUI]_AddPrecomputedVelocity("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_DepthOffsetEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_ConservativeDepthOffsetEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_TransparentWritingMotionVec("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_AlphaCutoffEnable("Boolean", Float) = 0
        [HideInInspector]_TransparentSortPriority("_TransparentSortPriority", Float) = 0
        [HideInInspector][ToggleUI]_UseShadowThreshold("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_DoubleSidedEnable("Boolean", Float) = 0
        [HideInInspector][Enum(Default, 0, Flip, 1, Mirror, 2, None, 3)]_DoubleSidedNormalMode("Float", Float) = 2
        [HideInInspector]_DoubleSidedConstants("Vector4", Vector, 4) = (1, 1, -1, 0)
        [HideInInspector][Enum(Default, 0, Auto, 1, On, 2, Off, 3)]_DoubleSidedGIMode("Float", Float) = 0
        [HideInInspector][ToggleUI]_TransparentDepthPrepassEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_TransparentDepthPostpassEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_PerPixelSorting("Boolean", Float) = 0
        [HideInInspector]_SurfaceType("Float", Float) = 1
        [HideInInspector]_BlendMode("Float", Float) = 1
        [HideInInspector]_SrcBlend("Float", Float) = 1
        [HideInInspector]_DstBlend("Float", Float) = 0
        [HideInInspector]_DstBlend2("Float", Float) = 0
        [HideInInspector]_AlphaSrcBlend("Float", Float) = 1
        [HideInInspector]_AlphaDstBlend("Float", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_TransparentZWrite("Boolean", Float) = 0
        [HideInInspector]_CullMode("Float", Float) = 2
        [HideInInspector][ToggleUI]_EnableFogOnTransparent("Boolean", Float) = 1
        [HideInInspector]_CullModeForward("Float", Float) = 2
        [HideInInspector][Enum(Default, 0, Front, 1, Back, 2)]_TransparentCullMode("Float", Float) = 2
        [HideInInspector][Enum(UnityEngine.Rendering.HighDefinition.OpaqueCullMode)]_OpaqueCullMode("Float", Float) = 2
        [HideInInspector]_ZTestDepthEqualForOpaque("Float", Int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)]_ZTestTransparent("Float", Float) = 0
        [HideInInspector][ToggleUI]_TransparentBackfaceEnable("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_EnableBlendModePreserveSpecularLighting("Boolean", Float) = 0
        [HideInInspector][ToggleUI]_ExcludeFromTUAndAA("Boolean", Float) = 0
        [HideInInspector]_StencilRef("Float", Int) = 0
        [HideInInspector]_StencilWriteMask("Float", Int) = 6
        [HideInInspector]_StencilRefDepth("Float", Int) = 1
        [HideInInspector]_StencilWriteMaskDepth("Float", Int) = 9
        [HideInInspector]_StencilRefMV("Float", Int) = 33
        [HideInInspector]_StencilWriteMaskMV("Float", Int) = 43
        [HideInInspector]_StencilRefDistortionVec("Float", Int) = 4
        [HideInInspector]_StencilWriteMaskDistortionVec("Float", Int) = 4
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDUnlitShader"
            "Queue"="Transparent+0"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="HDUnlitSubTarget"
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        ColorMask 0
        ZClip [_ZClip]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_SHADOWS
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            // GraphIncludes: <None>
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float4 texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float3 positionRWS : INTERP1;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.positionRWS.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.texCoord0 =                  input.texCoord0;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "META"
            Tags
            {
                "LightMode" = "META"
            }
        
            // Render State
            Cull Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            #pragma shader_feature _ EDITOR_VISUALIZATION
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SCENEPICKINGPASS 1
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_TEXCOORD2
            #define ATTRIBUTES_NEED_TEXCOORD3
            #define ATTRIBUTES_NEED_TEXCOORD4
            #define ATTRIBUTES_NEED_TEXCOORD5
            #define ATTRIBUTES_NEED_TEXCOORD6
            #define ATTRIBUTES_NEED_TEXCOORD7
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_POSITIONPREDISPLACEMENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD1
            #define VARYINGS_NEED_TEXCOORD2
            #define VARYINGS_NEED_TEXCOORD3
            #define VARYINGS_NEED_TEXCOORD4
            #define VARYINGS_NEED_TEXCOORD5
            #define VARYINGS_NEED_TEXCOORD6
            #define VARYINGS_NEED_TEXCOORD7
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
            #define FRAG_INPUTS_USE_TEXCOORD1
            #define FRAG_INPUTS_USE_TEXCOORD2
            #define FRAG_INPUTS_USE_TEXCOORD3
            #define FRAG_INPUTS_USE_TEXCOORD4
            #define FRAG_INPUTS_USE_TEXCOORD5
            #define FRAG_INPUTS_USE_TEXCOORD6
            #define FRAG_INPUTS_USE_TEXCOORD7
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 uv2 : TEXCOORD2;
             float4 uv3 : TEXCOORD3;
             float4 uv4 : TEXCOORD4;
             float4 uv5 : TEXCOORD5;
             float4 uv6 : TEXCOORD6;
             float4 uv7 : TEXCOORD7;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 positionPredisplacementRWS;
             float4 texCoord0;
             float4 texCoord1;
             float4 texCoord2;
             float4 texCoord3;
             float4 texCoord4;
             float4 texCoord5;
             float4 texCoord6;
             float4 texCoord7;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 texCoord1 : INTERP1;
             float4 texCoord2 : INTERP2;
             float4 texCoord3 : INTERP3;
             float4 texCoord4 : INTERP4;
             float4 texCoord5 : INTERP5;
             float4 texCoord6 : INTERP6;
             float4 texCoord7 : INTERP7;
             float4 color : INTERP8;
             float3 positionRWS : INTERP9;
             float3 positionPredisplacementRWS : INTERP10;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.texCoord3.xyzw = input.texCoord3;
            output.texCoord4.xyzw = input.texCoord4;
            output.texCoord5.xyzw = input.texCoord5;
            output.texCoord6.xyzw = input.texCoord6;
            output.texCoord7.xyzw = input.texCoord7;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            output.positionPredisplacementRWS.xyz = input.positionPredisplacementRWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.texCoord3 = input.texCoord3.xyzw;
            output.texCoord4 = input.texCoord4.xyzw;
            output.texCoord5 = input.texCoord5.xyzw;
            output.texCoord6 = input.texCoord6.xyzw;
            output.texCoord7 = input.texCoord7.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.positionPredisplacementRWS = input.positionPredisplacementRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            struct VertexDescription
        {
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
        
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorVertMeshCustomInterpolation' */
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.positionPredisplacementRWS = input.positionPredisplacementRWS;
            output.texCoord0 =                  input.texCoord0;
            output.texCoord1 =                  input.texCoord1;
            output.texCoord2 =                  input.texCoord2;
            output.texCoord3 =                  input.texCoord3;
            output.texCoord4 =                  input.texCoord4;
            output.texCoord5 =                  input.texCoord5;
            output.texCoord6 =                  input.texCoord6;
            output.texCoord7 =                  input.texCoord7;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorVaryingsToFragInputs' */
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassLightTransport.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
            // Render State
            Cull [_CullMode]
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma editor_sync_compilation
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define SCENEPICKINGPASS 1
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float4 color : INTERP2;
             float3 positionRWS : INTERP3;
             float3 normalWS : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
            // Render State
            Cull Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma editor_sync_compilation
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SCENESELECTIONPASS 1
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 color : INTERP1;
             float3 positionRWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "MotionVectors"
            Tags
            {
                "LightMode" = "MotionVectors"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        Stencil
        {
        WriteMask [_StencilWriteMaskMV]
        Ref [_StencilRefMV]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_MOTION_VECTORS
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float4 color : INTERP2;
             float3 positionRWS : INTERP3;
             float3 normalWS : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassMotionVectors.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "DepthForwardOnly"
            Tags
            {
                "LightMode" = "DepthForwardOnly"
            }
        
            // Render State
            Cull [_CullMode]
        ZWrite On
        Stencil
        {
        WriteMask [_StencilWriteMaskDepth]
        Ref [_StencilRefDepth]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_DEPTH_ONLY
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TANGENT_TO_WORLD
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float3 normalWS;
             float4 tangentWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 tangentWS : INTERP0;
             float4 texCoord0 : INTERP1;
             float4 color : INTERP2;
             float3 positionRWS : INTERP3;
             float3 normalWS : INTERP4;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.tangentToWorld =             BuildTangentToWorld(input.tangentWS, input.normalWS);
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "ForwardOnly"
            Tags
            {
                "LightMode" = "ForwardOnly"
            }
        
            // Render State
            Cull [_CullModeForward]
        Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
        Blend 1 One OneMinusSrcAlpha
        Blend 2 One [_DstBlend2]
        Blend 3 One [_DstBlend2]
        Blend 4 One OneMinusSrcAlpha
        ZTest [_ZTestDepthEqualForOpaque]
        ZWrite [_ZWrite]
        ColorMask [_ColorMaskTransparentVelOne] 1
        ColorMask [_ColorMaskTransparentVelTwo] 2
        Stencil
        {
        WriteMask [_StencilWriteMask]
        Ref [_StencilRef]
        CompFront Always
        PassFront Replace
        CompBack Always
        PassBack Replace
        }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local _ _ADD_PRECOMPUTED_VELOCITY
        #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC _TRANSPARENT_REFRACTIVE_SORT
        #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_FORWARD_UNLIT
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 color : INTERP1;
             float3 positionRWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float4 VTPackedFeedback;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            #if defined(KEYWORD_PERMUTATION_0)
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            #endif
            #if defined(KEYWORD_PERMUTATION_1)
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            #endif
            #if defined(KEYWORD_PERMUTATION_2)
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            #endif
            #if defined(KEYWORD_PERMUTATION_3)
            {
                surface.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
            }
            #endif
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "FullScreenDebug"
            Tags
            {
                "LightMode" = "FullScreenDebug"
            }
        
            // Render State
            Cull [_CullMode]
        ZTest LEqual
        ZWrite Off
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma instancing_options renderinglayer
        #pragma target 4.5
        #pragma vertex Vert
        #pragma fragment Frag
        #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch2 switch
        #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_FULL_SCREEN_DEBUG
        #define RAYTRACING_SHADER_GRAPH_DEFAULT
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            struct CustomInterpolators
        {
        };
        #define USE_CUSTOMINTERP_SUBSTRUCT
        
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_TEXCOORD1
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
            #define HAVE_MESH_MODIFICATION
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct AttributesMesh
        {
             float3 positionOS : POSITION;
             float3 normalOS : NORMAL;
             float4 tangentOS : TANGENT;
             float4 uv0 : TEXCOORD0;
             float4 uv1 : TEXCOORD1;
             float4 color : COLOR;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
        };
        struct VaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float3 positionRWS;
             float4 texCoord0;
             float4 color;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        struct VertexDescriptionInputs
        {
             float3 ObjectSpaceNormal;
             float3 ObjectSpaceTangent;
             float3 ObjectSpacePosition;
             float3 AbsoluteWorldSpacePosition;
             float4 uv0;
             float4 uv1;
             float3 TimeParameters;
        };
        struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        struct PackedVaryingsMeshToPS
        {
            SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
             float4 texCoord0 : INTERP0;
             float4 color : INTERP1;
             float3 positionRWS : INTERP2;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
        };
        
            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
        {
            PackedVaryingsMeshToPS output;
            ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.color.xyzw = input.color;
            output.positionRWS.xyz = input.positionRWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
        {
            VaryingsMeshToPS output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.color = input.color.xyzw;
            output.positionRWS = input.positionRWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            return output;
        }
        
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Comparison_Greater_float(float A, float B, out float Out)
        {
            Out = A > B ? 1 : 0;
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }
        
        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_SquareRoot_float(float In, out float Out)
        {
            Out = sqrt(In);
        }
        
        void Unity_Multiply_float2_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            float _Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_053b93d341c54017acdcf5ca085ba201_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_053b93d341c54017acdcf5ca085ba201_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_053b93d341c54017acdcf5ca085ba201_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_053b93d341c54017acdcf5ca085ba201_A_4_Float = 0;
            float4 _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4 = IN.uv0;
            float _Split_910afe74b35d4bea90313d0d57c29fb5_R_1_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[0];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_G_2_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[1];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[2];
            float _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float = _UV_a76018e287ec4418a5413193f892390e_Out_0_Vector4[3];
            float4 _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4 = IN.uv1;
            float _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[0];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_G_2_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[1];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[2];
            float _Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float = _UV_1620b881e6d64a31aa9e04c6ea21c565_Out_0_Vector4[3];
            float _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float;
            Unity_Multiply_float_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, 0.5, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float);
            float _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float;
            Unity_Subtract_float(_Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Multiply_42097e5e6a3e4e409729b988926db705_Out_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float);
            float _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Split_053b93d341c54017acdcf5ca085ba201_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean);
            float _Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean;
            Unity_Comparison_Greater_float(_Property_319b5d499b11413798b70c730d8ad7b6_Out_0_Float, float(0), _Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean);
            UnityTexture2D _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexGust);
            float _Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float;
            Unity_Branch_float(_Property_aebcaf587be14fed8f0ba90926ddaf25_Out_0_Boolean, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Split_910afe74b35d4bea90313d0d57c29fb5_A_4_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float);
            float3 _Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3 = float3(_Split_910afe74b35d4bea90313d0d57c29fb5_B_3_Float, _Branch_76971fdbb3484ce6a4407fc139039503_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_R_1_Float);
            float3 _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3;
            _Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3 = TransformObjectToWorld(_Vector3_55bc2b3bb47947bf81fb84adc2c54e24_Out_0_Vector3.xyz);
            float3 _Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float _Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float = WIND_SETTINGS_GustSpeed;
            float3 _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_693a4b1c7823487fa2f6872603d84564_Out_0_Vector3, (_Property_2b929fc1f51243f78e3f341e14860d4d_Out_0_Float.xxx), _Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3);
            float3 _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_7f690e37d2c8499c9cc92fd0b22a1ea1_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3);
            float3 _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3;
            Unity_Subtract_float3(_Transform_579e42905a3a4bfbb822a7cc4617fd60_Out_1_Vector3, _Multiply_c9e0de4da80e4548bbdc6a31b4ed44f3_Out_2_Vector3, _Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3);
            float _Property_92de9af0229e4016afc0dad754327a92_Out_0_Float = WIND_SETTINGS_GustWorldScale;
            float3 _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_f125f94c3e254b0690af032ba3e728b3_Out_2_Vector3, (_Property_92de9af0229e4016afc0dad754327a92_Out_0_Float.xxx), _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3);
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[0];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_G_2_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[1];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float = _Multiply_447b2d1433aa4fdf94e4bab27a7aa99a_Out_2_Vector3[2];
            float _Split_9a25ddaedf8347dd96aab08c72dc9795_A_4_Float = 0;
            float4 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4;
            float3 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3;
            float2 _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2;
            Unity_Combine_float(_Split_9a25ddaedf8347dd96aab08c72dc9795_R_1_Float, _Split_9a25ddaedf8347dd96aab08c72dc9795_B_3_Float, float(0), float(0), _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGBA_4_Vector4, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RGB_5_Vector3, _Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2);
              float4 _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.tex, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.samplerstate, _Property_e38c438e07514f4e81b1ff1a6bfbced1_Out_0_Texture2D.GetTransformedUV(_Combine_63d5dc0fe3f24a7e92517c6bc0f35ec4_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_G_6_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_B_7_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_A_8_Float = _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_RGBA_0_Vector4.a;
            float _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float;
            Unity_Branch_float(_Comparison_f0c56ec641ea4db296b47314f778c7fb_Out_2_Boolean, _SampleTexture2DLOD_02d7b714b8de4cad9413739161afac6d_R_5_Float, float(0), _Branch_924e9783007548e1adfe644e2a385413_Out_3_Float);
            float _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float;
            Unity_Absolute_float(_Branch_924e9783007548e1adfe644e2a385413_Out_3_Float, _Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float);
            float _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float;
            Unity_Power_float(_Absolute_2986dc4c2c6949a1aa9954d3e1e7acde_Out_1_Float, float(2), _Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float);
            float _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float = WIND_SETTINGS_GustScale;
            float _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float;
            Unity_Multiply_float_float(_Power_7c1e5d5c9dae41aaa087097710b8019b_Out_2_Float, _Property_5a31c62e6cc2411a8f57a079c909d522_Out_0_Float, _Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float);
            float4 _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[0];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_G_2_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[1];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[2];
            float _Split_5386e96ec4c8431ebce347e93328fe6a_A_4_Float = _Property_15b97986de38451a8e0d1b1335e04f9b_Out_0_Vector4[3];
            float2 _Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2 = float2(_Split_5386e96ec4c8431ebce347e93328fe6a_R_1_Float, _Split_5386e96ec4c8431ebce347e93328fe6a_B_3_Float);
            float _Property_7f979362cf5546918a12aded783bbac5_Out_0_Float = _Gust_Strength;
            float _Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean = _Wind_from_Center_T_Age_F;
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_e5b1fb1c81ad4191899fcb448f7b587a_A_4_Float = 0;
            float _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float;
            Unity_Subtract_float(_Split_e5b1fb1c81ad4191899fcb448f7b587a_G_2_Float, _Subtract_0c57cb8723734dc19c9bee488b908a06_Out_2_Float, _Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float);
            float _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float;
            Unity_Clamp_float(_Subtract_6ac461b4e3924536b1a04902d0a9d329_Out_2_Float, float(0.0001), float(1000), _Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float);
            float _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float;
            Unity_Divide_float(_Clamp_19a1b7ebc758455fad085eaeda82e7dd_Out_3_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float);
            float _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float;
            Unity_Absolute_float(_Divide_79eb0c480b414a4985a0fa3b161c8cef_Out_2_Float, _Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float);
            float _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float = _Bend_Strength;
            float _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float;
            Unity_Power_float(_Absolute_df946080c325491bb882347a3a61b4ca_Out_1_Float, _Property_8c9ba78eb64d457e813db72f4b256237_Out_0_Float, _Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float);
            float _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float;
            Unity_Multiply_float_float(_Power_9a76b6ac5cd04b0990704595c68499b7_Out_2_Float, _Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float);
            float _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float;
            Unity_Absolute_float(_Split_aaa89768122741eb9c9fbf5f188d5164_A_4_Float, _Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float);
            float _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float = _Bend_Strength;
            float _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float;
            Unity_Power_float(_Absolute_b45a32bd97354b64b73909a06e0f5cce_Out_1_Float, _Property_1009d6c2f37c4403bc63017f0b63edc1_Out_0_Float, _Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float);
            float _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float;
            Unity_SquareRoot_float(_Split_aaa89768122741eb9c9fbf5f188d5164_B_3_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float);
            float _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float;
            Unity_Multiply_float_float(_Power_4f9e62bef6814a4fa9d3eb10f3c56a2d_Out_2_Float, _SquareRoot_655cf5cb153b4c4fba7a9aa2dbcc2a70_Out_1_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float);
            float _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float;
            Unity_Branch_float(_Property_98864462e0ef494cb3a51bb0c2fc2786_Out_0_Boolean, _Multiply_b990a64dbf674376aa67a4fa010f5758_Out_2_Float, _Multiply_9e5a3db8aa86411f9bbc3d014039ec02_Out_2_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float);
            float _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float;
            Unity_Multiply_float_float(_Property_7f979362cf5546918a12aded783bbac5_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float);
            float2 _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2;
            Unity_Multiply_float2_float2(_Vector2_37e8bf7b34164166b2cd74ce9422437f_Out_0_Vector2, (_Multiply_f12542900fcc4c76a35edaf4091718e2_Out_2_Float.xx), _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2);
            float _Split_e550a9498ca049469521454832ad1fbf_R_1_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[0];
            float _Split_e550a9498ca049469521454832ad1fbf_G_2_Float = _Multiply_cb1decbea10242fcb3920b544cb35fe3_Out_2_Vector2[1];
            float _Split_e550a9498ca049469521454832ad1fbf_B_3_Float = 0;
            float _Split_e550a9498ca049469521454832ad1fbf_A_4_Float = 0;
            float3 _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3 = float3(_Split_e550a9498ca049469521454832ad1fbf_R_1_Float, float(0), _Split_e550a9498ca049469521454832ad1fbf_G_2_Float);
            float3 _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Multiply_c54d791969c647d3a1d7a55bf50ad89e_Out_2_Float.xxx), _Vector3_762ff644ebf84f5c9d2a5eef2078e8ff_Out_0_Vector3, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3);
            float3 _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3;
            Unity_Add_float3(_Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Add_cd114e704768447cb940749c137d5804_Out_2_Vector3);
            UnityTexture2D _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(WIND_SETTINGS_TexNoise);
            float3 _Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3 = float3(float(1), float(0), float(0));
            float4 _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4 = WIND_SETTINGS_WorldDirectionAndSpeed;
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_R_1_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[0];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_G_2_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[1];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_B_3_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[2];
            float _Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float = _Property_80553d28c2274723bc767446d8b8c416_Out_0_Vector4[3];
            float3 _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Vector3_2f410f1f30d34f6e980bb18bbb5a7b23_Out_0_Vector3, (_Split_83eb5189f1794b5897d8a05e8f78a6a4_A_4_Float.xxx), _Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3);
            float3 _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_6e0539c917fa454ea03703995309acc0_Out_2_Vector3, (IN.TimeParameters.x.xxx), _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3);
            float3 _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3;
            Unity_Subtract_float3(IN.AbsoluteWorldSpacePosition, _Multiply_e6efdf5713e6498bb3b6bd95fb2504a8_Out_2_Vector3, _Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3);
            float _Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float = WIND_SETTINGS_ShiverNoiseScale;
            float3 _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Subtract_e334e44e14574262b4a1aafddff9bdde_Out_2_Vector3, (_Property_c2d3cac7ffdd452c9a99265070491d1d_Out_0_Float.xxx), _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3);
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[0];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_G_2_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[1];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float = _Multiply_3e4f0777c1064514839ab534f4081a19_Out_2_Vector3[2];
            float _Split_5cc5d380b8b542a9aa414b04e31f4fc9_A_4_Float = 0;
            float4 _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4;
            float3 _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3;
            float2 _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2;
            Unity_Combine_float(_Split_5cc5d380b8b542a9aa414b04e31f4fc9_R_1_Float, _Split_5cc5d380b8b542a9aa414b04e31f4fc9_B_3_Float, float(0), float(0), _Combine_8e6702e470a1431597a781b5fad7389b_RGBA_4_Vector4, _Combine_8e6702e470a1431597a781b5fad7389b_RGB_5_Vector3, _Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2);
              float4 _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4 = SAMPLE_TEXTURE2D_LOD(_Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.tex, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.samplerstate, _Property_711dd0a019124373806ea4cd0ead1472_Out_0_Texture2D.GetTransformedUV(_Combine_8e6702e470a1431597a781b5fad7389b_RG_6_Vector2), float(3));
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.r;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.g;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.b;
            float _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_A_8_Float = _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_RGBA_0_Vector4.a;
            float4 _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4;
            float3 _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3;
            float2 _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2;
            Unity_Combine_float(_SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_R_5_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_G_6_Float, _SampleTexture2DLOD_a7ce1dedf99d4f9fb6f656fe617f74ba_B_7_Float, float(0), _Combine_317ee724efd04ebea45c883b40eb63dd_RGBA_4_Vector4, _Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, _Combine_317ee724efd04ebea45c883b40eb63dd_RG_6_Vector2);
            float3 _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3;
            Unity_Add_float3(_Combine_317ee724efd04ebea45c883b40eb63dd_RGB_5_Vector3, float3(-0.5, -0.5, -0.5), _Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3);
            float _Property_70940dc414e9445798faf654716fdba6_Out_0_Float = WIND_SETTINGS_Turbulence;
            float3 _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Add_ab8b41211dac4a218aab201320128899_Out_2_Vector3, (_Property_70940dc414e9445798faf654716fdba6_Out_0_Float.xxx), _Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3);
            float _Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float = _Shiver_Strength;
            float _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float;
            Unity_Multiply_float_float(_Property_21aa90d268b241228315ec9e19ab784e_Out_0_Float, _Branch_d0ce7b0190094812b7e7aee2463c2a19_Out_3_Float, _Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float);
            float3 _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Multiply_4aea49aaf5d34b778eeff4dbb997f7b9_Out_2_Vector3, (_Multiply_1f4089eb1cff4f2daaa768199405079d_Out_2_Float.xxx), _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3);
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_R_1_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[0];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[1];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_B_3_Float = _Multiply_07debcd9cc404a7baa3d7ff4442cbc64_Out_2_Vector3[2];
            float _Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_A_4_Float = 0;
            float3 _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3;
            Unity_Add_float3(_Add_cd114e704768447cb940749c137d5804_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3);
            float3 _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3;
            Unity_Branch_float3(_Comparison_c5190a94231a4f13b79225d4db5feabf_Out_2_Boolean, _Add_b38a787750854807a706609e87089ff3_Out_2_Vector3, IN.AbsoluteWorldSpacePosition, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3);
            float3 _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3;
            Unity_Add_float3(IN.AbsoluteWorldSpacePosition, _Multiply_32f0daac15a44c128b3db835220b9995_Out_2_Vector3, _Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3);
            float3 _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3;
            Unity_Add_float3(_Add_f7d6689fb46d4901800c3124b8258adf_Out_2_Vector3, (_Split_b8033ada4f9d4776ad4d2b3a8c1e4f7f_G_2_Float.xxx), _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3);
            float3 _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            Unity_Branch_float3(_Property_df686f2143814812913ecc432f9c152b_Out_0_Boolean, _Branch_b9b2aef2a95440c4a0738de8c8755fee_Out_3_Vector3, _Add_d2a1a07d64874df591c237f1fdfdab44_Out_2_Vector3, _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3);
            #if defined(USE_WIND_ON)
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = _Branch_26bd766fb7984876860ed5a1d15151c0_Out_3_Vector3;
            #else
            float3 _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3 = IN.AbsoluteWorldSpacePosition;
            #endif
            description.Position = _UseWind_2930f210714c4e33be2597c28befa500_Out_0_Vector3;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            
        VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
            output.AbsoluteWorldSpacePosition =                 GetAbsolutePositionWS(TransformObjectToWorld(input.positionOS).xyz);
            output.uv0 =                                        input.uv0;
            output.uv1 =                                        input.uv1;
            output.TimeParameters =                             _TimeParameters.xyz; // Note: in case of animation this will be overwrite (allow to handle motion vector)
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
            return output;
        }
        
        VertexDescription GetVertexDescription(AttributesMesh input, float3 timeParameters
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            // build graph inputs
            VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);
            // Override time parameters with used one (This is required to correctly handle motion vectors for vertex animation based on time)
            vertexDescriptionInputs.TimeParameters = timeParameters;
        
            // evaluate vertex graph
        #ifdef HAVE_VFX_MODIFICATION
            GraphProperties properties;
            ZERO_INITIALIZE(GraphProperties, properties);
        
            // Fetch the vertex graph properties for the particle instance.
            GetElementVertexProperties(element, properties);
        
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs, properties);
        #else
            VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);
        #endif
            return vertexDescription;
        
        }
        
        AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters
        #ifdef USE_CUSTOMINTERP_SUBSTRUCT
            #ifdef TESSELLATION_ON
            , inout VaryingsMeshToDS varyings
            #else
            , inout VaryingsMeshToPS varyings
            #endif
        #endif
        #ifdef HAVE_VFX_MODIFICATION
                , AttributesElement element
        #endif
            )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, timeParameters
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
        
            // copy graph output to the results
            input.positionOS = vertexDescription.Position;
            input.normalOS = vertexDescription.Normal;
            input.tangentOS.xyz = vertexDescription.Tangent;
        
            
        
            return input;
        }
        
        #if defined(_ADD_CUSTOM_VELOCITY) // For shader graph custom velocity
        // Return precomputed Velocity in object space
        float3 GetCustomVelocity(AttributesMesh input
        #ifdef HAVE_VFX_MODIFICATION
            , AttributesElement element
        #endif
        )
        {
            VertexDescription vertexDescription = GetVertexDescription(input, _TimeParameters.xyz
        #ifdef HAVE_VFX_MODIFICATION
                , element
        #endif
            );
            return vertexDescription.CustomVelocity;
        }
        #endif
        
        FragInputs BuildFragInputs(VaryingsMeshToPS input)
        {
            FragInputs output;
            ZERO_INITIALIZE(FragInputs, output);
        
            // Init to some default value to make the computer quiet (else it output 'divide by zero' warning even if value is not used).
            // TODO: this is a really poor workaround, but the variable is used in a bunch of places
            // to compute normals which are then passed on elsewhere to compute other values...
            output.tangentToWorld = k_identity3x3;
            output.positionSS = input.positionCS;       // input.positionCS is SV_Position
        
            output.positionRWS =                input.positionRWS;
            output.positionPixel =              input.positionCS.xy; // NOTE: this is not actually in clip space, it is the VPOS pixel coordinate value
            output.texCoord0 =                  input.texCoord0;
            output.color =                      input.color;
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else
        #endif
        
        #ifdef HAVE_VFX_MODIFICATION
            // FragInputs from VFX come from two places: Interpolator or CBuffer.
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
        
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            // splice point to copy custom interpolator fields from varyings to frag inputs
            
        
            return output;
        }
        
        // existing HDRP code uses the combined function to go directly from packed to frag inputs
        FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
        {
            UNITY_SETUP_INSTANCE_ID(input);
        #if defined(HAVE_VFX_MODIFICATION) && defined(UNITY_INSTANCING_ENABLED)
            unity_InstanceID = input.instanceID;
        #endif
            VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
            return BuildFragInputs(unpacked);
        }
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassFullScreenDebug.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="HDRenderPipeline"
            "RenderType"="HDUnlitShader"
            "Queue"="Transparent+0"
            "DisableBatching"="False"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="HDUnlitSubTarget"
        }
        Pass
        {
            Name "IndirectDXR"
            Tags
            {
                "LightMode" = "IndirectDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_INDIRECT
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/UnlitRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingIndirect.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "VisibilityDXR"
            Tags
            {
                "LightMode" = "VisibilityDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma multi_compile _ TRANSPARENT_COLOR_SHADOW
        #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_VISIBILITY
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/UnlitRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingVisibility.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "ForwardDXR"
            Tags
            {
                "LightMode" = "ForwardDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_FORWARD
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/UnlitRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingForward.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "GBufferDXR"
            Tags
            {
                "LightMode" = "GBufferDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_RAYTRACING_GBUFFER
        #define PUNCTUAL_SHADOW_LOW
        #define DIRECTIONAL_SHADOW_LOW
        #define RAYTRACING_SHADER_GRAPH_RAYTRACED
        #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER 1
        #define PATH_TRACING_CLUSTERED_DECALS 1
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/Deferred/RaytracingIntersectonGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/NormalBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/StandardLit/StandardLit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/UnlitRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRaytracingGBuffer.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
        Pass
        {
            Name "DebugDXR"
            Tags
            {
                "LightMode" = "DebugDXR"
            }
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassRayTracingDebug.hlsl"
        
            ENDHLSL
        }
        Pass
        {
            Name "PathTracingDXR"
            Tags
            {
                "LightMode" = "PathTracingDXR"
            }
        
            // Render State
            // RenderState: <None>
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            HLSLPROGRAM
        
            // Pragmas
            #pragma target 5.0
        #pragma raytracing surface_shader
        #pragma only_renderers d3d11 xboxseries ps5
        
            // Keywords
            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
        #pragma multi_compile _ DEBUG_DISPLAY
            #pragma shader_feature_local _ USE_TRANSPARENCY_INTERSECTION_ON
        #pragma shader_feature_local _ USE_WIND_ON
        
        #if defined(USE_TRANSPARENCY_INTERSECTION_ON) && defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_0
        #elif defined(USE_TRANSPARENCY_INTERSECTION_ON)
            #define KEYWORD_PERMUTATION_1
        #elif defined(USE_WIND_ON)
            #define KEYWORD_PERMUTATION_2
        #else
            #define KEYWORD_PERMUTATION_3
        #endif
        
        
            // Defines
            #define SHADERPASS SHADERPASS_PATH_TRACING
        #define SUPPORT_GLOBAL_MIP_BIAS 1
        #define REQUIRE_DEPTH_TEXTURE
        
            // For custom interpolators to inject a substruct definition before FragInputs definition,
            // allowing for FragInputs to capture CI's intended for ShaderGraph's SDI.
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreInclude' */
        
        
            // TODO: Merge FragInputsVFX substruct with CustomInterpolators.
        	#ifdef HAVE_VFX_MODIFICATION
        	struct FragInputsVFX
            {
                /* WARNING: $splice Could not find named fragment 'FragInputsVFX' */
            };
            #endif
        
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl" // Required by Tessellation.hlsl
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl" // Required to be include before we include properties as it define DECLARE_STACK_CB
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl" // Required before including properties as it defines UNITY_TEXTURE_STREAMING_DEBUG_VARS
            // Always include Shader Graph version
            // Always include last to avoid double macros
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl" // Need to be here for Gradient struct definition
        
            // --------------------------------------------------
            // Defines
        
            // Attribute
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
        
        
            //Strip down the FragInputs.hlsl (on graphics), so we can only optimize the interpolators we use.
            //if by accident something requests contents of FragInputs.hlsl, it will be caught as a compiler error
            //Frag inputs stripping is only enabled when FRAG_INPUTS_ENABLE_STRIPPING is set
            #if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            #define FRAG_INPUTS_ENABLE_STRIPPING
            #endif
            #define FRAG_INPUTS_USE_TEXCOORD0
        
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
        
        
        
        
            // Following two define are a workaround introduce in 10.1.x for RaytracingQualityNode
            // The ShaderGraph don't support correctly migration of this node as it serialize all the node data
            // in the json file making it impossible to uprgrade. Until we get a fix, we do a workaround here
            // to still allow us to rename the field and keyword of this node without breaking existing code.
            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
            #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
            #define RAYTRACING_SHADER_GRAPH_LOW
            #endif
            // end
        
            #ifndef SHADER_UNLIT
            // We need isFrontFace when using double sided - it is not required for unlit as in case of unlit double sided only drive the cullmode
            // VARYINGS_NEED_CULLFACE can be define by VaryingsMeshToPS.FaceSign input if a IsFrontFace Node is included in the shader graph.
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif
        
            // Specific Material Define
        // Setup a define to say we are an unlit shader
        #define SHADER_UNLIT
        
        // Following Macro are only used by Unlit material
        #if defined(_ENABLE_SHADOW_MATTE)
            #if SHADERPASS == SHADERPASS_FORWARD_UNLIT
                #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
            #elif SHADERPASS == SHADERPASS_PATH_TRACING
                #define LIGHTLOOP_DISABLE_TILE_AND_CLUSTER
            #endif
        
        // We don't want to have the lightloop defined for the ray tracing passes, but we do for the rasterisation and path tracing shader passes.
        #if !defined(SHADER_STAGE_RAY_TRACING) || SHADERPASS == SHADERPASS_PATH_TRACING
            #define HAS_LIGHTLOOP
        #endif
        #endif
            // Caution: we can use the define SHADER_UNLIT onlit after the above Material include as it is the Unlit template who define it
        
            // To handle SSR on transparent correctly with a possibility to enable/disable it per framesettings
            // we should have a code like this:
            // if !defined(_DISABLE_SSR_TRANSPARENT)
            // pragma multi_compile _ WRITE_NORMAL_BUFFER
            // endif
            // i.e we enable the multicompile only if we can receive SSR or not, and then C# code drive
            // it based on if SSR transparent in frame settings and not (and stripper can strip it).
            // this is currently not possible with our current preprocessor as _DISABLE_SSR_TRANSPARENT is a keyword not a define
            // so instead we used this and chose to pay the extra cost of normal write even if SSR transaprent is disabled.
            // Ideally the shader graph generator should handle it but condition below can't be handle correctly for now.
            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif
        
            // See Lit.shader
            #if SHADERPASS == SHADERPASS_MOTION_VECTORS && defined(WRITE_DECAL_BUFFER_AND_RENDERING_LAYER)
                #define WRITE_DECAL_BUFFER
            #endif
        
            #ifndef DEBUG_DISPLAY
                // In case of opaque we don't want to perform the alpha test, it is done in depth prepass and we use depth equal for ztest (setup from UI)
                // Don't do it with debug display mode as it is possible there is no depth prepass in this case
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif
        
            // Define _DEFERRED_CAPABLE_MATERIAL for shader capable to run in deferred pass
            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            // Translate transparent motion vector define
            #if (defined(_TRANSPARENT_WRITES_MOTION_VEC) || defined(_TRANSPARENT_REFRACTIVE_SORT)) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
        
            // -- Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _Emission_Flipbook_TexelSize;
        float _Use_Texture_as_Alpha;
        float _Alpha_Multiplier;
        float _Emission_Intensity;
        float4 _Emission_Color;
        float _Wind_from_Center_T_Age_F;
        float _Gust_Strength;
        float _Shiver_Strength;
        float _Bend_Strength;
        float _Intersection_Offset;
        float4 _EmissionColor;
        float _UseShadowThreshold;
        float4 _DoubleSidedConstants;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        float _BlendMode;
        float _EnableBlendModePreserveSpecularLighting;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_Emission_Flipbook);
        SAMPLER(sampler_Emission_Flipbook);
        TEXTURE2D(WIND_SETTINGS_TexNoise);
        SAMPLER(samplerWIND_SETTINGS_TexNoise);
        float4 WIND_SETTINGS_TexNoise_TexelSize;
        TEXTURE2D(WIND_SETTINGS_TexGust);
        SAMPLER(samplerWIND_SETTINGS_TexGust);
        float4 WIND_SETTINGS_TexGust_TexelSize;
        float4 WIND_SETTINGS_WorldDirectionAndSpeed;
        float WIND_SETTINGS_ShiverNoiseScale;
        float WIND_SETTINGS_Turbulence;
        float WIND_SETTINGS_GustSpeed;
        float WIND_SETTINGS_GustScale;
        float WIND_SETTINGS_GustWorldScale;
        
            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif
        
            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracing.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/ShaderVariablesRaytracingLightLoop.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RaytracingIntersection.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/Raytracing/Shaders/RayTracingCommon.hlsl"
        #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
        
            // --------------------------------------------------
            // Structs and Packing
        
            struct SurfaceDescriptionInputs
        {
             float3 WorldSpacePosition;
             float4 ScreenPosition;
             float2 NDCPosition;
             float2 PixelPosition;
             float4 uv0;
             float4 VertexColor;
        };
        
            //Interpolator Packs: <None>
        
            // --------------------------------------------------
            // Graph
        
        
            // Graph Functions
            
        void Unity_SceneDepth_Linear01_float(float4 UV, out float Out)
        {
            Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
            Out = A * B;
        }
        
        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        float3 Unity_HDRP_GetEmissionHDRColor_float(float3 ldrColor, float luminanceIntensity, float exposureWeight)
        {
            float3 hdrColor = ldrColor * luminanceIntensity;
        
            #ifdef SHADERGRAPH_PREVIEW
            float inverseExposureMultiplier = 1.0;
            #else
            float inverseExposureMultiplier = GetInverseCurrentExposureMultiplier();
            #endif
        
            // Inverse pre-expose using _EmissiveExposureWeight weight
            hdrColor = lerp(hdrColor * inverseExposureMultiplier, hdrColor, exposureWeight);
            return hdrColor;
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        void Unity_Branch_float(float Predicate, float True, float False, out float Out)
        {
            Out = Predicate ? True : False;
        }
        
            // Graph Vertex
            // GraphVertex: <None>
        
            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            float _Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float = _Intersection_Offset;
            float _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float;
            Unity_SceneDepth_Linear01_float(float4(IN.NDCPosition.xy, 0, 0), _SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float);
            float _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float;
            Unity_Multiply_float_float(_SceneDepth_02f3652a6ef44e13b448bc9107934aa5_Out_1_Float, _ProjectionParams.z, _Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float);
            float4 _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4 = IN.ScreenPosition;
            float _Split_093b6b23238f44ad838c7c5a31908591_R_1_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[0];
            float _Split_093b6b23238f44ad838c7c5a31908591_G_2_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[1];
            float _Split_093b6b23238f44ad838c7c5a31908591_B_3_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[2];
            float _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float = _ScreenPosition_1030361c969d498abed07cc11fcbbd28_Out_0_Vector4[3];
            float _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float;
            Unity_Subtract_float(_Multiply_fb9c1fa00e2c4308b99deb2720547a73_Out_2_Float, _Split_093b6b23238f44ad838c7c5a31908591_A_4_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float);
            float _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float;
            Unity_Multiply_float_float(_Property_63e5c53a54c9425ca5dd41d50122c66e_Out_0_Float, _Subtract_5182dd247c2746bf9fe94421c2d7103e_Out_2_Float, _Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float);
            float _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float;
            Unity_Clamp_float(_Multiply_1e6ab4c80b264aeb8dc92a83adbf6cba_Out_2_Float, float(0), float(1), _Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float);
            float4 _Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4 = IsGammaSpace() ? LinearToSRGB(_Emission_Color) : _Emission_Color;
            UnityTexture2D _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Emission_Flipbook);
            float4 _UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4 = IN.uv0;
            float4 _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.tex, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.samplerstate, _Property_167d742c9f1a4140a88ccb78bc5e2de6_Out_0_Texture2D.GetTransformedUV((_UV_5235c121952c46d5aeafebb40561bccc_Out_0_Vector4.xy)) );
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.r;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.g;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.b;
            float _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_A_7_Float = _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4.a;
            float4 _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4;
            Unity_Multiply_float4_float4(_Property_424f8ab9ac6949c0a928ee78d9421a2b_Out_0_Vector4, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_RGBA_0_Vector4, _Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4);
            float _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float = _Emission_Intensity;
            float3 _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3 = Unity_HDRP_GetEmissionHDRColor_float((_Multiply_985510ff28c84af0b7fda8323b657b5b_Out_2_Vector4.xyz).xyz, _Property_cc81c96d78ef46c09433e5ebccfd6e56_Out_0_Float, float(0));
            float3 _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            Unity_Multiply_float3_float3((_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float.xxx), _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3, _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _Multiply_eeab5989cd9349d5a4dedd4c5632a8cd_Out_2_Vector3;
            #else
            float3 _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3 = _EmissionNode_acb4e83874cd433fa5de820d6df1c758_Output_0_Vector3;
            #endif
            float3 _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            Unity_Multiply_float3_float3((IN.VertexColor.xyz), _UseTransparencyIntersection_6e1bd62378ca48c69574eedd569b19cb_Out_0_Vector3, _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3);
            float _Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean = _Use_Texture_as_Alpha;
            float _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_R_4_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_G_5_Float, _Add_21f4fac385494c629ba6655c03978c51_Out_2_Float);
            float _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float;
            Unity_Add_float(_Add_21f4fac385494c629ba6655c03978c51_Out_2_Float, _SampleTexture2D_d3939cbc3587491483aa8d3c52f16f24_B_6_Float, _Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float);
            float _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float;
            Unity_Multiply_float_float(_Add_52881bc848db4ca5a53991665b1bd372_Out_2_Float, 0.33, _Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float);
            float _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float = _Alpha_Multiplier;
            float _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float;
            Unity_Multiply_float_float(_Multiply_26200820010b4d7090eb1616a6952f2c_Out_2_Float, _Property_97e59915a6144301ba44d27330ab524b_Out_0_Float, _Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float);
            float _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            Unity_Saturate_float(_Multiply_2548eb9244e646cfb3569063a6d66fad_Out_2_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float);
            float _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            Unity_Multiply_float_float(_Clamp_df9545ba876e40b9ba359293af80b24f_Out_3_Float, _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float, _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float);
            #if defined(USE_TRANSPARENCY_INTERSECTION_ON)
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Multiply_de27e482929a494ebafe66fb5a9ae219_Out_2_Float;
            #else
            float _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float = _Saturate_8ea30515c4bc40fead8c547a954ef97f_Out_1_Float;
            #endif
            float _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            Unity_Branch_float(_Property_3a549e66f0814276a244bb8ce2d351d1_Out_0_Boolean, _UseTransparencyIntersection_6a56fafdad1247c1a5a0de4f4cd925d9_Out_0_Float, float(1), _Branch_6088271999854d34a90750407a8401a3_Out_3_Float);
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = _Multiply_5454d995e84044dba566d13eb2fd74c1_Out_2_Vector3;
            surface.Alpha = _Branch_6088271999854d34a90750407a8401a3_Out_3_Float;
            return surface;
        }
        
            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
            #define VFX_SRP_ATTRIBUTES AttributesMesh
            #define VaryingsMeshType VaryingsMeshToPS
            #define VFX_SRP_VARYINGS VaryingsMeshType
            #define VFX_SRP_SURFACE_INPUTS FragInputs
            #endif
            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
            #if defined(SHADER_STAGE_RAY_TRACING)
            #else
            #endif
            output.WorldSpacePosition =                         input.positionRWS;
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
        #if SHADERPASS != SHADERPASS_FOG_VOLUME_VOXELIZATION
        #else
        #endif
            output.ScreenPosition = ComputeScreenPos(TransformWorldToHClip(input.positionRWS), _ProjectionParams.x);
        
        #if UNITY_UV_STARTS_AT_TOP
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x < 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #else
            output.PixelPosition = float2(input.positionPixel.x, (_ProjectionParams.x > 0) ? (_ScreenParams.y - input.positionPixel.y) : input.positionPixel.y);
        #endif
        
            output.NDCPosition = output.PixelPosition.xy / _ScreenParams.xy;
            output.NDCPosition.y = 1.0f - output.NDCPosition.y;
        
            output.uv0 =                                        input.texCoord0;
            output.VertexColor =                                input.color;
        
            // splice point to copy frag inputs custom interpolator pack into the SDI
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorCopyToSDI' */
        
            return output;
        }
        
            // --------------------------------------------------
            // Build Surface Data (Specific Material)
        
        void ApplyDecalToSurfaceDataNoNormal(DecalSurfaceData decalSurfaceData, inout SurfaceData surfaceData);
        
        void ApplyDecalAndGetNormal(FragInputs fragInputs, PositionInputs posInput, SurfaceDescription surfaceDescription,
            inout SurfaceData surfaceData)
        {
            float3 doubleSidedConstants = GetDoubleSidedConstants();
        
        #ifdef DECAL_NORMAL_BLENDING
            // SG nodes don't ouptut surface gradients, so if decals require surf grad blending, we have to convert
            // the normal to gradient before applying the decal. We then have to resolve the gradient back to world space
            float3 normalTS;
        
        
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        
            GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
        #else
            // normal delivered to master node
        
            #if HAVE_DECALS
            if (_EnableDecals)
            {
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Both uses and modifies 'surfaceData.normalWS'.
                DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
            }
            #endif
        #endif
        }
        void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
        {
            // setup defaults -- these are used if the graph doesn't output a value
            ZERO_INITIALIZE(SurfaceData, surfaceData);
        
            // copy across graph values, if defined
            surfaceData.color = surfaceDescription.BaseColor;
        
            #ifdef WRITE_NORMAL_BUFFER
            // When we need to export the normal (in the depth prepass, we write the geometry one)
            surfaceData.normalWS = fragInputs.tangentToWorld[2];
            #endif
        
            #if defined(DEBUG_DISPLAY)
            #if !defined(SHADER_STAGE_RAY_TRACING)
            // Mipmap mode debugging isn't supported with ray tracing as it relies on derivatives
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    #ifdef FRAG_INPUTS_USE_TEXCOORD0
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG(posInput.positionSS, fragInputs.texCoord0);
                    #else
                        surfaceData.color = GET_TEXTURE_STREAMING_DEBUG_NO_UV(posInput.positionSS);
                    #endif
                }
            #endif
            #endif
        
            #ifdef _ENABLE_SHADOW_MATTE
        
                #if (SHADERPASS == SHADERPASS_FORWARD_UNLIT) || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS_RAYTRACING_FORWARD)
        
                    HDShadowContext shadowContext = InitShadowContext();
        
                    // Evaluate the shadow, the normal is guaranteed if shadow matte is enabled on this shader.
                    float3 shadow3;
                    ShadowLoopMin(shadowContext, posInput, normalize(fragInputs.tangentToWorld[2]), asuint(_ShadowMatteFilter), GetMeshRenderingLayerMask(), shadow3);
        
                    // Compute the average value in the fourth channel
                    float4 shadow = float4(shadow3, dot(shadow3, float3(1.0/3.0, 1.0/3.0, 1.0/3.0)));
        
                    float4 shadowColor = (1.0 - shadow) * surfaceDescription.ShadowTint.rgba;
                    float  localAlpha  = saturate(shadowColor.a + surfaceDescription.Alpha);
        
                    // Keep the nested lerp
                    // With no Color (bsdfData.color.rgb, bsdfData.color.a == 0.0f), just use ShadowColor*Color to avoid a ring of "white" around the shadow
                    // And mix color to consider the Color & ShadowColor alpha (from texture or/and color picker)
                    #ifdef _SURFACE_TYPE_TRANSPARENT
                        surfaceData.color = lerp(shadowColor.rgb * surfaceData.color, lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb), surfaceDescription.Alpha);
                    #else
                        surfaceData.color = lerp(lerp(shadowColor.rgb, surfaceData.color, 1.0 - surfaceDescription.ShadowTint.a), surfaceData.color, shadow.rgb);
                    #endif
                    localAlpha = ApplyBlendMode(surfaceData.color, localAlpha).a;
        
                    surfaceDescription.Alpha = localAlpha;
        
                #elif SHADERPASS == SHADERPASS_PATH_TRACING
        
                    surfaceData.normalWS = fragInputs.tangentToWorld[2];
                    surfaceData.shadowTint = surfaceDescription.ShadowTint.rgba;
        
                #endif
        
            #endif // _ENABLE_SHADOW_MATTE
        }
        
            // --------------------------------------------------
            // Get Surface And BuiltinData
        
            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {
                // Don't dither if displaced tessellation (we're fading out the displacement instead to match the next LOD)
                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE // enable dithering LOD transition if user select CrossFade transition in LOD group
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif
        
                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
        
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants); // Apply double sided flip on the vertex normal
                #endif // SHADER_UNLIT
        
                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);
        
                #if defined(HAVE_VFX_MODIFICATION)
                GraphProperties properties;
                ZERO_INITIALIZE(GraphProperties, properties);
        
                GetElementPixelProperties(fragInputs, properties);
        
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs, properties);
                #else
                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);
                #endif
        
                #ifdef DEBUG_DISPLAY
                if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                {
                    surfaceDescription.Alpha = 1.0f;
                }
                #endif
        
                // Perform alpha test very early to save performance (a killed pixel will not sample textures)
                // TODO: split graph evaluation to grab just alpha dependencies first? tricky..
                #ifdef _ALPHATEST_ON
                    float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                    #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                    // The TransparentDepthPrepass is also used with SSR transparent.
                    // If an artists enable transaprent SSR but not the TransparentDepthPrepass itself, then we use AlphaClipThreshold
                    // otherwise if TransparentDepthPrepass is enabled we use AlphaClipThresholdDepthPrepass
                    #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
                    // DepthPostpass always use its own alpha threshold
                    alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                    #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                    // If use shadow threshold isn't enable we don't allow any test
                    #endif
        
                    GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif
        
                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif
        
                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD1
                    float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
                    float4 lightmapTexCoord1 = float4(0,0,0,0);
                #endif
        
                #ifdef FRAG_INPUTS_USE_TEXCOORD2
                    float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
                    float4 lightmapTexCoord2 = float4(0,0,0,0);
                #endif
        
                float alpha = 1.0;
                alpha = surfaceDescription.Alpha;
        
                // Builtin Data
                // For back lighting we use the oposite vertex normal
                InitBuiltinData(posInput, alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);
        
                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
        
                ZERO_BUILTIN_INITIALIZE(builtinData); // No call to InitBuiltinData as we don't have any lighting
                builtinData.opacity = surfaceDescription.Alpha;
        
                #if defined(DEBUG_DISPLAY)
                    // Light Layers are currently not used for the Unlit shader (because it is not lit)
                    // But Unlit objects do cast shadows according to their rendering layer mask, which is what we want to
                    // display in the light layers visualization mode, therefore we need the renderingLayers
                    builtinData.renderingLayers = GetMeshRenderingLayerMask();
                #endif
        
                #endif // SHADER_UNLIT
        
                #ifdef _ALPHATEST_ON
                    // Used for sharpening by alpha to mask - Alpha to covertage is only used with depth only and forward pass (no shadow pass, no transparent pass)
                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif
        
                // override sampleBakedGI - not used by Unlit
        		// When overriding GI, we need to force the isLightmap flag to make sure we don't add APV (sampled in the lightloop) on top of the overridden value (set at GBuffer stage)
        
                builtinData.emissiveColor = surfaceDescription.Emission;
        
                // Note this will not fully work on transparent surfaces (can check with _SURFACE_TYPE_TRANSPARENT define)
                // We will always overwrite vt feeback with the nearest. So behind transparent surfaces vt will not be resolved
                // This is a limitation of the current MRT approach.
                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif
        
                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif
        
                // TODO: We should generate distortion / distortionBlur for non distortion pass
                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif
        
                #ifndef SHADER_UNLIT
                // PostInitBuiltinData call ApplyDebugToBuiltinData
                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif
        
                RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS
            }
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassPathTracing.hlsl"
        
            // --------------------------------------------------
            // Visual Effect Vertex Invocations
        
        	#ifdef HAVE_VFX_MODIFICATION
                #if !defined(SHADER_STAGE_RAY_TRACING)
        	    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
                #else
                #endif
        	#endif
        
            ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    CustomEditorForRenderPipeline "Rendering.HighDefinition.HDUnlitGUI" "UnityEngine.Rendering.HighDefinition.HDRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}