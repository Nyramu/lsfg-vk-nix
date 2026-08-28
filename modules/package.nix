{
  perSystem =
    { lib, pkgs, ... }:

    let
      source = builtins.fromJSON (builtins.readFile ../source.json);

      src = pkgs.fetchgit {
        url = "https://git.lsfg-vk.dev/lsfg-vk.git";
        rev = source.rev;
        hash = source.hash;
        fetchSubmodules = true;
      };

      version = "2.0.0-git";
    in
    {
      packages.lsfg-vk = pkgs.llvmPackages.stdenv.mkDerivation {
        pname = "lsfg-vk";
        inherit version src;
        nativeBuildInputs = with pkgs; [
          llvmPackages.clang-tools
          llvmPackages.libllvm
          cmake
        ];
        buildInputs = with pkgs; [
          vulkan-headers
        ];
        cmakeFlags = [
          "-DLSFGVK_BUILD_UI=OFF"
          "-DLSFGVK_BUILD_CLI=OFF"
          "-DLSFGVK_LAYER_LIBRARY_PATH=${placeholder "out"}/lib/liblsfg-vk-layer.so"
        ];
        meta = {
          description = "Vulkan layer for frame generation (Requires owning Lossless Scaling)";
          homepage = "https://git.lsfg-vk.dev/lsfg-vk";
          license = lib.licenses.cc-by-nc-nd-40;
          platforms = lib.platforms.linux;
        };
      };

      packages.lsfg-vk-ui = pkgs.llvmPackages.stdenv.mkDerivation {
        pname = "lsfg-vk-ui";
        inherit version src;
        nativeBuildInputs = with pkgs; [
          llvmPackages.clang-tools
          llvmPackages.libllvm
          cmake
          qt6.wrapQtAppsHook
        ];
        buildInputs = with pkgs; [
          vulkan-headers
          qt6.qtbase
          qt6.qtdeclarative
        ];
        cmakeFlags = [
          "-DLSFGVK_BUILD_VK_LAYER=OFF"
          "-DLSFGVK_BUILD_UI=ON"
          "-DLSFGVK_BUILD_CLI=OFF"
          "-DLSFGVK_INSTALL_XDG_FILES=ON"
        ];
        meta = {
          description = "Graphical configuration interface for lsfg-vk";
          homepage = "https://git.lsfg-vk.dev/lsfg-vk";
          license = lib.licenses.cc-by-nc-nd-40;
          platforms = lib.platforms.linux;
          mainProgram = "lsfg-vk-ui";
        };
      };
    };
}
