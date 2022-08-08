GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

function checkEnv {
  if [[ -z $GUIX_EXTRA_PROFILES ]]; then
    echo -e "${RED}GUIX_EXTRA_PROFILES is not set, aborting${NC}"
    return 1;
  elif [[ -z $GUIX_MANIFESTS ]]; then
    echo -e "${RED}GUIX_MANIFESTS is not set, aborting${NC}"
    return 1;
  else
    return 0;
  fi
}

function installProfiles {
  for profile in $*; do
    profilePath="$GUIX_EXTRA_PROFILES/$profile"
    manifestPath=$GUIX_MANIFESTS/$profile.scm

    if [ -f $manifestPath ]; then
      echo -e "\n${GREEN}Installing profile:" $manifestPath "${NC}\n"

      mkdir -p $profilePath
      GUIX_PROFILE="$profilePath/$profile"
      guix package --manifest=$manifestPath --profile=$GUIX_PROFILE --substitute-urls="https://bordeaux.guix.gnu.org"

      # Source the new profile
      activateProfiles $profile
    else
      echo "No profile found at path" $manifestPath
    fi
  done
}

function activateProfiles {
  for profile in $*; do
    GUIX_PROFILE="$GUIX_EXTRA_PROFILES/$profile/$profile"
    if [ -f $GUIX_PROFILE/etc/profile ]; then
      . "$GUIX_PROFILE"/etc/profile

      exportToXDG $profile
    else
      echo -e "${RED}Couldn't find profile:" $GUIX_PROFILE/etc/profile "${NC}"
    fi
  done
}

function exportToXDG {
  for profile in $*; do
    GUIX_PROFILE="$GUIX_EXTRA_PROFILES/$profile/$profile"
    if [ -d $GUIX_PROFILE/share ]; then
      # Make applications in the profiles visible to X applications (this includes fonts)
      export XDG_DATA_DIRS="$XDG_DATA_DIRS:$GUIX_PROFILE/share"
    else
      echo -e "${RED}Couldn't find profile:" $GUIX_PROFILE"${NC}"
    fi
  done
}
