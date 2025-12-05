# Only use this method in NixOS or non-FHS environment
# For FHS environments, see ./uv.nix
# Configure the options via environment variables:
# PDF2ZH_API_BASE: The base URL of the OpenRouter-compatible API (default: https://openrouter.ai/api/v1)
# PDF2ZH_MODEL: The model to use (default: google/gemini-2.5-flash)
# PDF2ZH_API_KEY or OPENROUTER_API_KEY: The API key for authentication (one of them must be set)
{pkgs, ...}: let
  imageTag = "ghcr.io/pdfmathtranslate/pdfmathtranslate-next";
  # version = "2.6.4";
  mkPdf2zh = {
    name,
    withEnv,
  }:
    pkgs.writeShellApplication {
      inherit name;

      runtimeInputs = [pkgs.podman];

      text = ''

        IMAGE_TAG="${imageTag}"

        if ! podman image exists "$IMAGE_TAG"; then
          echo "[pdf2zh] Pulling image $IMAGE_TAG ..."
          podman pull "$IMAGE_TAG"
        fi

        PODMAN_ENV_ARGS=()
        CMD_ARGS=()

        ${
          if withEnv
          then ''
            API_BASE="''${PDF2ZH_API_BASE:-https://openrouter.ai/api/v1}"
            MODEL="''${PDF2ZH_MODEL:-google/gemini-2.5-flash}"

            if [[ -n "''${PDF2ZH_API_KEY:-}" ]]; then
              API_KEY="$PDF2ZH_API_KEY"
            elif [[ -n "''${OPENROUTER_API_KEY:-}" ]]; then
              API_KEY="$OPENROUTER_API_KEY"
            else
              echo "Error: Neither OPENROUTER_API_KEY nor PDF2ZH_API_KEY is set." >&2
              echo "Please export one of them explicitly." >&2
              exit 1
            fi

            echo "[pdf2zh] Using Model: $MODEL"

            PODMAN_ENV_ARGS+=("-e" "OPENROUTER_API_KEY=$API_KEY")

            CMD_ARGS+=(
              "--openaicompatible"
              "--openai-compatible-model" "$MODEL"
              "--openai-compatible-base-url" "$API_BASE"
              "--openai-compatible-api-key" "$API_KEY"
            )
          ''
          else ""
        }

        exec podman run \
          --rm \
          -it \
          -p 7860:7860 \
          -v "$(pwd):/data" \
          -w /data \
          "''${PODMAN_ENV_ARGS[@]}" \
          "$IMAGE_TAG" \
          pdf2zh \
          "''${CMD_ARGS[@]}" \
          "$@"
      '';
    };
  pdf2zhRunner = mkPdf2zh {
    name = "pdf2zh";
    withEnv = true;
  };
  pdf2zhUnwrapped = mkPdf2zh {
    name = "pdf2zh-unwrapped";
    withEnv = false;
  };
  descEn = "PDF scientific paper translation with preserved formats";
  descZh = "基于 AI 完整保留排版的 PDF 文档全文双语翻译";
in {
  services.podman.enable = true;

  # Declare an image, do not instantiate as a container
  services.podman.images.pdf2zh = {
    image = imageTag;
    description = " ${descEn} - ${descZh}，支持 Google/DeepL/Ollama/OpenAI 等服务，提供 CLI/GUI/Docker";
  };

  home.packages = [pdf2zhRunner pdf2zhUnwrapped];

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
