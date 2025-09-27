-- Java
--[[ Installation
go install golang.org/x/tools/gopls@latest
brew install gopls
--]]
return {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = { ".git", "build.gradle", "build.gradle.kts", "build.xml", "pom.xml"},
  settings = {
  },
}
