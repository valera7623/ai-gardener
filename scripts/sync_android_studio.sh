#!/usr/bin/env bash
# Копирует проект в каталог, который открывает Android Studio на Windows.
# local.properties и ключ подписи на Windows не затираются.
set -euo pipefail

src="$(cd "$(dirname "$0")/.." && pwd)"
dest="/mnt/c/Users/valer/AndroidStudioProjects/ai_gardener"

mkdir -p "$dest"
rsync -a --delete \
  --exclude .git \
  --exclude .dart_tool \
  --exclude build \
  --exclude android/.gradle \
  --exclude android/local.properties \
  --exclude android/key.properties \
  --exclude 'android/*.jks' \
  --exclude 'android/*.keystore' \
  --exclude server/certs \
  --exclude .idea \
  "$src/" "$dest/"

cat > "$dest/android/local.properties" << 'EOF'
sdk.dir=C:\\Users\\valer\\AppData\\Local\\Android\\sdk
flutter.sdk=C:\\flutter
EOF

idea="$dest/.idea"
if [[ ! -f "$idea/ai_gardener.iml" ]]; then
  mkdir -p "$idea/libraries"
  cat > "$idea/.gitignore" << 'EOF'
/shelf/
/workspace.xml
EOF
  cat > "$idea/misc.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ProjectRootManager" version="2">
    <output url="file://$PROJECT_DIR$/out" />
  </component>
</project>
EOF
  cat > "$idea/modules.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project version="4">
  <component name="ProjectModuleManager">
    <modules>
      <module fileurl="file://$PROJECT_DIR$/.idea/ai_gardener.iml" filepath="$PROJECT_DIR$/.idea/ai_gardener.iml" />
    </modules>
  </component>
</project>
EOF
  cat > "$idea/ai_gardener.iml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <excludeFolder url="file://$MODULE_DIR$/.dart_tool" />
      <excludeFolder url="file://$MODULE_DIR$/.pub" />
      <excludeFolder url="file://$MODULE_DIR$/build" />
    </content>
    <orderEntry type="inheritedJdk" />
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="Dart SDK" level="project" />
    <orderEntry type="library" name="Flutter Plugins" level="project" />
  </component>
</module>
EOF
  cp /mnt/c/Users/valer/AndroidStudioProjects/skoraya_ryadom/.idea/libraries/Dart_SDK.xml \
    "$idea/libraries/Dart_SDK.xml"
fi

echo "Android Studio: C:\\Users\\valer\\AndroidStudioProjects\\ai_gardener"
