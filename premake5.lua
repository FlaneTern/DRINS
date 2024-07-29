workspace "DRINS"
    configurations { "Debug", "Release" }
    platforms { "x64" }
    architecture "x64"

    startproject "DRINS"


OutputDir = "%{cfg.buildcfg}-%{cfg.architecture}"

project "DRINS"
    location "DRINS"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. OutputDir .. "/%{prj.name}")
    objdir ("bin-itm/" .. OutputDir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/res/**"
    }

    includedirs { "%{prj.name}/src" }

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
        defines { "PLATFORM_WINDOWS", "STATIC_CONCPP" }
    
    filter "system:linux"
        defines { "PLATFORM_LINUX" }

    -- filter { "system:windows", "configurations:Debug" }

    filter { "system:windows", "configurations:Release" }
        includedirs { "Dependencies/mysql-connector-c++-8.4.0-winx64/include/jdbc" }
        libdirs { "Dependencies/mysql-connector-c++-8.4.0-winx64/lib64/vs14" }
        links { "mysqlcppconn-static" }


    -- filter { "system:linux", "configurations:Debug" }

    filter { "system:linux", "configurations:Release" }
        includedirs { "Dependencies/mysql-connector-c++-8.4.0-linux-glibc2.28-x86-64bit/include/jdbc" }
        libdirs { "Dependencies/mysql-connector-c++-8.4.0-linux-glibc2.28-x86-64bit/lib64" }
        links { "mysqlcppconn" }
        linkoptions { "-Wl,-rpath,../../../Dependencies/mysql-connector-c++-8.4.0-linux-glibc2.28-x86-64bit/lib64"}