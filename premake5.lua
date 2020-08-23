workspace "Proton"
  architecture "x64"

  configurations {
    "Debug",
    "Release",
    "Dist"
  }

outdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

indirs = {}
indirs["GLFW"] = "Proton/vendor/GLFW/include/"
indirs["Glad"] = "Proton/vendor/Glad/include"
indirs["ImGui"] = "Proton/vendor/ImGui"

include "Proton/vendor/premake5.glfw.lua"
include "Proton/vendor/Glad"
include "Proton/vendor/premake5.imgui.lua"

project "Proton"
  location "Proton"
  kind "ConsoleApp"
  language "C++"
  staticruntime "on"

  targetdir("bin/" ..outdir.. "/%{prj.name}")
  objdir("bin-int/" ..outdir.. "/%{prj.name}")

  files {
    "%{prj.name}/src/**.h",
    "%{prj.name}/src/**.cpp"
  }

  includedirs {
		"%{indirs.GLFW}",
		"%{indirs.Glad}",
		"%{indirs.ImGui}"
  }

  links { 
    "GLFW",
    "Glad",
    "ImGui"
  }

  filter "system:macosx"
    systemversion "latest"
    system "macosx"

    defines {
      "GL_SILENCE_DEPRECATION"
    }

    links {
      "Cocoa.framework",
      "IOKit.framework",
      "CoreVideo.framework",
      "OpenGL.framework"
    }
  
  filter "system:linux"
    system "linux"
    systemversion "latest"
    staticruntime "On"

    links {
      "pthread",
      "dl",
      "m",
      "GL",
      "X11"
    }

  filter "system:Windows"
    system "Windows"
    systemversion "latest"

    links {
      "OpenGL32.lib",
    }

  filter "configurations:Debug"
    symbols "On"

  filter "configurations:Release"
    optimize "On"

  filter "configurations:Dist"
    optimize "On"