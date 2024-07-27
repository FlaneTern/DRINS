workspace "DRINS"
    configurations { "Debug", "Release" }
    platforms { "x64" }
    architecture "x64"

    startproject "DRINS"



OutputDir = "%{cfg.buildcfg}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["MySQL"] = "afawefeawfe"


project "DRINS"
    location "DRINS"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. OutputDir .. "/%{prj.name}")
    objdir ("bin-itm/" .. OutputDir .. "/%{prj.name}")

    files{
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/res/**",
    }

    includedirs{
        "%{prj.name}/src",
        "Rapier/vendor/spdlog/include",
        "Rapier",
        "Rapier/src",
        "%{IncludeDir.glm}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.entt}"
    }
        
    links{
        "Rapier",
        "ImGui"
    }


    systemversion "latest"

    filter "configurations:Debug"
        defines "_DEBUG"
        runtime "Debug"
        symbols "on"
    
    filter "configurations:Release"
        defines "_RELEASE"
        runtime "Release"
        optimize "on"

    filter "system:windows"
        defines { "PLATFORM_WINDOWS" }
    
    filter "system:linux"
        defines { "PLATFORM_LINUX" }