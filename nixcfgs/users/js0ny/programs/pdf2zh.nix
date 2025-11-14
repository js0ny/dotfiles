{pkgs, ...}: let
  imageTag = "ghcr.io/pdfmathtranslate/pdfmathtranslate-next";
  # version = "2.6.4";
  pdf2zhRunner = pkgs.writeShellScriptBin "pdf2zh" ''
    #!/usr/bin/env bash
    set -euo pipefail

    IMAGE_TAG="${imageTag}"

    OPENROUTER_API_KEY="$OPENROUTER_API_KEY"
    OPENROUTER_API_BASE="https://openrouter.ai/api/v1"
    OPENROUTER_DEFAULT_MODEL="google/gemini-2.5-flash"

    if ! podman image exists "$IMAGE_TAG"; then
      echo "[pdf2zh] Pulling image $IMAGE_TAG ..."
      podman pull "$IMAGE_TAG"
    fi

    podman run --rm -it \
      -p 7860:7860 \
      -v "$(pwd):/data" \
      -w /data \
      "$IMAGE_TAG" "pdf2zh" --openai-compatible-model $OPENROUTER_DEFAULT_MODEL --openai-compatible-base-url $OPENROUTER_API_BASE --openai-compatible-api-key $OPENROUTER_API_KEY "$@"
  '';
  descEn = "PDF scientific paper translation with preserved formats";
  descZh = "基于 AI 完整保留排版的 PDF 文档全文双语翻译";
in {
  services.podman.enable = true;

  # Declare an image, do not instantiate as a container
  services.podman.images.pdf2zh = {
    image = imageTag;
    description = " ${descEn} - ${descZh}，支持 Google/DeepL/Ollama/OpenAI 等服务，提供 CLI/GUI/Docker";
  };

  home.packages = [pdf2zhRunner];

  home.file.".local/share/kio/servicemenus/pdf2zh.desktop" = {
    enable = true; # TODO: Write a wrapper for status tracking
    executable = true;
    text = ''
      [Desktop Entry]
      Type=Service
      MimeType=application/pdf;
      Actions=translateToZh
      Icon=translate
      X-KDE-Priority=TopLevel
      X-KDE-StartupNotify=false

      [Desktop Action translateToZh]
      Name=翻译为中文
      Icon=translate
      Exec=pdf2zh --openaicompatible "%f"
    '';
  };
}
